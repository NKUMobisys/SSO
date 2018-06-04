Rails.application.routes.draw do
  get 'users/index'

  get 'api/query_user'

  get 'api/query_all_user'

  root to: "main#index"
  get 'main/index'


  # match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
