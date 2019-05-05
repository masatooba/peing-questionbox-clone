class BaseController < ApplicationController
  protect_from_forgery

  def login_required
    if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
    unless @current_user
      flash[:notice] = "ログインが完了していません。"
      redirect_to root_path
    end
  end

end
