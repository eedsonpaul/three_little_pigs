class HomepageController < ApplicationController
  
  before_filter :login_required, :only=>[ 'pivotal']

  def index
  	session[:token] = session[:user]  = nil
  	redirect_to home_path
  end

	def home
    redirect_to dash_path if session[:token]
	end
	
  def pivotal
  	if request.post?
			session[:token] = params[:sessions][:token]
  		redirect_to dash_path
  	end
  end
  
end
