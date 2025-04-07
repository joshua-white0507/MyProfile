class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  # Bella said to delete as it was causing her problems
  allow_browser versions: :modern
  before_action :authenticate_user!

  protected

  # Redirect logged-in users to the users#index page
  def after_sign_in_path_for(resource)
    users_path
  end
  

end


