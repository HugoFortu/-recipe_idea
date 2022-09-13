Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: "users/registrations"
      }
  root to: "recipes#index"
  resources :recipes, except: [:new, :edit, :update, :destroy]
  resources :user_recipes, only: [:show, :index, :destroy, :create] do
    member do
      get :add_to_list
    end
  end
  resources :user, only: :show do
    resources :user_categories, only: [:index, :new, :create]
  end
  resources :user_categories, only: [:edit, :update, :delete]
  resources :ingredient_categories, only: [:edit, :update]
  resources :lists,  only: [:show, :destroy] do
    resources :list_ingredients, only: :update
  end
  resources :shops, only: [:new, :create]
end
