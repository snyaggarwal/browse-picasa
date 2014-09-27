class LoginController < ApplicationController

  def index
    session[:access_token] = params['access_token'].to_s
    render text: 'success', status: 200
  end
end