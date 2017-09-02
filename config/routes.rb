Rails.application.routes.draw do
  get 'posts/new'

  get 'sessions/new'

  get 'users/show'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :u, controller: 'users', as: 'users' do
    resources :posts
  end
  resources :c, controller: 'communities', as: 'communities' do
    get 'submit', to: 'posts#new', on: :member
    post 'submit', to: 'posts#create', on: :member
    resources :posts
  end

  resources :posts
end
