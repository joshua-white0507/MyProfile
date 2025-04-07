class UsersController < ApplicationController
      
  def index
    @users = User.all

    # Search functionality
    if params[:query].present?
      query = "%#{params[:query]}%"
      @users = @users.where("name ILIKE ? OR interest ILIKE ? OR skills::text ILIKE ?", query, query, query)
    end

    # Filtering functionality
    @users = @users.where(practice: params[:practice]) if params[:practice].present?
    @users = @users.where(grade: params[:grade]) if params[:grade].present?
    @users = @users.where(bench: ActiveModel::Type::Boolean.new.cast(params[:bench])) if params[:bench].present?
    @users = @users.where("previous_clients @> ARRAY[?]::text[]", [params[:previous_clients]]) if params[:previous_clients].present?

    # Sorting functionality (optional)
    if params[:sort].present?
      direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      @users = @users.order("#{params[:sort]} #{direction}")
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
