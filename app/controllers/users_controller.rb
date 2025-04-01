class UsersController < ApplicationController
      


    # GET /users
    # GET /users.json

    def index
        @users = User.all
    end

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
