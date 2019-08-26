Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root to: 'recipes#index'

  get 'recipes/search'
  get 'recipes/list'

  get 'users/my_recipes'
  get 'users/my_recipe_list'

  resources :recipe_lists, only: %i[new create show]
  resources :recipes, only: %i[index new create edit update show]
  resources :recipe_types, only: %i[new create]
end
