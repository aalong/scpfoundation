require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message,
      :content => "MyText",
      :type => "",
      :user_id => 1,
      :room_id => 1
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", messages_path, "post" do
      assert_select "textarea#message_content[name=?]", "message[content]"
      assert_select "input#message_type[name=?]", "message[type]"
      assert_select "input#message_user_id[name=?]", "message[user_id]"
      assert_select "input#message_room_id[name=?]", "message[room_id]"
    end
  end
end
