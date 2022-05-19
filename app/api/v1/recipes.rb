# frozen_string_literal: true
require 'doorkeeper/grape/helpers'

module V1
  class Recipes < Grape::API
    include V1::SharedContext

    namespace :recipe do
      desc 'View all recipes' do
        success V1::Entities::Recipe
      end

      params do
        optional :title, type: String
        use :pagy,
            items_param: :page_size,
            items: 10
      end

      get '/list' do
        recipes = Recipe.all.order(created_at: :desc)

        if params[:title].present?
          recipes = recipes.where('LOWER(title) LIKE ?', "%#{params[:title].downcase}%")
        end

        present pagy(recipes), with: V1::Entities::Recipe, current_user: current_user
      end

      desc 'View all created recipes' do
        success V1::Entities::Recipe
      end

      params do
        optional :title, type: String
        use :pagy,
            items_param: :page_size,
            items: 10
      end

      get '/created_list' do
        doorkeeper_authorize!

        recipes = current_user.created_recipes

        if params[:title].present?
          recipes = recipes.where('LOWER(title) LIKE ?', "%#{params[:title].downcase}%")
        end

        present pagy(recipes), with: V1::Entities::Recipe, current_user: current_user
      end

      desc 'Search recipes' do
        success V1::Entities::Recipe
      end

      params do
        optional :title, type: String
        optional :ingredients, type: String
        optional :duration_in_minutes, type: Integer
        use :pagy,
            items_param: :page_size,
            items: 10
      end

      get '/search' do
        recipes = Recipe.all.order(created_at: :desc)

        if params[:title].present?
          recipes = recipes.where('LOWER(title) LIKE ?', "%#{params[:title].downcase}%")
        end

        if params[:ingredients].present?
          recipes = recipes.where(
            'ingredients @> ARRAY[:ingredients]::varchar[]',
            { ingredients: params[:ingredients].split(',').map(&:strip).map(&:downcase) }
          )
        end

        if params[:duration_in_minutes].present?
          recipes = recipes.where('duration_in_minutes < ?', params[:duration_in_minutes])
        end

        present pagy(recipes), with: V1::Entities::Recipe
      end

      desc 'Get recipe details based on parameterized string' do
        success V1::Entities::Recipe
      end

      route_param :slug, type: String, desc: 'Unique parameterized value for each recipe',
                         required: true do
        get '/' do
          recipe_details = Recipe.find_by(slug: params[:slug])

          present recipe_details, with: V1::Entities::Recipe, current_user: current_user
        end
      end

      desc 'View all favorite recipes' do
        success V1::Entities::Recipe
      end

      params do
        optional :title, type: String
        use :pagy,
            items_param: :page_size,
            items: 10
      end

      get '/favorite_list' do
        doorkeeper_authorize!

        recipes = current_user.favorite_recipes

        if params[:title].present?
          recipes = recipes.where('LOWER(title) LIKE ?', "%#{params[:title].downcase}%")
        end

        present pagy(recipes), with: V1::Entities::Recipe, current_user: current_user
      end

      desc 'Create Recipe' do
        success V1::Entities::Recipe
      end

      params do
        requires :title, type: String
        requires :description, type: String
        requires :image_url, type: String
        requires :duration_in_minutes, type: Integer
        requires :servings, type: Integer

        requires :ingredient_details, type: Array[JSON] do
          requires :title,    type: String
          requires :quantity, type: Float
          requires :unit,     type: String
        end

        requires :instructions, type: Array[JSON] do
          requires :value,     type: String
          requires :duration,  type: Float
          requires :unit,      type: String
          requires :order,     type: Integer
          optional :image_url, type: String
        end
      end

      post :new do
        doorkeeper_authorize!

        recipe = current_user.created_recipes.create!(declared(params))
        present recipe, with: V1::Entities::Recipe
      end

      desc 'Update Recipe' do
        success V1::Entities::Recipe
      end

      params do
        optional :title, type: String
        optional :description, type: String
        optional :image_url, type: String
        optional :duration_in_minutes, type: Integer
        optional :servings, type: Integer

        optional :ingredient_details, type: Array[JSON] do
          requires :title,    type: String
          requires :quantity, type: Float
          requires :unit,     type: String
        end

        optional :instructions, type: Array[JSON] do
          optional :value,     type: String
          optional :duration,  type: Float
          optional :unit,      type: String
          optional :order,     type: Integer
          optional :image_url, type: String
        end
      end

      route_param :slug, type: String, desc: 'Unique parameterized value for each recipe',
                         required: true do
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

      desc 'Set favorite' do
        success V1::Entities::Recipe
      end

      params do
        requires :flag, type: Boolean
      end

      route_param :slug, type: String, desc: 'Unique parameterized value for each recipe',
                         required: true do
        post '/set_favorite' do
          doorkeeper_authorize!

          recipe = Recipe.find_by(slug: params[:slug])

          if params[:flag]
            recipe.favorites.find_or_create_by(user_id: current_user.id)
          else
            recipe.favorites.find_by(user_id: current_user.id)&.destroy
          end

          present recipe, with: V1::Entities::Recipe, current_user: current_user
        end
      end
    end
  end
end
