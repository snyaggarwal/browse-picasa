class PhotosController < ApplicationController
  respond_to :json

  def comment
    Photos.new(current_user.access_token, params[:user_id], params[:album_id]).comment(params[:id], params[:comment])
  end
end