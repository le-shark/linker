Rails.application.routes.draw do
  root 'static_pages#home'

  post 'save', to: 'savings#create'
  delete 'unsave', to: 'savings#destroy'

  get 'inbox', to: 'conversations#index'

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
    post 'subscribe', to: 'subscription#create', on: :member
    delete 'unsubscribe', to: 'subscription#destroy', on: :member
    get 'submit', to: 'posts#new', on: :member
    post 'submit', to: 'posts#create', on: :member
    resources :posts do
      resources :comments
      put "upvote", to: "posts#upvote", on: :member
      put "downvote", to: "posts#downvote", on: :member
      put "gild", to: "posts#gild"
    end
  end
  resources :comments do
    put "upvote", to: "comments#upvote", on: :member
    put "downvote", to: "comments#downvote", on: :member
    resources :comments
  end
  resources :conversations do
    resources :messages
  end
end
