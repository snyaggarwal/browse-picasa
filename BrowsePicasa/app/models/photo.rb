class Photo
  extend PicasaWeb

  attr_accessor :id, :album_id, :title, :image

  def initialize(id, album_id, title, image)
    self.id = id
    self.album_id = album_id
    self.title = title
    self.image = image
  end
end