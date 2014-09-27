class User
  include PicasaWeb

  attr_accessor :user_id, :access_token

  def initialize(access_token)
    self.access_token = access_token
    id
  end

  def id
    self.user_id ||= profile(self.access_token)['id']
  end
end