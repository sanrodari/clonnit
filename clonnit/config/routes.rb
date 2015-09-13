Rails.application.routes.draw do
  devise_for :users

  resources :subclonnits, only: [:show, :new, :create]
end
