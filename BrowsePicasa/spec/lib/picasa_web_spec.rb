# -*- encoding : utf-8 -*-
require 'spec_helper'

class Dummy
  include PicasaWeb
end

describe 'PicasaWeb' do
  before(:each) do
    @dummy_class = Dummy.new
  end

  describe 'HTTP get, post and delete' do
    let(:token) { 'access_token' }
    let(:mock_http) { double('http') }
    let(:http_response) { double 'Net::HTTPResponse' }

    it 'should call Net/HTTP get services on profile' do
      expect(http_response).to receive(:read).and_return('{ "photo": [ { "id": 1 } ] }')
      expect(@dummy_class).to receive(:open).with('https://www.googleapis.com/plus/v1/people/me?access_token=access_token').and_return(http_response)

      response = @dummy_class.profile(token)

      expect(response).to eq({ 'photo' => [{ 'id' => 1 }] })
    end

    it 'should call Net/HTTP get services on disconnect' do
      expect(http_response).to receive(:status).and_return(['200', 'OK'])
      expect(@dummy_class).to receive(:open).with('https://accounts.google.com/o/oauth2/revoke?token=access_token').and_return(http_response)

      response = @dummy_class.disconnect(token)

      expect(response).to eq('200')
    end

    it 'should convert xml to hash on album load' do
      expect(http_response).to receive(:read).and_return("<id>1</id>")
      expect(@dummy_class).to receive(:open).with('https://picasaweb.google.com/data/feed/api/user/user_id?kind=album&access_token=access_token').and_return(http_response)

      response = @dummy_class.load_albums('user_id', token)

      expect(response).to eq({ 'id' => '1' })
    end

    it 'should convert xml to hash on photos load' do
      expect(http_response).to receive(:read).and_return("<id>1</id>")
      expect(@dummy_class).to receive(:open).with('https://picasaweb.google.com/data/feed/api/user/user_id/albumid/album_id?max-results=3&kind=photo&access_token=access_token').and_return(http_response)

      response = @dummy_class.load_photos(token, 'user_id', 'album_id', 3)

      expect(response).to eq({ 'id' => '1' })
    end

    it 'should call Net/HTTP post services on comment post' do
      mock_uri = double('uri', host: 'picasaweb.google.com', port: '80', request_uri: 'https://picasaweb.google.com/data/feed/api/user/user_id/albumid/album_id/photoid/photo_id?kind=comment&access_token=%access_token')

      mock_response = double(Net::HTTPResponse)

      expect(URI).to receive(:parse)
                     .with('https://picasaweb.google.com/data/feed/api/user/user_id/albumid/album_id/photoid/photo_id?kind=comment&access_token=token')
                     .and_return(mock_uri)
      expect(Net::HTTP).to receive(:new).with(mock_uri.host, mock_uri.port).and_return(mock_http)
      expect(Net::HTTP::Post).to receive(:new).with(mock_uri.request_uri, {"Content-type"=>"application/atom+xml"}).and_return(mock_response)
      expect(mock_response).to receive(:body=).with("<entry xmlns='http://www.w3.org/2005/Atom'> <content>comment</content> <category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#comment'/></entry>")
      expect(mock_http).to receive(:start).and_yield(mock_http)
      expect(mock_http).to receive(:use_ssl=).with(true)
      expect(http_response).to receive(:code).and_return('201')
      expect(mock_http).to receive(:request).with(mock_response).and_return(http_response)


      response = @dummy_class.post_comment({ comment: 'comment', access_token: 'token', user_id: 'user_id', album_id: 'album_id', photo_id: 'photo_id' })

      expect(response).to eq('201')
    end
  end
end