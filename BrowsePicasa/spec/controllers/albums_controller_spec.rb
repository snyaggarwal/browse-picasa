require 'spec_helper'

describe AlbumsController, type: :controller do
  describe 'actions' do
    let(:albums_mock) { double(Albums) }

    before :each do
      user = double(User, access_token: 'token', user_id: 'user_id')

      expect(controller).to receive(:current_user).exactly(2).times.and_return(user)

      expect(Albums).to receive(:new) do |user_id, access_token|
        expect(user_id).to eq 'user_id'
        expect(access_token).to eq 'token'
      end.and_return(albums_mock)
    end

    it 'should return all albums' do
      expected_albums = ['album1', 'album2']

      expect(albums_mock).to receive(:albums).and_return(expected_albums)

      get :all, format: :json

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_albums)
    end

    it 'should return all photos of a given album' do
      expected_photos = ['photo1', 'photo2']

      expect(albums_mock).to receive(:photos).with('album_id').and_return(expected_photos)

      get :photos, { id: 'album_id', format: :json }

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_photos)
    end
  end
end