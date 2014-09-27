require 'yaml'

GOOGLE_AUTH_CONFIG = YAML::load_file("#{Rails.root}/config/client_secrets.yml")
