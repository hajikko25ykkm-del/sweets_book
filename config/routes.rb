Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'

  resources :posts do
    resources :comments, only: [:create, :destroy]
    collection do
      get :favorites
    end
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :index, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]

    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    patch :update_privacy, on: :member
    get :favorites, to: 'favorites#index'
  end

  get '/mypage', to: 'users#show', as: 'mypage'
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
