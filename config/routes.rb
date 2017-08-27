Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/show'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :u, controller: 'users', as: 'users'
  resources :c, controller: 'communities', as: 'communities'
end
