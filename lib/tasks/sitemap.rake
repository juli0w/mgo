require 'big_sitemap'

namespace :custom do
  desc "Generate sitemap"
  task :sitemap => :environment do
    include Rails.application.routes.url_helpers

    sitemap_options = {
      document_root: Rails.root.join('public'),
      url_options: { host: 'weekz.com.br' },
      ping_google: true,
      ping_bing: true,
      gzip: true
    }

    if Rails.env.development?
      sitemap_options = {
        document_root: Rails.root.join('public'),
        url_options: { host: 'localhost', port: 3000 },
        ping_google: false,
        ping_bing: false,
        gzip: false
      }
    end

    BigSitemap.generate(sitemap_options) do
      add root_path
      add contact_path
      add offers_path
      # add partner_path, :priority => 0.96
      # add institutional_path, :priority => 0.80

      Company.find_each do |company|
        add "/#{company.slug}", :last_modified => company.updated_at
        add "/#{company.slug}/review"

        company.profile.pages.each do |page|
          add "/#{company.slug}/#{page.slug}"
        end

        blog = company.profile.pages.select {|a| a.pageable_type == "BlogPage" }
        if blog.any?
          # add "/#{company.slug}/#{blog.first.slug}"

          company.articles.each do |article|
            add "/#{company.slug}/#{blog.first.slug}/#{article.slug}"
          end
        end
      end
    end
  end
end
