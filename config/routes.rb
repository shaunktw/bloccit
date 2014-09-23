Bloccit::Application.routes.draw do

  get "posts/index"
  get 'tags/:tag', to: 'posts#index', as: :tag
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


    resources :users, only: [:update, :show, :index]
    resources :posts, only: [:index]
    resources  :topics do
      resources :posts, except: [:index], controller: 'topics/posts' do
        resources :comments, only: [:create, :destroy]
        get '/up-vote' => 'votes#up_vote', as: :up_vote
        get '/down-vote' => 'votes#down_vote', as: :down_vote
        resources :favorites, only: [:create, :destroy]
      end
    end


  get 'about' => 'welcome#about'
  get 'index' => 'welcome#index'
  get 'privacypolicy' => 'welcome#privacypolicy'
  root to: 'posts#index'
  
end
