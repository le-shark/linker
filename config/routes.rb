Rails.application.routes.draw do
  post 'save', to: 'savings#create'
  delete 'unsave', to: 'savings#destroy'

  get 'posts/new'

  get 'sessions/new'

  get 'users/show'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :u, controller: 'users', as: 'users' do
    get :saved
  end
  resources :c, controller: 'communities', as: 'communities' do
    get 'submit', to: 'posts#new', on: :member
    post 'submit', to: 'posts#create', on: :member
    resources :posts do
      resources :comments
      put "upvote", to: "posts#upvote", on: :member
      put "downvote", to: "posts#downvote", on: :member
    end
  end
  resources :comments do
    resources :comments
  end
end
