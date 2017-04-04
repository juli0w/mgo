require 'nokogiri'
require 'open-uri'

class CompanyImporter
  CATEGORIES = [
    { root: 'produtos-farmaceuticos-e-cosmeticos',
      name: 'Beleza', categories:
        [ { category: 'Cosmésticos e perfumaria' } ] },
    { root: 'noite', name: 'Noturno',
      categories:
        [ { category: 'moteis',
            name: "Motéis" },
          { category: 'boates-e-night-clubs',
            name: 'Casas noturnas' } ] },
    { root: 'mercados-e-supermercados', name: 'Mercados',
      categories:
        [ { category: 'supermercados-atacadistas',
          name: 'Supermercados atacadistas' },
          { category: 'queijos-e-frios',
          name: 'Queijos e frios' },
          { category: 'lojas-de-conveniencia',
          name: 'Lojas de conveniência' },
          { category: 'mercearias-e-emporios',
          name: 'Mercearias e empórios' } ] },
    { root: 'lanches-e-salgados', name: 'Alimentação',
      categories:
        [ { category: 'lanchonetes',
          name: 'Lanchonetes' },
          { category: 'cafeterias',
          name: 'Cafeterias' } ] },
    { root: 'instituicoes-religiosas', name: 'Religião',
      categories:
        [ { category: 'igrejas-e-templos',
          name: 'Igrejas e templos' } ] },
    { root: 'clinicas-medicos-e-terapias', name: 'Saúde',
      categories:
        [ { category: 'clinicas-de-olhos',
            name: 'Clínicas de olhos' },
          { category: 'clinicas-odontologicas',
          name: 'Clínicas odontológicas' },
          { category: 'clinicas-de-fisioterapia',
          name: 'Clínicas de fisioterapia' } ] },
    { root: 'institutos-de-beleza', name: 'Beleza',
      categories:
        [ { category: 'saloes-de-beleza-e-cabeleireiros',
          name: 'Cabeleireiros' },
          { category: 'spa',
          name: 'Spa' },
          { category: 'tatuagens-e-piercings',
          name: 'Tatuagem e piercing' } ] },
    { root: 'comercio-de-produtos-e-servicos',
      name: 'Comércio', categories:
        [ { category: 'lojas-de-eletrodomesticos',
          name: 'Eletrodomésticos' } ] },
    { root: 'produtos-farmaceuticos-e-cosmeticos', name: 'Saúde',
      categories:
        [ { category: 'farmacias-e-drogarias', name: 'Drogarias' },
          { category: 'farmacias-de-manipulacao', name: 'Farmácias de manipulação' } ] } ]

  # CATEGORIES = [  'mercados-e-supermercados/supermercados-atacadistas',
  #                 'mercados-e-supermercados/queijos-e-frios',
  #                 'mercados-e-supermercados/lojas-de-conveniencia',
  #                 'mercados-e-supermercados/mercearias-e-emporios',
  #                 'lanches-e-salgados/lanchonetes',
  #                 'lanches-e-salgados/cafeterias',
  #                 'instituicoes-religiosas/igrejas-e-templos',
  #                 'clinicas-medicos-e-terapias/clinicas-de-olhos',
  #                 'clinicas-medicos-e-terapias/clinicas-odontologicas',
  #                 'clinicas-medicos-e-terapias/clinicas-de-fisioterapia',
  #                 'institutos-de-beleza/saloes-de-beleza-e-cabeleireiros',
  #                 'institutos-de-beleza/spa',
  #                 'institutos-de-beleza/tatuagens-e-piercings',
  #                 'comercio-de-produtos-e-servicos/lojas-de-eletrodomesticos'
  #                 # 'comercio-de-produtos-e-servicos/empresas-variadas'
  #               ]

  # SITE = "http://www.gudsidadmdais.com.br"
  PLACE = "joinville-sc"

  def self.reset!
    Review.delete_all
    Profile.delete_all
    Map.delete_all
    Company.delete_all
    Category.delete_all
  end

  def self.import! i=1, f=2
    reset!
    CATEGORIES.each do |root|
      root[:categories].each do |category|
        category_link = "#{root[:root]}/#{category[:category]}"
        pages = (i..f)
        pages.each do |page|
          guia_mais(page, category_link).each_with_index do |company, i|
            ancestor_id = Category.where(name: root[:name]).first_or_create.id
            cat = Category.where(name: category[:name], ancestor_id: ancestor_id).first_or_create
            c = cat.companies.where(name: company[:name],
                                    slug: company[:name].parameterize).first_or_create
            if c
              city_id = City.where(name: company[:city].upcase).first_or_create.id
              uf_id = Uf.where(name: company[:uf].upcase).first_or_create.id

              c.create_profile(address: company[:address],
                               phone: company[:phone],
                               city_id: city_id,
                               uf_id: uf_id)
            end
          end
        end
      end
    end
  end

  def self.guia_mais page, category
    site = SITE
    place = PLACE

    companies = []

    print "Lendo site: #{site}/#{place}\n"

    link = "#{site}/#{place}/#{category}/?page=#{page}"
    url = URI.encode(link)
    doc = Nokogiri::HTML(open(url, "User-Agent" => "MSIE"))
    doc.encoding = 'utf-8'

    print "\nLendo página: #{page} (#{link})\n\n"

    doc.search('.free').each do |rcompany|
      company = {}

      rcompany.search('h2.advTitle').each do |rname|
        company[:name] = rname.content.gsub(/[\n\t\r]/, '')
        print "Empresa: #{company[:name]}\n"
        rname.search('a').each do |rurl|
          company[:url] = rurl[:href]
        end
      end

      next unless company[:name].present?

      rcompany.search('address').each do |raddress|
        radd = raddress.search('span').search('span')
        ad = radd[0].content.split("\r\n\t\t\t\t\t\t\t\t\t\t\t\t\t") if radd[0]
        address = ad[1] if ad[1]
        address += " #{ad[2]}" if ad[2]
        company[:address] = address if address

        city = radd[1].content if radd[1]
        company[:city] = city

        uf = radd[2].content if radd[2]
        company[:uf] = uf if radd[2]
      end

      next unless company[:address].present?
      next unless company[:city].present?
      next unless company[:uf].present?

      if company[:url]
        purl = site + company[:url]
        page = Nokogiri::HTML(open(purl, "User-Agent" => "MSIE"))
        page.encoding = 'utf-8'
        page.search('.phone').each do |rphone|
          phone = rphone.content
          company[:phone] = phone.gsub!(/[^0-9A-Za-z. ]/, '') if phone
        end
      end

      companies << company unless company.empty?
    end

    return companies
  end
end
