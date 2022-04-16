require 'rails/engine'

module Apress
  module Api
    class Engine < Rails::Engine
      config.autoload_paths << config.root.join("lib")
      config.eager_load_paths << config.root.join("lib")

      Apress::Documentation.add_load_path(config.root.join('app/docs'))

      config.api = {
        secret_token_ttl: 1.hour,
        refresh_token_ttl: 1.week,
        v1_doc_path: 'docs/swagger/v1.json',
        version: '1.0.0',
        title: 'Wallarm API',
        description: 'Wallarm API',
        terms_of_service: 'None',
        contact_name: 'Wallarm Team',
        base_path: '/api/v1'
      }

      initializer "apress-api", before: :load_init_rb do |app|
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)

        ::MultiJson.use :oj

        JbuilderTemplate.send :include, Apress::Api::Extensions::Jbuilder::JbuilderTemplate
      end

      initializer "apress-api-factories", after: "factory_bot.set_factory_paths" do
        if defined?(FactoryBot)
          FactoryBot.definition_file_paths.unshift root.join("spec", "factories")
        end
      end
    end
  end
end
