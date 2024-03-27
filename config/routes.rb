Rails.application.routes.draw do
  get 'sandbox/index'
  post 'sandbox/post1'
  post 'sandbox/post2'
  get 'home/index'
  post 'home/post1'
  post 'home/post2'
  post 'home/post3'
  root 'home#index'
  get 'home/download'

  resources :posts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
