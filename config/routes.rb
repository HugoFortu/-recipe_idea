Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: "recipes#index"
  resources :recipes, except: :index do
    collection do
      get :my_recipes
    end
  end

end
