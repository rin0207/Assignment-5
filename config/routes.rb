Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
     resource :favorites, only: [:create, :destroy]
  root :to => 'homes#top'
  get 'home/about' => 'homes#about'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

end