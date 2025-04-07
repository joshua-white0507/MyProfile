class UsersController < ApplicationController
      
  def index
    query = params[:query].present? ? "%#{params[:query]}%" : nil
    @users = User.all
  
    # Search functionality
    if query
      @users = @users.where("interest ILIKE ? OR skills::text ILIKE ?", query, query)
    end
  
    # Filtering functionality
    if params[:practice].present?
      @users = @users.where(practice: params[:practice])
    end
  
    if params[:grade].present?
      @users = @users.where(grade: params[:grade])
    end
  
    if params[:bench].present?
      @users = @users.where(bench: ActiveModel::Type::Boolean.new.cast(params[:bench]))
    end
  
    # Sorting functionality
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
    
      private
    
      def user_params
        params.require(:user).permit(:name, :practice, :email, :password, :password_confirmation, :experience, :interest, skills: [])
      end


end
