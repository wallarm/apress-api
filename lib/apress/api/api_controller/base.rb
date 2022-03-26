module Apress
  module Api
    module ApiController
      class Base < ActionController::Metal
        abstract!

        include AbstractController::Rendering
        include ActionView::Rendering
        include ActionController::UrlFor
        include ActionController::Redirecting
        include ActionController::Rendering
        include ActionController::Renderers::All
        include ActionController::ConditionalGet
        include ActionController::ForceSSL if Rails::VERSION::MAJOR == 6 && Rails::VERSION::MINOR == 0
        include AbstractController::Callbacks
        include ActionController::Rescue
        include ActionController::Instrumentation
        include ActionController::StrongParameters if Rails::VERSION::MAJOR >= 4
        include ActionController::MimeResponds
        include ActionController::ImplicitRender
        include ActionController::Helpers
        include ActionController::Caching
        include AbstractController::AssetPaths
        include AbstractController::Callbacks

        if defined?(StrongParameters::VERSION) &&
          Gem::Version.new(StrongParameters::VERSION) <= Gem::Version.new("0.2.3")
          include ActionController::StrongParameters
        end

        # :nocov:
        if defined?(::NewRelic)
          include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

          #require "new_relic/agent/instrumentation/rails/action_controller"

          include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
        end
        # :nocov:

        extend Compatibility
        include Rescue
        include Responds
        include Authentification
        include Pagination

        ActiveSupport.run_load_hooks(:action_controller, self)
        ActiveSupport.run_load_hooks(:"apress/api/api_controller", self)
      end
    end
  end
end
