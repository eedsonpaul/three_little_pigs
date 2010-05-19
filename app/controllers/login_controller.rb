class LoginController < ApplicationController

	require 'hpricot'
	require 'net/http'
	require 'uri'
	require 'rubygems'

#  before_filter :login_required, :only=>['pivotal', 'logout']

  def index
  end

  def callback
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])

    profile = Twitter::Base.new(oauth).verify_credentials
    session['rtoken'] = session['rsecret'] = nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret
    session[:token] = nil
    session[:user] = profile.id
    session[:screen_name] = profile.screen_name
    
    if session[:user]
      redirect_to home_path
    else
      flash[:notice] = "Signing in failed"
    end
  end
	
  def pivotal
  	if request.post?
			session[:token] = params[:sessions][:token]
  		redirect_to dash_path
  	end
  end
  
  def logout
  	session[:user] = nil
  	session[:token] = nil
  	session[:atoken] = session[:asecret] = nil
  	session['rtoken'] = session['rsecret'] = nil
  	redirect_to home_path
  end
  
end
