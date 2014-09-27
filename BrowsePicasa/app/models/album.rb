class Album
  attr_accessor :id, :link, :title, :credit, :image

  def initialize(id, link, title, image)
    self.id = id
    self.link = link
    self.title = title
    self.image = image
  end
end