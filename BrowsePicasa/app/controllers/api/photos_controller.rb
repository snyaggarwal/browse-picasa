module Api
  class PhotosController < ApplicationController
    respond_to :json

    def comment
      photos = Photos.new(current_user.access_token, current_user.id, params[:album_id], false)
      response = photos.comment(params[:id], params[:comment])
      if response == '201'
        render json: { data: 'success' }, status: 201
      else
        render json: { data: 'error' }, status: response
      end
    end
  end
end


