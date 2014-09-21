require 'spec_helper'

describe 'routes' do
  it 'should route to home index' do
    {get: '/' }.should route_to(controller: 'home', action: 'index')
  end
end