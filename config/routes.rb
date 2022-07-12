Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :articles

  get "/draft", to: "draft#index"
  get 'home/about_me', to: 'home#about_me'
  get 'home/contact_with_me', to: 'home#contact_with_me'

  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy'  
  end
end