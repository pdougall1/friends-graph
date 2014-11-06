require 'spec_helper'

describe 'sessions' do

  describe "GET sessions/:provider", :vcr do

    it "is successful" do
      get 'sessions/linkedins'
      expect(response.status).to eql(200)
    end

    it "adds a session" do
      expect{ get 'sessions/linkedin' }.to change { Session.count }.by 1
    end
  end

end
