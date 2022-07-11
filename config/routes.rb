Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :articles

  get "/draft", to: "draft#index"
  get 'draft/index'

  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy'  
  end
end