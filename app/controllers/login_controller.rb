class LoginController < ApplicationController

	require 'hpricot'
	require 'net/http'
	require 'uri'
	require 'rubygems'

  before_filter :login_required, :only=>['dash', 'logout']

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
  
  def to_xml(move, target)
		builder = Nokogiri::XML::Builder.new do |xml|
	    xml.move {
	      xml.move move
				xml.target target
	    }
    end
	  return builder.to_xml
	end
  
  def dash
    @root_url = "http://localhost:3000"
	  @base_url = "http://www.pivotaltracker.com/services/v3/projects"
  end
  
  def prioritize
    project = params[:project]
    story = params[:story]
    move = params[:move]
    target = params[:target]
	  @moved_story = connection["/projects/#{project}/stories/#{story}/moves"].post(self.to_xml(move, target), :content_type => 'application/xml')
  end
  
  def connection
  @connection ||= RestClient::Resource.new("https://www.pivotaltracker.com/services/v3", :headers => {'X-TrackerToken' => session[:token], 'Content-Type' => 'application/xml'})
  end
  
  def logout
  	session[:user] = nil
  	session[:token] = nil
  	session[:atoken] = session[:asecret] = nil
  	session['rtoken'] = session['rsecret'] = nil
  	redirect_to home_path
  end
  
end
