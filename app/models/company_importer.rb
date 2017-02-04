class CompanyImporter
  def self.import! i=1, f=2
    pages = (i..f)
    pages.each do |page|
      guia_mais(page).each_with_index do |company, i|
        cat = company[:category]
        if (company[:category] != company[:ancestor]) and (company[:ancestor].present?)
          ancestor_id = Category.where(name: company[:ancestor]).first_or_create.id
        end
        category = Category.where(name: company[:category], ancestor_id: ancestor_id).first_or_create
        c = category.companies.create(name: company[:name],
                                      slug: company[:name].parameterize,
                                      category_id: 1)
        if c
          c.create_profile(address: company[:address],
                           phone: company[:phone],
                           city: company[:city],
                           uf: company[:uf])
        end
      end
    end
  end

  def self.guia_mais page
    require 'nokogiri'
    require 'open-uri'

    site = "http://www.guiamais.com.br"
    place = "joinville-sc"
    categories = ['tudo-na-regiao']

    companies = []

    print "Lendo site: #{site}/#{place}\n"
    categories.each do |category|
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

        companies << company unless company.empty?
      end
    end

    return companies
  end
end
