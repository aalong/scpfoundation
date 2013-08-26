require 'spec_helper'

describe "Messages" do
  before(:each) do
    @user = Fabricate(:user)
    @room = Fabricate(:room)
    sign_in @user
  end

  describe "GET /messages" do
    it "works! (now write some real specs)" do
      visit room_messages_path(@room)
      response.status.should be(200)
    end
  end
end
