class UsersController < ApplicationController
  def create
    oauth.set_callback_url(callback_url)
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
end
