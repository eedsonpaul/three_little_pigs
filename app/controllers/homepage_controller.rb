class HomepageController < ApplicationController
  
  def index
  end

  def pivotal
  	@user = session[:user]
  	if request.post?
  		@user.update_attributes(:token => params[:users][:token])
  		redirect_to dash_path
  	end
  end
  
end
