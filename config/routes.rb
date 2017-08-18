Rails.application.routes.draw do
  get 'users/show'

  resources :users
end
