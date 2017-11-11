Rails.application.routes.draw do
  resource :home, only: [:show]

  resources :tickets
  resources :users
  resources :organizations

  root 'homes#show'
end
