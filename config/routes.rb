Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  root :to => 'homes#top'
  get 'home/about' => 'homes#about'
  get 'relationship/follow' => 'relationships#follow'
  get 'relationship/follower' => 'relationships#follower'
  get 'search' => 'searches#search'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

end