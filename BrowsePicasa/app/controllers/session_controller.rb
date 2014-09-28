class SessionController < ApplicationController
  include PicasaWeb

  def create
    session[:access_token] = params['access_token'].to_s
    render json: {data: 'success'}, status: 200
  end

  def logout
    res = disconnect(session[:access_token])
    if res == '200'
      session.clear
      redirect_to root_path
    else
      raise 'Unable to disconnect'
    end
  end
end