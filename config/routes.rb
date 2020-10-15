Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users, only: [:show], param: :nickname

  namespace :admin do
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root 'users#show'
end
