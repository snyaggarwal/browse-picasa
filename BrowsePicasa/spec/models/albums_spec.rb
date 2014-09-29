require 'spec_helper'

describe Albums, type: :model do
  it 'should not load photos if forced to' do
    expect_any_instance_of(Albums).not_to receive(:load_albums)

    Albums.new('user_id', 'token', false)
  end

  it 'should initialize and parse albums' do
    expect_any_instance_of(Albums).to receive(:load_albums)
                                      .with('user_id', 'token')
                                      .and_return(JSON.parse(File.read('spec/fixtures/albums_mock.json')))

    albums = Albums.new('user_id', 'token').all

    expect(albums.count).to eq(2)
    expect(albums[0]).to be_instance_of(Album)
  end

  it 'should return empty response if there are no albums' do
    expect_any_instance_of(Albums).to receive(:load_albums)
                                      .with('user_id', 'token')
                                      .and_return(nil)

    albums = Albums.new('user_id', 'token').all

    expect(albums.count).to eq(0)
  end

  it 'should return photos of an album' do
    expect_any_instance_of(Albums).to receive(:load_albums)
                                      .with('user_id', 'token')
                                      .and_return(JSON.parse(File.read('spec/fixtures/albums_mock.json')))

    expected_photos = ['photo1', 'photo2']

    photos_mock = double(Photos)

    expect(Photos).to receive(:new) do |access_token, user_id, album_id|
      expect(access_token).to eq('token')
      expect(user_id).to eq('user_id')
      expect(album_id).to eq('album_id')
    end.and_return(photos_mock)

    expect(photos_mock).to receive(:all).and_return(expected_photos)

    photos = Albums.new('user_id', 'token').photos('album_id')

    expect(photos).to eq(expected_photos)
  end
end