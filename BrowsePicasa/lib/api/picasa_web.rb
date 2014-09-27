require 'net/http'
require 'open-uri'

module PicasaWeb
  $user_data = 'http://picasaweb.google.com/data/feed/api/user/'
  $profile_url = 'https://www.googleapis.com/plus/v1/people/me?access_token='
  $revoke_url = 'https://accounts.google.com/o/oauth2/revoke?token='
  $albums_url = 'https://picasaweb.google.com/data/feed/api/user/'
  $photos_url = "https://picasaweb.google.com/data/feed/api/user/%{user_id}/albumid/%{album_id}?max-results=%{max_limit}&kind=photo&access_token=%{access_token}"
  $post_comments_url = "https://picasaweb.google.com/data/feed/api/user/%{user_id}/albumid/%{album_id}/photoid/%{photo_id}?kind=comment&access_token=%{access_token}"

  def load_albums(user_id, access_token)
    res = open($albums_url + user_id + '?kind=album&access_token=' + access_token)
    Hash.from_xml(res.read)
  end

  def load_photos(access_token, user_id, album_id, limit)
    photos_end_point = $photos_url % { user_id: user_id, album_id: album_id, max_limit: limit, access_token: access_token }
    res = open(photos_end_point)
    Hash.from_xml(res.read)
  end

  def profile(token, headers={})
    end_point = URI.parse($profile_url + token)
    request = Net::HTTP.new(end_point.host, end_point.port)
    request.use_ssl = true
    res = request.get(end_point.request_uri)
    log_response(end_point, res)
    JSON.parse(res.body)
  end

  def disconnect(token)
    end_point = URI.parse($revoke_url + token)
    request = Net::HTTP.new(end_point.host, end_point.port)
    request.use_ssl = true
    res = request.get(end_point.request_uri)
    log_response(end_point, res)
    res.code
  end

  def post_comment(comment, params)
    comments_end_point = URI.parse($post_comments_url % params)

    comment = "<entry xmlns='http://www.w3.org/2005/Atom'> <content>%{comment}</content> <category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#comment'/> </entry>" % comment

    resp, data = Net::HTTP.post_form(comments_end_point, comment)
  end

  private
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