class AlbumsController < ApplicationController

  def photos
    #find album
    #Albums.get(params[:user_id], params[:id]).photos
    @photos = Photos.new(current_user.access_token, current_user.id, params[:id]).photos
  end
end