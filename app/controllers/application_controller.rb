# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def login_required
    if session[:user]
      return true
    end
    flash[:warning]='Please login to continue'
    redirect_to root_path
    return false 
  end

  def current_user
    session[:user]
  end

   private
    def oauth
      @oauth ||= Twitter::OAuth.new('qHQJeBAlWDhByyjp3laQ', 'UsanGcasLM2adLVi0jtcC7IQz1Yw0zcbjE2XDfptRQ', :sign_in => true)
    end
    
    def client
      oauth.authorize_from_access(session[:atoken], session[:asecret])
      Twitter::Base.new(oauth)
    end
    helper_method :client
end
