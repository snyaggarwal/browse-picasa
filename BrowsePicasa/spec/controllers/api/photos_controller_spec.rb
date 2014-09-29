require 'spec_helper'

describe Api::PhotosController, type: :controller do
  describe 'actions' do
    let(:photos_mock) { double(Photos) }

    before :each do
      user = double(User, access_token: 'token', id: 'user_id')

      expect(controller).to receive(:current_user).exactly(2).times.and_return(user)

      expect(Photos).to receive(:new) do |access_token, user_id, album_id, refresh_photos|
        expect(access_token).to eq 'token'
        expect(user_id).to eq 'user_id'
        expect(album_id).to eq 'album_id'
        expect(refresh_photos).to eq false
      end.and_return(photos_mock)
    end

    it 'should post comment on a photo and return success' do
      expect(photos_mock).to receive(:comment).with('photo_id', 'comment').and_return('201')

      get :comment, {id: 'photo_id', comment: 'comment', album_id: 'album_id', format: :json}

      expect(response.status).to eq 201
      expect(JSON.parse(response.body)).to eq({"data"=>"success"})
    end

    it 'should return error in case of post failure' do
      expect(photos_mock).to receive(:comment).with('photo_id', 'comment').and_return('400')

      get :comment, {id: 'photo_id', comment: 'comment', album_id: 'album_id', format: :json}

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)).to eq({"data"=>"error"})
    end

  end
end