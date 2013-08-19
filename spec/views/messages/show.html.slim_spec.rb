require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :content => "MyText",
      :type => "Type",
      :user_id => 1,
      :room_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
