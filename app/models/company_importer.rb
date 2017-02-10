require 'nokogiri'
require 'open-uri'

class CompanyImporter
  CATEGORIES = [  'mercados-e-supermercados/supermercados-atacadistas',
                  'mercados-e-supermercados/queijos-e-frios',
                  'mercados-e-supermercados/lojas-de-conveniencia',
                  'mercados-e-supermercados/mercearias-e-emporios',
                  'lanches-e-salgados/lanchonetes',
                  'lanches-e-salgados/cafeterias',
                  'instituicoes-religiosas/igrejas-e-templos',
                  'clinicas-medicos-e-terapias/clinicas-de-olhos',
                  'clinicas-medicos-e-terapias/clinicas-odontologicas',
                  'clinicas-medicos-e-terapias/clinicas-de-fisioterapia',
                  'institutos-de-beleza/saloes-de-beleza-e-cabeleireiros',
                  'institutos-de-beleza/spa',
                  'institutos-de-beleza/tatuagens-e-piercings',
                  'comercio-de-produtos-e-servicos/lojas-de-eletrodomesticos',
                  'comercio-de-produtos-e-servicos/empresas-variadas'
                ]
  SITE = "http://www.guiamais.com.br"
  PLACE = "joinville-sc"

  def self.import! i=1, f=2
    categories = CATEGORIES
    # categories = ['tudo-na-regiao']
    categories.each do |category|
      pages = (i..f)
      pages.each do |page|
        guia_mais(page, category).each_with_index do |company, i|
          cat = company[:category]
          if (company[:category] != company[:ancestor]) and (company[:ancestor].present?)
            ancestor_id = Category.where(name: company[:ancestor]).first_or_create.id
          else
            next
          end
          category = Category.where(name: company[:category], ancestor_id: ancestor_id).first_or_create
          c = category.companies.create(name: company[:name],
                                        slug: company[:name].parameterize,
                                        category_id: 1)
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

        page.search('.category a').each do |rcategory|
          scategory = rcategory.content
          company[:category] = scategory.gsub(/[\n\t\r]/, '') if scategory
        end

        page.search('.breadcrumb').each do |ancestor|
          anc = ancestor.search('li a')
          company[:ancestor] = anc[4].content if anc
        end
      end

      next unless company[:ancestor].present?
      next unless company[:category].present?

      companies << company unless company.empty?
    end

    return companies
  end
end
