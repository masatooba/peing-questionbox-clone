class HomeController < BaseController
  before_action :login_required, only: [:tweet]

  def index
    if session[:user_id] then
      @user = User.find(session[:user_id])
      @non_res = Message.where(user_id: @user.id).where(response_body: nil).count
      render :action => "show"
  else
    end
  end

  # 定型文をつぶやく
  def tweet
    @user = User.find(session[:user_id])
    text = "#{@user.name}(#{@user.nickname})さんの#{ENV["APP_NAME"]}です。\n\n##{ENV["APP_NAME_EN"]} ##{ENV["APP_NAME"]}\n#{request.base_url}/#{@user.nickname}"
    twitter_client(@user).update(text)
    flash[:notice] = "ツイートが完了しました。"
    redirect_to root_path
  end


  def error
  end

  def privacy
  end

  def show
    @user = User.find_by(nickname: params[:id])
    if @user == nil then
      render :action => "error"
    else
      if session[:before_after] == nil then
        session[:before_after] = true
      end
      if session[:before_after] then
        @messages = Message.where(user_id: @user.id).where(response_body: nil).order(id: "DESC")
      else
        @messages = Message.where(user_id: @user.id).where.not(response_body: nil).order(id: "DESC")
      end

      @non_res = Message.where(user_id: @user.id).where(response_body: nil).count
    end
  end

  def change_before
    session[:before_after] = true
    redirect_back(fallback_location: root_path)
  end

  def change_after
    session[:before_after] = false
    redirect_back(fallback_location: root_path)
  end


  private
  def twitter_client(current_user)
    Twitter.configure do |config|
      config.consumer_key       = ENV["API_KEY"]
      config.consumer_secret    = ENV["API_SECRET"]
      config.oauth_token        = current_user.token
      config.oauth_token_secret = current_user.secret
    end
  end


end
