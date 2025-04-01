class Users::RegistrationsController < Devise::RegistrationsController
  # Redirect after sign-up
  def after_sign_up_path_for(resource)
    users_path # Redirects to the index action of the UsersController
  end

  private

  # Permit additional parameters for sign-up
  def sign_up_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :interest, :practice, :experience, skills: [])
  end

  # Permit additional parameters for account update
  def account_update_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :current_password, :interest, :practice, :experience, skills: [])
  end
end