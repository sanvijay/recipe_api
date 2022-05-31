# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module V1
  class Users < Grape::API
    include V1::SharedContext

    namespace :user do
      desc 'View user details' do
        success V1::Entities::User
      end

      get '/current' do
        doorkeeper_authorize!

        present current_user, with: V1::Entities::User
      end

      desc 'Update User'

      params do
        optional :first_name, type: String
        optional :last_name, type: String
        optional :email, type: String
      end

      post '/update' do
        doorkeeper_authorize!

        user = User.find(current_user.id)
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.save!

        { success: true }
      end
    end
  end
end
