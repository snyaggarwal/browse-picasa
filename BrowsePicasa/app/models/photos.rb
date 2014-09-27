class Photos
  include PicasaWeb

  attr_accessor :photos, :album_id
  attr_accessor :access_token, :user_id
  alias_method :all, :photos

  MAX_PHOTOS_PER_ALBUM = 3

  def initialize(access_token, user_id, album_id)
    self.access_token = access_token
    self.user_id = user_id
    self.album_id = album_id
    self.photos = parse(load_photos(access_token, user_id, album_id, MAX_PHOTOS_PER_ALBUM))
  end

  def comment(photo_id, comment)
    post_comment({access_token: self.access_token, user_id: self.user_id, album_id: self.album_id, photo_id: photo_id, comment: comment})
  end

  private
  def parse(photos_data)
    photo_entries = photos_data['feed']['entry'] rescue []
    return photo_entries if photo_entries.blank?
    photo_entries.map do |metadata|
      image_url = metadata['group']['thumbnail'].detect {|thumbnail| thumbnail['height'] == '288'}
      Photo.new(metadata['id'][1], self.album_id, metadata['group']['title'], image_url['url'])
    end
  end
end