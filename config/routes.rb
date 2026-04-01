Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users

  namespace :admin do
    root to: 'dashboards#index'
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'
  get "search" => "searches#index"

  get '/mypage', to: 'users#show', as: 'mypage'
  resources :users, only: [:show, :edit, :index, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    patch :update_privacy, on: :member
    get :favorites, to: 'favorites#index'
  end

  get 'posts/favorites', to: 'favorites#index', as: 'favorite_posts'
  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :ingredients, only: [:create]
  resources :post_ingredients, only: [] do
    member do
      patch :update_shopping_list
    end
  end

  resource :shopping_list, only: [:show, :update] do
    post 'add_item/:post_ingredient_id', to: 'shopping_lists#add_item', as: 'add_item'
    patch 'update_item_status/:id', to: 'shopping_lists#update_item_status', as: 'update_item_status'
    delete 'destroy_item/:id', to: 'shopping_lists#destroy_item', as: 'destroy_item', defaults: { format: 'js' }
  end

  resources :shopping_list_items, only: [:destroy]

end
