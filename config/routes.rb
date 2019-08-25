Rails.application.routes.draw do
  # get 'home/index'
  root to: 'recipes#index'

  resources :recipes, only: %i[index new create show]
end
