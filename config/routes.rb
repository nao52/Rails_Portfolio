Rails.application.routes.draw do
  get 'worksheets/new'
  root "application#hello"
  get     "/signup",    to: "users#new"
  get     "/login",     to: "sessions#new"
  post    "/login",     to: "sessions#create"
  delete  "/logout",    to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers, :joinings, :worksheets, :favorite_books, :favorite_worksheets
    end
  end
  resources :relationships,           only: [:create, :destroy]
  resources :subjects,                only: [:index, :show] do
    member do
      get :members
    end
  end
  resources :clubs,                   only: [:index, :show] do
    member do
      get :members
    end
  end
  resources :kinds_of_schools,        only: [:index, :show] do
    member do
      get :members
    end
  end
  resources :private_groups do
    member do
      get :members
    end
  end
  resources :subject_posts,           only: [:create, :destroy]
  resources :club_posts,              only: [:create, :destroy]
  resources :kinds_of_school_posts,   only: [:create, :destroy]
  resources :private_group_posts,     only: [:create, :destroy]
  resources :participations,          only: [:create, :destroy]
  resources :publishers
  resources :reference_books
  resources :worksheets,              only: [:index, :new, :create, :edit, :update, :destroy]
  resources :book_favorites,          only: [:create, :destroy]
end