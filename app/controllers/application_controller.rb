class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

  def user_not_authorized
    flash[:alert] = "Access Denied."
    redirect_to (request.referrer || root_path)
  end
end
