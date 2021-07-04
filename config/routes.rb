Rails.application.routes.draw do

   post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'

  get 'home/about' => "homes#about"

  root to:'homes#top'
  devise_for :users
  resources :books do
    resource :favorites, only: [:create, :destroy]

    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

end
