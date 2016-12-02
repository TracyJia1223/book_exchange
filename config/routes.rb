Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'home#index', as: :root

  get '/signup' => 'users#new'
  resources :users, except: [:new]

  resources :books, shallow: true do 
    resources :wishlists, only: [:create, :destroy]
    resources :booklists, only: [:create, :destroy]
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
