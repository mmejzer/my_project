Rails.application.routes.draw do

  get 'draft/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :articles

  #get "/articles", to: "articles#index"
  get "/draft", to: "draft#index"

  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy'  
  end
end