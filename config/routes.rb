Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :notebooks, only: [:show, :new, :create] do
    resources :budget_items, only: [:new, :create]
  end
end
