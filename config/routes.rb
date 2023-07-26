Rails.application.routes.draw do
  get 'home/index'
  get 'home/post1'
  get 'home/post2'
  root 'home#index'

  resources :posts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
