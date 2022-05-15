# frozen_string_literal: true

# require 'grape-swagger'

# Class to mount our various API routes. Anything added to the helper block
# is added to the global scope for all routes
class BaseAPI < Grape::API
  mount V1::Oauth
  mount V1::Recipes

  # add_swagger_documentation hide_documentation_path: true,
  #                           models: [],
  #                           api_version: 'v1',
  #                           info: {
  #                             title: 'API Documentation',
  #                             description: "REST-ish endpoints for Recipe's mobile application"
  #                           }
end
