require 'spec_helper'

describe WelcomeController, type: :controller do
  it 'should return 200' do
    get :index

    expect(response.status).to eq(200)
  end
end