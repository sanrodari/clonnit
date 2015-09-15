Rails.application.routes.draw do
  devise_for :users

  resources :subclonnits, only: [:show, :new, :create] do
    resources :posts, only: [:show, :new, :create] do
      post 'toggle_upvote',   on: :member
      post 'toggle_downvote', on: :member
    end

    resources :moderators, only: [:index, :new, :create, :destroy]
  end
end
