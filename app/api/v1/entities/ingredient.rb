# frozen_string_literal: true

module V1
  module Entities
    class Ingredient < Grape::Entity
      expose :id, expose_nil: false, documentation: { type: 'String', required: false }
      expose :slug,
             documentation: {
               type: 'String',
               desc: 'Unique parameterized value for each ingredient'
             }, expose_nil: false
      expose :title,
             documentation: {
               type: 'String',
               desc: 'Title for ingredient, unique field',
               required: true
             }, expose_nil: false
      expose :description,
             documentation: {
               type: 'String',
               desc: 'Ingredient description',
               required: true
             }, expose_nil: false
      end
    end
  end
end
