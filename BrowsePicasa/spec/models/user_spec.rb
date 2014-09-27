require 'spec_helper'

describe User, type: :model do
  it 'should return get user profile and return id' do
    expect_any_instance_of(User).to receive(:profile).exactly(1).times.with('token').and_return({'id' => 'user_id'})
    user = User.new('token')
    expect(user.id).to eq('user_id')
    expect(user.id).to eq('user_id') # to assert that PicasaWeb.profile is not called twice
  end
end