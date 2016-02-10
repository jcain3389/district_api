Rails.application.routes.draw do
  devise_for :user, only: []
  
  namespace   :v1, defaults: { format: :json } do
    resource  :login,   only: [:create], controller: :sessions
    resources :users,   only: [:create]
    resources :stories, only: [:index, :show, :create]
    resources :food_truck_vendors, only: [:index]
  end
end
