class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
  @current_user = current_user
    unless @current_user
      flash[:notice] = "ログインが完了していません。"
      redirect_to root_path
    end
  end

  private
  def current_user
    # SessionUserクラスからユーザ情報を取得するように
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end
end
