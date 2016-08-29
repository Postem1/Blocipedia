class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_user_params)
      flash[:notice] = "Successfully updated user"
      redirect_to users_path
    else
      flash.notice[:alert] = "There was an error updating this user.  Please try again"
      redirect_to users_path
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    if user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to users_path
    else
      flash.now[:alert] = "There was an error deleting this user.  Try again"
      redirect_to users_path
    end
  end

  private

  def secure_user_params
    params.require(:user).permit(:role)
  end
end
