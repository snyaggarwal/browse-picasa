require 'spec_helper'

describe SessionController, type: :controller do

  it 'should create session with access_token' do
    get :create, {access_token: 'token'}

    expect(session[:access_token]).to eq 'token'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq({'data' => 'success'})
  end

  it 'should disconnect user and clear session' do
    session[:access_token] = 'token'
    expect(controller).to receive(:disconnect).and_return('200')

    delete :logout

    expect(session).to be_empty
    expect(response).to redirect_to root_path
  end

  it 'should raise error if unable to disconnect' do
    session[:access_token] = 'token'
    expect(controller).to receive(:disconnect).and_return('500')
    expect(session).not_to receive(:clear)

    expect{ delete :logout }.to raise_error
  end
end