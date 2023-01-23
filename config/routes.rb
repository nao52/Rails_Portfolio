Rails.application.routes.draw do

  root "application#hello"
  get     "/signup",  to: "users#new"
  get     "/login",   to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,     only: [:create, :destroy]
  resources :subjects,          only: [:index, :show]
  resources :clubs,             only: [:index, :show]
  resources :kinds_of_schools,  only: [:index, :show]
  resources :subject_posts,     only: [:create, :destroy]
  resources :club_posts,        only: [:create, :destroy]
end