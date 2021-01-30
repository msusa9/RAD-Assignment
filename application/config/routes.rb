Rails.application.routes.draw do
  get 'sessions/new'
  get 'bypass_sessions/new'

  resources :users do
    collection do
      get 'avatar_edit' => 'users#avatar_edit', as: :avatar_edit
      get 'comments_to_me' => 'users#comments_to_me', as: :comments_to_me
      get 'my_comments' => 'users#my_comments', as: :my_comments
      get 'my_posts' => 'users#my_posts', as: :my_posts
      get 'password_edit' => 'users#password_edit', as: :password_edit
      get 'personal_info_edit' => 'users#personal_info_edit', as: :personal_info_edit
      get 'verification' => 'users#verification', as: :verification
    end
  end

  resources :comments
  resources :topics
  resources :posts

  get 'forum/main'
  get 'forum/post'
  resources :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #sign_up path
  root 'posts#index'
  
  get '/home', to: 'posts#main'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'



  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'

  get '/forgotpassword', to: 'bypass_sessions#new'
  post '/forgotpassword', to: 'bypass_sessions#create'
  get '/bypasslogin', to: 'bypass_sessions#edit'
  
  #get '/loginemail', to: 'sessions#loginemail'
  #resources :sessions, only: [:loginemail]
end
