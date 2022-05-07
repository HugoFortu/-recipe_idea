Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: "recipes#index"
  resources :recipes, except: :index
  # resources :users, only: :show
  resources :user_recipes, only: [:show, :index]
  resources :ingredient_categories, only: [:index]
end
