# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module V1
  class Feedbacks < Grape::API
    include V1::SharedContext

    namespace :feedback do
      desc 'Create feedback'

      params do
        requires :category, type: String
        requires :description, type: String
        optional :user_id, type: Integer
      end

      post :new do
        Feedback.create!(declared(params))

        { success: true }
      end
    end
  end
end
