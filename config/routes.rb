Rails.application.routes.draw do
  get 'api/query_user'

  get 'api/query_all_user'

  root to: "main#index"
  get 'main/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end