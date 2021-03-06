class Albums
  include PicasaWeb

  attr_accessor :albums
  attr_accessor :user_id, :access_token

  alias_method :all, :albums

  def initialize(user_id, access_token, refresh_albums = true)
    self.access_token = access_token
    self.user_id = user_id
    self.albums = refresh_albums ? parse(load_albums(user_id, access_token)) : []
  end

  def photos(album_id)
    Photos.new(self.access_token, self.user_id, album_id).all
  end

  private
  def parse(album_data)
    album_entries = album_data['feed']['entry'] rescue []
    return album_entries if album_entries.blank?
    album_entries.inject([]) do |albums, data|
      if data.is_a? Hash
        albums << Album.new(data['id'][1], data['id'][0], data['title'], data['group']['content']['url'])
      end
      albums
    end
  end
end