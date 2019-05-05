class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
    @current_user ||= SessionUser.new(session) if session[:user_id]
    unless @current_user
      flash[:notice] = "ログインが完了していません。"
      redirect_to root_path
    end
  end

end
