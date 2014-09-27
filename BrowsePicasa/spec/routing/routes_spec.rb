require 'spec_helper'

describe 'routes' do
  it 'should route to welcome index' do
    {get: '/' }.should route_to(controller: 'welcome', action: 'index')
  end
end