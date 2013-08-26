require 'spec_helper'

describe MessagesController do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { Fabricate.attributes_for(:message) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    @user = Fabricate(:member)
    sign_in @user
    @room = Fabricate(:room)
  end

  # describe "GET index" do
  #   it "assigns all messages as @messages" do
  #     message = Message.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:messages).should eq([message])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested message as @message" do
  #     message = Message.create! valid_attributes
  #     get :show, {:id => message.to_param}, valid_session
  #     assigns(:message).should eq(message)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new message as @message" do
  #     get :new, {}, valid_session
  #     assigns(:message).should be_a_new(Message)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested message as @message" do
  #     message = Message.create! valid_attributes
  #     get :edit, {:id => message.to_param}, valid_session
  #     assigns(:message).should eq(message)
  #   end
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, room_id: @room.id, message: valid_attributes
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, room_id: @room.id, message: valid_attributes
        assigns(:message).should be_a(Message)
        assigns(:message).should be_persisted
      end

      it "redirects to the created message" do
        post :create, room_id: @room.id, message: valid_attributes
        response.should redirect_to(@room)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, room_id: @room.id, message: valid_attributes.merge(message_type: 'foobar')
        assigns(:message).should be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, room_id: @room.id, message: valid_attributes.merge(message_type: 'foobar')
        response.should redirect_to(@room)
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested message" do
  #       message = Message.create! valid_attributes
  #       # Assuming there are no other messages in the database, this
  #       # specifies that the Message created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Message.any_instance.should_receive(:update).with({ "content" => "MyText" })
  #       put :update, {:id => message.to_param, :message => { "content" => "MyText" }}, valid_session
  #     end

  #     it "assigns the requested message as @message" do
  #       message = Message.create! valid_attributes
  #       put :update, {:id => message.to_param, :message => valid_attributes}, valid_session
  #       assigns(:message).should eq(message)
  #     end

  #     it "redirects to the message" do
  #       message = Message.create! valid_attributes
  #       put :update, {:id => message.to_param, :message => valid_attributes}, valid_session
  #       response.should redirect_to(message)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the message as @message" do
  #       message = Message.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Message.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => message.to_param, :message => { "content" => "invalid value" }}, valid_session
  #       assigns(:message).should eq(message)
  #     end

  #     it "re-renders the 'edit' template" do
  #       message = Message.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Message.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => message.to_param, :message => { "content" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested message" do
  #     message = Message.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => message.to_param}, valid_session
  #     }.to change(Message, :count).by(-1)
  #   end

  #   it "redirects to the messages list" do
  #     message = Message.create! valid_attributes
  #     delete :destroy, {:id => message.to_param}, valid_session
  #     response.should redirect_to(messages_url)
  #   end
  # end

end
