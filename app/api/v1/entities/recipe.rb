# frozen_string_literal: true

module V1
  module Entities
    class Recipe < Grape::Entity
      expose :id, expose_nil: false, documentation: { type: 'String', required: false }
      expose :slug,
             documentation: {
               type: 'String',
               desc: 'Unique parameterized value for each recipe'
             }, expose_nil: false
      expose :title,
             documentation: {
               type: 'String',
               desc: 'Title for recipe, unique field',
               required: true
             }, expose_nil: false
      expose :description,
             documentation: {
               type: 'String',
               desc: 'A short description for recipe',
               required: true
             }, expose_nil: false
      expose :image_url,
             documentation: {
               type: 'String',
               desc: 'Image Url for recipe',
               required: true
             }, expose_nil: false
      expose :duration_in_minutes,
             documentation: {
               type: 'Integer',
               desc: 'Duration in Minutes for recipe',
               required: true
             }, expose_nil: false
      expose :servings,
             documentation: {
               type: 'Integer',
               desc: 'No of Servings',
               required: true
             }, expose_nil: false

      expose :is_favorite do |recipe, options|
        options[:current_user] ?
          recipe.liked_users.where(id: options[:current_user].id).exists? : false
      end
      expose :author, using: V1::Entities::User

      expose :ingredient_details
      expose :instructions
    end
  end
end
