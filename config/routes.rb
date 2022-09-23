# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :articles do
    resources :comments, only: %i[create destroy]
  end

  get '/draft', to: 'draft#index'
  get 'contacts/about_me', to: 'contacts#about_me'
  get '/contacts', to: 'contacts#new'
  # get '/articles/:article_id/comments/edit(.:format)', to: 'comments#edit'=end

  resources :contacts, only: [:create]

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
