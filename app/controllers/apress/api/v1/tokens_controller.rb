module Apress
  module Api
    module V1
      class TokensController < ApiController::Base
        skip_before_action :authenticate, only: :create

        def create
          @client = Apress::Api::Client.find_by_access_id!(params.require(:client_id))

          return bad_request if @client.refresh_token != params.require(:refresh_token)
          return forbidden if @client.refresh_token_expired?

          @client.regenerate_tokens!
        end

        ActiveSupport.run_load_hooks(:"apress/api/tokens_controller", self)
      end
    end
  end
end
