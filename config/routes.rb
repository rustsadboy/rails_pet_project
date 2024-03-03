# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resource :users, only: %i[update create destroy] do
      resource :emails, only: :create, module: :users do
        resources :confirmations, only: :index, module: :emails
      end
    end

    resources :users, only: %i[index show] do
      get :followings, :followers
    end

    resources :sessions, only: :create
    resource :relationships, only: %i[create destroy]
    resources :recovery_passwords, only: %i[create index]
    resources :audios, only: :create

    resources :videos, only: :create
    resources :test_push_notifications, only: :index
    resources :oauths, only: :create
  end
end
