Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Set the root route
  devise_scope :user do
    root to: "devise/sessions#new" # Ensure this is correct
  end

  # Define the index route for users
  resources :users, only: [:index, :create, :new, :destroy]
end