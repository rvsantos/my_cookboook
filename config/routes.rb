Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root to: 'recipes#index'

  resources :recipes, only: %i[index new create edit update show] do
    post 'add_list', on: :member
  end
  resources :recipe_lists, only: %i[new create show]
  resources :recipe_types, only: %i[new create]

  get 'my_recipes', to: 'recipes#my_recipes'
  get 'my_list', to: 'recipe_lists#my_list'
  get 'search', to: 'recipes#search'
  get 'list_pending', to: 'recipes#list_pending'
  post 'published', to: 'recipes#published'

end
