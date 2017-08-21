Rails.application.routes.draw do
  get 'users/show'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :u, controller: 'users', as: 'users'
end
