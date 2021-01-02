# ルーティング
# 製作日 2020/11/29
# 更新日 2020/12/02

Rails.application.routes.draw do

  # resources :place do
  #   get :search, on: :collection
  # end
  get "place/search" => "place#search"
  get "search_exe" => "place#search"
  get 'place/index' => "place#index"
  post 'place/create' => "place#create"
  get "place/:name" => "place#show"
  get "insert" => "place#new"

  # 店舗関連
  get 'shop/index' => "shop#index"
  get 'shop/edit' => "shop#edit"
  post "shop/:id/update" => "shop#update"

  # いいね機能関連
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  get "users/:id/likes" => "users#likes"

  # 認証機能関連
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  # ユーザー関連
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"

  # 投稿関連
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  # 固定ページ関連
  get "/" => "home#top"
  get "about" => "home#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
