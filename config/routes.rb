Rails.application.routes.draw do
  # get 'home/index'
  root to: 'recipes#index'

  resources :recipes, only: %i[index show]
end
