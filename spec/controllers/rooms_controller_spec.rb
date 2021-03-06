require 'spec_helper'

describe RoomsController do

  # This should return the minimal set of attributes required to create a valid
  # Room. As you add validations to Room, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { Fabricate.attributes_for(:room) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RoomsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    @user = Fabricate(:member)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all rooms as @rooms" do
      Room.destroy_all
      room = Room.create! valid_attributes
      get :index, {}, valid_session
      assigns(:rooms).should eq([room])
    end
  end

  describe "GET show" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes
      get :show, {:id => room.to_param}, valid_session
      assigns(:room).should eq(room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      get :new, {}, valid_session
      assigns(:room).should be_a_new(Room)
    end
  end

  describe "GET edit" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes.merge(user_id: @user.id)
      get :edit, {:id => room.to_param}, valid_session
      assigns(:room).should eq(room)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Room" do
        expect {
          post :create, {:room => valid_attributes}, valid_session
        }.to change(Room, :count).by(1)
      end

      it "assigns a newly created room as @room" do
        post :create, {:room => valid_attributes}, valid_session
        assigns(:room).should be_a(Room)
        assigns(:room).should be_persisted
      end

      it "redirects to the created room" do
        post :create, {:room => valid_attributes}, valid_session
        response.should redirect_to(Room.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        post :create, {:room => { "title" => "invalid value" }}, valid_session
        assigns(:room).should be_a_new(Room)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        post :create, {:room => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @room = Fabricate(:room, user_id: @user.id)
    end

    describe "with valid params" do
      # it "updates the requested room" do
      #   room = Fabricate(:private_room, user_id: @user.id)
      #   # Assuming there are no other rooms in the database, this
      #   # specifies that the Room created on the previous line
      #   # receives the :update_attributes message with whatever params are
      #   # submitted in the request.
      #   room.should_receive(:update).with({ "title" => "MyString" })
      #   put :update, {:id => room.to_param, :room => { "title" => "MyString" }}, valid_session
      # end

      it "assigns the requested room as @room" do
        put :update, {:id => @room.to_param, :room => valid_attributes}, valid_session
        assigns(:room).should eq(@room)
      end

      it "redirects to the room" do
        put :update, {:id => @room.to_param, :room => valid_attributes}, valid_session
        response.should redirect_to(@room)
      end
    end

    describe "with invalid params" do
      it "assigns the room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        Room.any_instance.stub(:save).and_return(false)
        put :update, {:id => @room.to_param, :room => { "title" => nil }}, valid_session
        assigns(:room).should eq(@room)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        @room.stub(:save).and_return(false)
        put :update, {:id => @room.to_param, :room => { "title" => nil }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  # describe "DELETE destroy" do
  #   it "destroys the requested room" do
  #     room = Room.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => room.to_param}, valid_session
  #     }.to change(Room, :count).by(-1)
  #   end

  #   it "redirects to the rooms list" do
  #     room = Room.create! valid_attributes
  #     delete :destroy, {:id => room.to_param}, valid_session
  #     response.should redirect_to(rooms_url)
  #   end
  # end

end
