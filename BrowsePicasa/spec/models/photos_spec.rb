require 'spec_helper'

describe Photos, type: :model do
  it 'should initialize and parse photos' do
    expect_any_instance_of(Photos).to receive(:load_photos)
                                      .with('token', 'user_id', 'album_id', 3)
                                      .and_return(JSON.parse(File.read('spec/fixtures/photos_mock.json')))

    photos = Photos.new('token', 'user_id', 'album_id').all
    expect(photos.count).to eq(2)
    expect(photos[0]).to be_instance_of(Photo)
    expect(photos[0].album_name).not_to be_blank
    expect(photos[0].id).not_to be_blank
    expect(photos[0].album_id).not_to be_blank
  end

  it 'should not load photos if forced to' do
    expect_any_instance_of(Photos).not_to receive(:load_photos)
    Photos.new('token', 'user_id', 'album_id', false)
  end

  it 'should return empty response if there are no photos' do
    expect_any_instance_of(Photos).to receive(:load_photos)
                                      .with('token', 'user_id', 'album_id', 3)
                                      .and_return(nil)

    photos = Photos.new('token', 'user_id', 'album_id').all
    expect(photos.count).to eq(0)
  end

  it 'should call picasa web post comments' do
    expect_any_instance_of(Photos).not_to receive(:load_photos)

    expect_any_instance_of(Photos).to receive(:post_comment)
                                      .with({access_token: 'token', user_id: 'user_id', album_id: 'album_id', photo_id: 'photo_id', comment: 'comment'})
                                      .and_return('201')

    photos = Photos.new('token', 'user_id', 'album_id', false)
    photos.comment('photo_id', 'comment')
  end
end