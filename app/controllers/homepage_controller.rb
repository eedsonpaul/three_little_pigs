class HomepageController < ApplicationController
  
  def index
  	redirect_to home_path
  end

	def home
    redirect_to dash_path if session[:token]
	end
  
end
