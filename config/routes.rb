Rails.application.routes.draw do
  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  put 'user/:id/make_admin' => 'users#make_admin', :as => "make_admin"
  put 'user/:id/remove_admin' => 'users#remove_admin', :as => "remove_admin"

  post 'games/:id/borrow_game' => 'games#borrow_game', :as => "borrow_game"
  put 'games/:id/return_game' => 'games#return_game', :as => "return_game"

  root to: 'home#index'
  resources :games, :about, :items, :account
  resources :admin, only: [:index]

  namespace :admin do
    resources :games, :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
