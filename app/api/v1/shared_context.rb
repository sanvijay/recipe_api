# frozen_string_literal: true

module V1
  module SharedContext
    extend ActiveSupport::Concern

    included do
      helpers Doorkeeper::Grape::Helpers
      helpers Grape::Pagy::Helpers

      version 'v1', using: :header, vendor: 'recipe-mobile'
      format :json

      # Kind of hacky, but backwards compatible with GraphQL API. We can potentially do something more
      # elegant once migration is complete
      rescue_from ActiveRecord::RecordInvalid do |error|
        exceptions = error.record.errors.messages.map do |attr, msg|
          { code: nil, key: attr.to_s.camelize(:lower), messages: msg }
        end
        error!(errors: exceptions)
      end

      rescue_from ActiveRecord::RecordNotFound do |error|
        error!(message: error.message, status: 404)
      end

      helpers do
        def current_user
          current_resource_owner
        end

        def current_resource_owner
          User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        end
      end
    end
  end
end
