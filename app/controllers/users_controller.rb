class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    authorize @users
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

  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    if @user.save
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error editing your account. Please try again."
      redirect_to :back
    end

    @user_wikis = @user.wikis.where(private: true)

      @user_wikis.each do |wiki|
      wiki.update_attributes(private: false)
     end
  end

  private

  def secure_user_params
    params.require(:user).permit(:role)
  end
end
