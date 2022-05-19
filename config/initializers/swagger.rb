# frozen_string_literal: true

if Rails.env.development?
	GrapeSwaggerRails.options.url      = '/swagger_doc.json'
	GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'
	GrapeSwaggerRails.options.app_name = 'Recipe API'
	GrapeSwaggerRails.options.api_auth = 'bearer'
	GrapeSwaggerRails.options.api_key_name = 'Authorization'
	GrapeSwaggerRails.options.api_key_type = 'header'
end
