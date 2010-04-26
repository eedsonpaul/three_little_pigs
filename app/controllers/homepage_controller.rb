class HomepageController < ApplicationController
  
  def index
    redirect_to dash_path if session[:token]
  end

  def pivotal
  	@user = session[:user]
  	if request.post?
			if Login.duplicate_token(params[:users][:token]) == true
		  	logger.info ("true")
		  	if @user.token == params[:users][:token]
		  		redirect_to dash_path
		  	else redirect_to root_path
		  	end
		  else
		  	logger.info ("false")
		  	@user.update_attributes(:token => params[:users][:token])
  			redirect_to dash_path
		  end
  	end
  end
  
end
