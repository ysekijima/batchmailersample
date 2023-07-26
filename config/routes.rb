Rails.application.routes.draw do
  get 'home/index'
  post 'home/post1'
  post 'home/post2'
  root 'home#index'

  resources :posts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
