require 'big_sitemap'

namespace :custom do
  desc "Generate sitemap"
  task :sitemap => :environment do
    include Rails.application.routes.url_helpers

    sitemap_options = {
      document_root: Rails.root.join('public'),
      url_options: { host: 'www.weekz.com.br' },
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
      add root_path, :priority => 1
      add contact_path, :priority => 0.75
      add offers_path, :priority => 0.95
      add partner_path, :priority => 0.96
      # add institutional_path, :priority => 0.80

      Company.find_each do |company|
        add "/#{company.slug}", :last_modified => company.updated_at
        add "/#{company.slug}/review"
      end
    end
  end
end
