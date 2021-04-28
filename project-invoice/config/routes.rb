Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # post :users, to: 'users#create'
      # get :users, to: 'users#index'
      post :login, to: 'auth#create'
      resources :invoices
      post :quotation, to: 'invoices#quotation'
      resources :users
    end
  end
end
