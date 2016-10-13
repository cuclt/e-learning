class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_user, only: :destroy

  def index
    @users = User.search_condition(params[:search]).newest
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.user.user_del"
    else
      flash[:danger] = t "admin.user.user_del_fail"
    end
    redirect_to admin_users_path
  end
end
