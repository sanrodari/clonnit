Rails.application.routes.draw do
  root 'frontpage#show'

  get 'frontpage/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # only: [] for no conflictig with devise_for
  resources :users, only: [] do
    resources :subscriptions, only: [:index, :create]
  end

  resources :subclonnits, only: [:show, :new, :create] do
    resources :posts, only: [:show, :new, :create, :destroy] do
      post 'toggle_upvote',   on: :member
      post 'toggle_downvote', on: :member
    end

    resources :moderators, only: [:index, :new, :create, :destroy]
  end
end
