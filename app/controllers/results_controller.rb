class ResultsController < ApplicationController
  before_action :logged_in_user
  def index
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user_empty"
      redirect_to root_path
    end
    @results = @user.results.search_by_condition(params[:search])
      .paginate page: params[:page], per_page: Settings.per_page
    @lessons = @user.lessons.includes(:category).uniq_by_category
  end
end
