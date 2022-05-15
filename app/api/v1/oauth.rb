# frozen_string_literal: true
require 'doorkeeper/grape/helpers'

module V1
  class Oauth < Grape::API
    include V1::SharedContext

    # Doorkeeper-generated routes, here for documentation and testing
    resources :oauth do
      # POST /oauth/token
      desc 'Doorkeeper route for login and renewal, returns an access token'
      params do
        requires :grant_type,
                 type: String,
                 values: %w[password refresh_token]
        requires :client_id,
                 type: String,
                 values: [ENV['APPLICATION_ID']]
        requires :client_secret,
                 type: String,
                 values: [ENV['APPLICATION_SECRET']]
        optional :email,
                 allow_blank: false,
                 type: String,
                 desc: 'User email, should be unique, not needed for refresh.'
        optional :password, allow_blank: false, type: String, desc: 'User password, not needed for refresh.'
        optional :refresh_token, allow_blank: false, type: String, desc: 'Refresh token value to be renewed.'
      end

      post :token do # rubocop:disable Lint/EmptyBlock
      end

      # POST /oauth/revoke
      desc 'Doorkeeper route for token revocation, used for logout'
      params do
        requires :client_id,
                 type: String,
                 values: [ENV['APPLICATION_ID']]
        requires :client_secret,
                 type: String,
                 values: [ENV['APPLICATION_SECRET']]
        requires :token, allow_blank: false, type: String, desc: 'Token to be revoked.'
      end

      post :revoke do # rubocop:disable Lint/EmptyBlock
      end
    end
  end
end
