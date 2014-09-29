class AlbumsController < ApplicationController

  def all
    albums = Albums.new(current_user.user_id, current_user.access_token).albums
    render json: albums, status: 200
  end

  def photos
    photos = Albums.new(current_user.user_id, current_user.access_token, false).photos(params[:id])
    render json: photos, status: 200
  end
end