class UsersController < ApplicationController
      
  def index
    @users = User.all
  
    # Search by name, interest, or skills
    if params[:query].present?
      @users = @users.where(
        "name ILIKE :query OR interest ILIKE :query OR skills ILIKE :query",
        query: "%#{params[:query]}%"
      )
    end
  
    # Filter by practice
    @users = @users.where(practice: params[:practice]) if params[:practice].present?
  
    # Filter by grade
    @users = @users.where(grade: params[:grade]) if params[:grade].present?
  
    # Filter by bench status
    @users = @users.where(bench: ActiveModel::Type::Boolean.new.cast(params[:bench])) if params[:bench].present?
  
    # Filter by previous clients
    if params[:previous_clients].present?
      @users = @users.where("previous_clients ILIKE ?", "%#{params[:previous_clients]}%")
    end
  end
    # GET /users
    # GET /users.json

    def show
      @user = User.find(params[:id])
    end



    def edit
      # @user is already set by the before_action :set_user
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:previous_clients => []])
      devise_parameter_sanitizer.permit(:account_update, keys: [:previous_clients => []])
    end

    def set_user
  Rails.logger.debug "Fetching user with ID: #{params[:id]}"
  @user = User.find(params[:id])
end
 
    def new
        @user = User.new
      end
    
      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to root_url
        else
          render :new
        end
      end

      def destroy
        User.find(params[:id]).destroy
        redirect_to root_url
    end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:previous_clients => []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:previous_clients => []])
  end
    
      private
    
      def user_params
        params.require(:user).permit(:name, :practice, :email, :password, :password_confirmation, :experience, :interest, skills: [], previous_clients: [])
      end


end
