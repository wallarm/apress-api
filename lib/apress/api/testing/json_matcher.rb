require 'json-schema'
require 'rspec/expectations'

module Apress
  module Api
    module Testing
      module JsonMatcher
        RSpec::Matchers.define :match_json_schema do |schema, options|
          match do |json|
            options = {strict: true}.merge!(options || {})
            JSON::Validator.validate!(schema, json, options)
          end
        end
      end
    end
  end
end
