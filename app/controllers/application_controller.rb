class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  helper :all 
  protect_from_forgery
  rescue_from Twitter::Unauthorized, :with => :force_sign_in
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
       @oauth ||= Twitter::OAuth.new(ConsumerToken, ConsumerSecret, :sign_in => true)
    end
    
    def client
      oauth.authorize_from_access(session[:atoken], session[:asecret])
      Twitter::Base.new(oauth)
    end
    helper_method :client
    
    def force_sign_in(exception)
      reset_session
      flash[:error] = 'Seems your credentials are not good anymore. Please sign in again.'
      redirect_to root_url
    end
end
