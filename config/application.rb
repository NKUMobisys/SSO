require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SSO
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join('lib', 'extensions')
    config.eager_load_paths << Rails.root.join('lib', 'extensions')
    config.generators do |g|
      # add option to avoid generating scaffold.css #20479
      # https://github.com/rails/rails/pull/20479
      # g.scaffold_stylesheet     false
    end
    config.i18n.default_locale = :"zh-CN"
    config.i18n.available_locales  = :"zh-CN"

  end
end
