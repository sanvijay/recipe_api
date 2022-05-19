# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  mount BaseAPI, at: '/'
  get '/', to: 'application#index'
  mount GrapeSwaggerRails::Engine => '/swagger' if Rails.env.development?
end
