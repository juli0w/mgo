require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ActsAsTaggableOn.remove_unused_tags = true
ActsAsTaggableOn.force_lowercase = true
ActsAsTaggableOn.force_parameterize = true

module Meuguia
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.i18n.default_locale = :"pt-BR"
    config.encoding = "utf-8"

    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
