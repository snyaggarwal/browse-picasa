class Albums
  include PicasaWeb

  attr_accessor :albums

  def initialize(user_id, access_token)
    self.albums = parse(load_albums(user_id, access_token))
  end


  private
  def parse(album_data)
    albums = album_data['feed']['entry']
    albums.map do |data|
      Album.new(data['id'][1], data['id'][0], data['title'], data['group']['content']['url'])
    end

  end
end