class Photo
  extend PicasaWeb

  attr_accessor :id, :album_id, :title, :image, :album_name

  def initialize(id, album_id, title, image, album_name)
    self.id = id
    self.album_id = album_id
    self.title = title
    self.image = image
    self.album_name = album_name
  end
end