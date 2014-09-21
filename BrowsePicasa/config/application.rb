require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module BrowsePicasa
  class Application < Rails::Application
    config.assets.enabled = true
    config.autoload_paths = Dir["#{config.root}/lib", "#{config.root}/lib/**/"]
    config.i18n.enforce_available_locales = false
  end
end
