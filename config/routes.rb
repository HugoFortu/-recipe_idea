Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: "recipes#index"
  resources :recipes, except: [:new, :edit, :update, :destroy]
  # resources :users, only: :show
  resources :user_recipes, only: [:show, :index, :destroy, :create] do
    member do
      get :add_to_list
    end
  end
  resources :ingredient_categories, only: [:index]
  resources :lists,  only: [:show]
end
