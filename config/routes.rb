Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :posts do
    member do
      post :retweet
    end
    resources :likes
  end

  root 'posts#index'

  get 'user_posts/:user_id' => 'posts#user', as: :user_posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
