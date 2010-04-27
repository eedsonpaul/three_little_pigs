class LoginController < ApplicationController

	require 'hpricot'
	require 'net/http'
	require 'uri'
	require 'rubygems'
	
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

    if Login.duplicate(profile.id) == true
    	logger.info("true")
    	session[:user] = @user = User.find_by_twitter_id(profile.id)
    else
    	logger.info("false")
    	session[:user] = @user = User.create(:screen_name => profile.screen_name, :twitter_id => profile.id)
    end
    
    if @user
      redirect_to home_path
    else
      flash[:notice] = "Signing in failed"
    end
  end
  
  def dash
	  @users = User.all
	  @base_url = "http://www.pivotaltracker.com/services/v3/projects"
  end
  
  def logout
    options = {}
    options.update(:in_reply_to_status_id => params[:in_reply_to_status_id]) if params[:in_reply_to_status_id].present?
    client.update(session[:user],options)
  	session[:user] = nil
  	session[:token] = nil
  	session[:atoken] = session[:asecret] = nil
  	session['rtoken'] = session['rsecret'] = nil
  	redirect_to home_path
  end

end
