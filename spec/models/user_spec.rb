require 'spec_helper'

describe User do

  subject(:user) { FactoryGirl.create(:user) }
  let(:other_user) { user.connected_users.create(first_name: 'Other') }

  it "can have a connected user" do
    expect(other_user.first_name).to eq('Other')
  end

end
