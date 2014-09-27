require 'spec_helper'

describe Photos, type: :model do
  it 'should initialize and parse photos' do
    expect_any_instance_of(Photos).to receive(:load_photos)
                                      .with('token', 'user_id', 'album_id', 3)
                                      .and_return(JSON.parse(File.read('spec/fixtures/photos_mock.json')))

    photos = Photos.new('token', 'user_id', 'album_id').all
    expect(photos.count).to eq(2)
    expect(photos[0]).to be_instance_of(Photo)
  end

  it 'should return empty response if there are no photos' do
    expect_any_instance_of(Photos).to receive(:load_photos)
                                      .with('token', 'user_id', 'album_id', 3)
                                      .and_return(nil)

    photos = Photos.new('token', 'user_id', 'album_id').all
    expect(photos.count).to eq(0)
  end
end