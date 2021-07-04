Rails.application.routes.draw do

  get 'home/about' => "homes#about"

  root to:'homes#top'
  devise_for :users
  resources :books do
    resource :favorites, only: [:create, :destroy]

    resources :book_comments, only: [:create, :destroy]

  end
  resources :users, only: [:new, :create, :index, :show, :edit, :update]

end
