class Photo
  extend PicasaWeb

  attr_accessor :id, :album_id, :title, :image
  def initialize(id, album_id, title, image)
    self.id = id
    self.album_id = album_id
    self.title = title
    self.image = image
  end

  def self.comment(token, user_id, album_id, photo_id, comment)
    self.post_comment(comment , {access_token: token, user_id: user_id, album_id: album_id, photo_id: photo_id})
  end
end