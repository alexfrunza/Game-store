Rails.application.routes.draw do
  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  put 'user/:id/make_admin' => 'users#make_admin', :as => "make_admin"
  put 'user/:id/remove_admin' => 'users#remove_admin', :as => "remove_admin"

  root to: 'home#index'
  resources :games, :about, :items
  resources :admin, only: [:index]

  namespace :admin do
    resources :games, :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
