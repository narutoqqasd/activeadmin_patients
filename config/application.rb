require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Patients
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.time_zone = 'Asia/Shanghai'
    config.active_record.default_timezone = :local
    config.i18n.available_locales = [:'zh-CN', :en]

    config.before_configuration do
      I18n.load_path += Dir[Rails.root.join('config', 'locales','*.{rb,yml}').to_s]
      config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
      #I18n.default_locale = :'zh-CN'
      I18n.reload!
      config.i18n.reload!
    end

  end
end
