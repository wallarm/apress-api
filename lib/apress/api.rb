require 'rails'
require "active_support"
require "multi_json"
require "jbuilder"
require "api_auth"
require "attr_extras"
require "addressable"
require 'interactor'
require 'pundit'
require 'swagger/blocks'
require 'apress/documentation'
require "apress/api/extensions"
require "apress/api/engine"

module Apress
  module Api
    module Swagger
      def self.const_missing(name)
        ::Apress::Documentation::Swagger.const_get(name)
      end
    end
  end
end
