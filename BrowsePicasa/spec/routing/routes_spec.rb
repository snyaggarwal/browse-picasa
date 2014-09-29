require 'spec_helper'

describe 'routes' do
  it 'should route to right destinations' do
    expect({ get: '/' }).to route_to(controller: 'welcome', action: 'index')
    expect({ post: 'login' }).to route_to(controller: 'session', action: 'create')
    expect({ delete: 'logout' }).to route_to(controller: 'session', action: 'logout')
    expect({ get: 'api/albums' }).to route_to(controller: 'api/albums', action: 'all')
    expect({ get: 'api/albums/:id/photos' }).to route_to(controller: 'api/albums', action: 'photos', id: ':id')
    expect({ post: 'api/albums/:album_id/photos/:id/comment' }).to route_to(controller: 'api/photos', action: 'comment', id: ':id', album_id: ':album_id')
  end
end