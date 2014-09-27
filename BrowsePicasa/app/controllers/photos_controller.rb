class PhotosController < ApplicationController

  def comment
    Photo.comment(current_user.access_token, session[:user_id], params[:album_id], params[:id], params[:comment])
  end
end