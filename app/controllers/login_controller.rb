class LoginController < ApplicationController
  def index
    @user = User.new
  end

  def callback
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])

    profile = Twitter::Base.new(oauth).verify_credentials
    session['rtoken'] = session['rsecret'] = nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret

    @user = User.create(:screen_name => profile.screen_name, :twitter_id => profile.id)
    if @user
      redirect_to root_path
    else
      flash[:notice] = "You're a loser!!!"
    end	
  end

end
