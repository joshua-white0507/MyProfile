Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Set the root route
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # Define the index route for users
  resources :users, only: [:index, :create, :show, :new, :destroy]
end