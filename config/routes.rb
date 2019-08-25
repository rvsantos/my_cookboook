Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root to: 'recipes#index'

  get 'recipes/search'
  resources :recipes, only: %i[index new create edit update show]
  resources :recipe_types, only: %i[new create]
end
