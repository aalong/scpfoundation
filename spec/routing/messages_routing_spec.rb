require "spec_helper"

describe MessagesController do
  describe "routing" do

    # it "routes to #index" do
    #   get("/rooms/1/messages").should route_to("messages#index", room_id: "1")
    # end

    # it "routes to #new" do
    #   get("/rooms/1/messages/new").should route_to("messages#new", room_id: "1")
    # end

    it "routes to #show" do
      get("/rooms/1/messages/1").should route_to("messages#show", id: "1", room_id: "1")
    end

    # it "routes to #edit" do
    #   get("/rooms/1/messages/1/edit").should route_to("messages#edit", id: "1", room_id: "1")
    # end

    it "routes to #create" do
      post("/rooms/1/messages").should route_to("messages#create", room_id: "1")
    end

    # it "routes to #update" do
    #   put("/rooms/1/messages/1").should route_to("messages#update", room_id: "1", id: "1")
    # end

    # it "routes to #destroy" do
    #   delete("/rooms/1/messages/1").should route_to("messages#destroy", id: "1", room_id: "1")
    # end

  end
end
