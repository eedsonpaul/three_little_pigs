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
    session[:token] = nil

    #@user = User.create(:screen_name => profile.screen_name, :twitter_id => profile.id)
    if Login.duplicate(profile.id) == true
    	logger.info ("true")
    	session[:user] = @user = User.find_by_twitter_id(profile.id)
    else
    	logger.info ("false")
    	session[:user] = @user = User.create(:screen_name => profile.screen_name, :twitter_id => profile.id)
    end
    
    if @user
      redirect_to root_path
    else
      flash[:notice] = "Signing in failed"
    end
  end
  
  def pivotal
  	@user = session[:user]
  	if request.post?
  		@user.update_attributes(:token => params[:users][:token])
  		redirect_to dash_path
  	end
  end
  
  def dash
	  @users = User.all
	  #@projects  = PivotalTracker::Project.all
  end
  
  def logout
  	session[:user] = nil
  	session[:token] = nil
  	session[:atoken] = session[:asecret] = nil
  	session['rtoken'] = session['rsecret'] = nil
  	redirect_to root_path
  end

end
