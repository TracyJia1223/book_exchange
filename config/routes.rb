Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'home#index', as: :root

  get '/signup' => 'users#new'
  get '/addtobooklist/:id' => 'books#add_to_booklist', as: :add_to_booklist
  get 'addtowishlist/:id' => 'books#add_to_wishlist', as: :add_to_wishlist
  resources :users, except: [:new]
  resources :genres, except: [:destroy]
  resources :friendships

  resources :books, shallow: true do
    resources :wishlists, only: [:create, :destroy]
    resources :booklists, only: [:create, :destroy]
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end

  resources :messages, only: [:new, :create]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'search_books' => 'books#search'
  get 'my_search' => 'books#my_search'
  get 'my_friends' => 'users#my_friends'
  get 'search_friends' => 'users#search'
  post 'add_friend' => 'users#add_friend'
  # get 'conversations/:id/new' => 'conversations#new', as: :new_conversation

end
