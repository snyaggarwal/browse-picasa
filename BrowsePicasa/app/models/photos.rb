class Photos
  include PicasaWeb

  attr_accessor :photos, :album_id, :album_name
  attr_accessor :access_token, :user_id
  alias_method :all, :photos

  MAX_PHOTOS_PER_ALBUM = 3

  def initialize(access_token, user_id, album_id, refresh_photos = true)
    self.access_token = access_token
    self.user_id = user_id
    self.album_id = album_id
    self.photos = refresh_photos ? parse(load_photos(access_token, user_id, album_id, MAX_PHOTOS_PER_ALBUM)) : []
  end

  def comment(photo_id, comment)
    post_comment({access_token: self.access_token, user_id: self.user_id, album_id: self.album_id, photo_id: photo_id, comment: comment})
  end

  private
  def parse(photos_data)
    photo_entries = photos_data['feed']['entry'] rescue []
    return photo_entries if photo_entries.blank?
    album_name = photos_data['feed']['title']
    photo_entries.inject([]) do |photos, metadata|
      if metadata.kind_of? Hash
        image_url = metadata['group']['thumbnail'].last
        photos << Photo.new(metadata['id'][1], self.album_id, metadata['group']['title'], image_url['url'], album_name)
      end
      photos
    end
  end
end