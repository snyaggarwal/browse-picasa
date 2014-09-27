class Photos
  include PicasaWeb

  attr_accessor :photos, :album_id

  def initialize(access_token, user_id, album_id)
    self.album_id = album_id
    self.photos = parse(load_photos(access_token, user_id, album_id, 3))
  end


  private
  def parse(photos_data)
    photos_data['feed']['entry'].map do |metadata|
      image_url = metadata['group']['thumbnail'].detect {|thumbnail| thumbnail['height'] == '288'}
      Photo.new(metadata['id'][1], self.album_id, metadata['group']['title'], image_url['url'])
    end
  end
end