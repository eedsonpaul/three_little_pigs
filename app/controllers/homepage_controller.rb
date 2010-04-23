class HomepageController < ApplicationController
  
  def index
    redirect_to dash_path if session[:token]
  end

  def pivotal
  	@user = session[:user]
  	if request.post?
  		@user.update_attributes(:token => params[:users][:token])
  		redirect_to dash_path
  	end
  end
  
end
