require 'net/http'
require 'open-uri'

module PicasaWeb
  $user_data = 'http://picasaweb.google.com/data/feed/api/user/'
  $profile_url = 'https://www.googleapis.com/plus/v1/people/me?access_token='
  $revoke_url = 'https://accounts.google.com/o/oauth2/revoke?token='
  $albums_url = 'https://picasaweb.google.com/data/feed/api/user/%{user_id}?kind=album&access_token=%{access_token}'
  $photos_url = "https://picasaweb.google.com/data/feed/api/user/%{user_id}/albumid/%{album_id}?max-results=%{max_limit}&kind=photo&access_token=%{access_token}"
  $post_comments_url = "https://picasaweb.google.com/data/feed/api/user/%{user_id}/albumid/%{album_id}/photoid/%{photo_id}?kind=comment&access_token=%{access_token}"

  def load_albums(user_id, access_token)
    get_xml_and_return_hash_for($albums_url % {access_token: access_token, user_id: user_id})
  end

  def load_photos(access_token, user_id, album_id, limit)
    get_xml_and_return_hash_for($photos_url % { user_id: user_id, album_id: album_id, max_limit: limit, access_token: access_token })
  end

  def profile(token)
    get_json_for($profile_url + token)
  end


  def disconnect(token)
    res = open($revoke_url + token)
    res.status[0]
  end

  def post_comment(params)
    comment = "<entry xmlns='http://www.w3.org/2005/Atom'> <content>%{comment}</content> <category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#comment'/></entry>" % params
    comments_end_point = URI.parse($post_comments_url % params)
    http = Net::HTTP.new(comments_end_point.host, comments_end_point.port)
    http.use_ssl = true
    response = http.start do |http|
      req = Net::HTTP::Post.new(comments_end_point.request_uri, {'Content-type' => 'application/atom+xml' })
      req.body = comment
      http.request(req)
    end
    response.code
  end

  private
  def get_json_for(url)
    res = open(url)
    JSON.parse(res.read)
  end

  def get_xml_and_return_hash_for(end_point)
    res = open(end_point)
    Hash.from_xml(res.read)
  end

  def log_response(request, response)
    if has_error_status_code(response)
      if Rails.logger
        Rails.logger.info(request)
        Rails.logger.info(response.body)
      end
    end
  end

  def has_error_status_code(response)
    (response.code != '200') && (response.code != '201')
  end

  def set_timeout(http)
    http.read_timeout = 30
    http.open_timeout = 30
  end

end