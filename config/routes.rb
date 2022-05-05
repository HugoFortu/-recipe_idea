Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: "recipes#index"
  resources :recipes, except: :index
  resources :users, only: :show do
    resources :user_recipes, only: :index
  end
  resources :user_recipes, only: :show
end
