class UsersController < ApplicationController

  before_filter :login_required, :only=>['index']
  
  def create
    oauth.set_callback_url(callback_url)
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
  def tweet
    options = {}
    options.update(:in_reply_to_status_id => params[:in_reply_to_status_id]) if params[:in_reply_to_status_id].present?
    client.update("change",options)
  end
end
