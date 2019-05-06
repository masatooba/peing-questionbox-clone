class SessionsController < BaseController
  before_action :login_required, only: [:destroy]

  def callback
    auth = request.env['omniauth.auth']
    @user = User.find_by(nickname: auth["info"]["nickname"])
    if @user then
      flash[:notice] = "ログインが完了しました"
    else
      @user = User.new
      @user.name = auth['info']['name']
      @user.image = auth['info']['image']
      @user.nickname = auth["info"]["nickname"]
      @user.token = auth['credentials']['token']
      @user.secret = auth['credentials']['secret']
      @user.save
      # ツイートをする
      text = "#{@user.name}(#{@user.nickname})さんの#{ENV["APP_NAME"]}です。\n\n##{ENV["APP_NAME_EN"]} ##{ENV["APP_NAME"]}\n#{request.base_url}/#{@user.nickname}"
      twitter_client(@user).update(text)
      # twitter_client(@user).follow(ENV["CURRENT"].to_s)
      flash[:notice] = "登録が完了しました"
    end
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
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
