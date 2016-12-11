Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'home#index', as: :root

  get '/signup' => 'users#new'
  get '/addtobooklist/:id' => 'books#add_to_booklist', as: :add_to_booklist
  get 'addtowishlist/:id' => 'books#add_to_wishlist', as: :add_to_wishlist
  resources :users, except: [:new]
  resources :genres, except: [:destroy]

  resources :books, shallow: true do
    resources :wishlists, only: [:create, :destroy]
    resources :booklists, only: [:create, :destroy]
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'my_friends' => 'users#my_friends'
end
