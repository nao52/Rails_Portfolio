Rails.application.routes.draw do
  root    "sessions#new"
  get     "/signup",   to: "users#new"
  post    "/signup",   to: "users#create"
  get     "/login",    to: "sessions#new"
  post    "/login",    to: "sessions#create"
  delete  "/logout",   to: "sessions#destroy"

  get     "/seat/show",                   to: "static_pages#create_seats"
  get     "/cleaning_duty/show",          to: "cleaning_duties#show"
  post    "/cleaning_duty/save_place",    to: "cleaning_duties#save_cleaning_place"
  get     "/calc_absent/show",            to: "calc_absents#show"
  post    "/calc_absent/save_schedule",   to: "calc_absents#save_schedule"

  resources :users do
    member do
      get :following, :followers, :worksheets, :favorite_books, :favorite_worksheets
    end
    collection do
      get :search
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
  resources :publishers do
    collection do
      get :search
    end
  end
  resources :reference_books do
    collection do
      get :search
    end
  end
  resources :subject_posts,           only: [:create, :destroy]
  resources :club_posts,              only: [:create, :destroy]
  resources :kinds_of_school_posts,   only: [:create, :destroy]
  resources :private_group_posts,     only: [:create, :destroy]
  resources :participations,          only: [:create, :destroy]
  resources :worksheets,              only: [:index, :new, :create, :edit, :update, :destroy]
  resources :book_favorites,          only: [:create, :destroy]
  resources :worksheet_favorites,     only: [:create, :destroy]
  resources :book_reviews,            only: [:create, :destroy]

end