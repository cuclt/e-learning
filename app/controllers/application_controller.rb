class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "not_login"
      redirect_to root_path
    end
  end

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_path
      flash[:danger] = t "user_is_not_admin"
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "signup_first"
      redirect_to admin_root_path
    end
  end
end
