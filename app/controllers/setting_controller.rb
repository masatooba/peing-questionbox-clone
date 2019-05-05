class SettingController < BaseController
  before_action :login_required
  def index
    @user = User.find(session[:user_id])
  end

  def change
    @user = User.find(session[:user_id])
    @user.name = params[:user_name]
    if @user.save then
      flash[:notice] = "変更が完了しました。"
      redirect_to controller: :setting, action: :index
    else
      redirect_to controller: :home, action: :error
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    if @user.destroy then
      reset_session
      flash[:notice] = "退会が完了しました"
      redirect_to root_path
    else
      redirect_to controller: :home, action: :error
    end
  end
end
