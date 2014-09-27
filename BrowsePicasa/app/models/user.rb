class User
  include PicasaWeb

  attr_accessor :id, :access_token


  def initialize(access_token)
    self.access_token = access_token
  end

  def id
    self.id = profile(self.access_token)['id']
  end

  def valid?
    !self.access_token.blank?
  end
end