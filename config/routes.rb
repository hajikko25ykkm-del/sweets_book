Rails.application.routes.draw do
  get 'searches/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'
  get "search" => "searches#index"

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :posts do
    resource :favorite, only: [:create, :destroy]
    collection do
      get :favorites
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :ingredients, only: [:create]
  resources :post_ingredients, only: [] do
    member do
      patch :update_shopping_list
    end
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
