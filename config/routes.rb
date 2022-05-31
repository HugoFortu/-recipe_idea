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
    resources :ingredient_categories, only: [:index]
  end
  resources :lists,  only: [:show, :destroy] do
    resources :list_ingredients, only: :update
  end
end
