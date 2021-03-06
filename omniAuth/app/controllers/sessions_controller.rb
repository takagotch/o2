class SessionController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:oauth_token] = auth.credentials.token
    session[:oauth_token_secret] = auth.credentials.secret
    session[:username] = auth.extra.access_token.params[:screen_name]
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:oauth_token] = nil
    session[:oauth_token_secret] = nil
    session[:username] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end

