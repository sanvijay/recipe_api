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

      desc 'Update User' do
        success V1::Entities::User
      end

      params do
        optional :first_name, type: String
        optional :last_name, type: String
        optional :email, type: String
      end

      post '/update' do
        doorkeeper_authorize!
        recipe = Recipe.find_by(slug: params[:slug], author_id: current_user.id)

        if recipe
          recipe.assign_attributes(params)
          recipe.save!
        end

        present recipe, with: V1::Entities::Recipe
      end
    end
  end
end
