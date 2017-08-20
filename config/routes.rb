Rails.application.routes.draw do
  get 'users/show'

  resources :u, controller: 'users'
end
