class SessionUser
  def initialize(session)
    @name = session[:name]
    @uid = session[:user_id]
    @image = session[:image]
    @nickname = session[:nickname]
    @token = session[:oauth_token]
    @secret = session[:oauth_token_secret]
  end

  attr_reader :name, :uid, :token, :secret
end
