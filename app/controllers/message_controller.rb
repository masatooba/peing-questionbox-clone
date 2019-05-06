class MessageController < BaseController
  before_action :login_required, only: [:index, :after, :answer]
  def index
    @messages = Message.where(user_id: session[:user_id]).where(response_body: nil).order(id: "DESC")
  end

  def after
    @messages = Message.where(user_id: session[:user_id]).where.not(response_body: nil).order(id: "DESC")
  end

  def add
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
  end

  def get_image
    @image = Message.find(params[:id]).image
    send_data(@image, :disposition => "inline", :type => "image/jpeg")
  end

  def answer
    # メッセージのidをformタグの中のhiddenから取ってきて、変数@messageに入れる
    # hiddenできたidが本当にuserのものなのか調べる
    @message = Message.find(params[:message_id])
    if @message.user_id != session[:user_id] then
      flash[:notice] = "不正はしないでください"
      redirect_to controller: :home, action: :error
    else
      @message.response_body = params[:body]
      if @message.save then
        @user = User.find(session[:user_id])
        text = "#{@message.response_body}\n\n##{ENV["APP_NAME_EN"]} ##{ENV["APP_NAME"]}\n#{request.base_url}/message/add/#{@message.id}"
        twitter_client(@user).update(text)

        #投稿の内容と投稿のurlをツイートをする
        flash[:notice] = "回答に完了しました"
        redirect_to controller: :message, action: :add, id: @message.id
      else
        redirect_to controller: :home, action: :error
      end
    end
  end

  def create
    @user = User.find(params["user_id"])
    if @user then
      @message = Message.new(
        body: params["body"],
        user_id: @user.id
      )
      @message.image = MessageHelper.build(@message.body).tempfile.open.read

      if @message.save then
        flash[:notice] = "質問の送信が完了しました。"
      else
        flash[:notice] = "質問の送信が失敗しました。"
      end
    else
      flash[:notice] = "質問の送信が失敗しました。"
    end
    # 質問が完了しましたとフラッシュメッセージをする
    # それと質問した相手へのリダイレクト
    redirect_to controller: :home, action: :show, id: @user.nickname
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
