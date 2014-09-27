class HomeController < ApplicationController
  include PicasaWeb

  def index
    session[:user_id] = current_user.id if current_user.valid?
    @albums = Albums.new(session[:user_id], session[:access_token]).albums
  end


  def logout
    Rails.logger.info('session')
    Rails.logger.info(session.inspect)
    res = disconnect(session[:access_token])
    if res == 200
      session.clear
      flash[:success] = 'Successfully disconnected'
      redirect_to root_path
    else
      raise 'Unable to disconnect'
    end
  end
end