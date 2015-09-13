Rails.application.routes.draw do
  devise_for :users

  resources :subclonnits, only: [:show, :new, :create] do
    resources :posts, only: [:show, :new, :create]
  end
end
