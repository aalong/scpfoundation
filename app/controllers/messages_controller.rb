class MessagesController < ApplicationController
  before_action :set_room
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  layout 'chat'
  authorize_resource

  # GET /messages
  # GET /messages.json
  # def index
  #   @messages = Message.all
  # end

  # GET /messages/1
  # GET /messages/1.json
  # def show
  # end

  # GET /messages/new
  # def new
  #   @message = Message.new
  # end

  # GET /messages/1/edit
  # def edit
  # end

  # POST /messages
  # POST /messages.json
  def create
    @message = current_user.messages.build(message_params.merge(room_id: @room.id))
    @message.message_type = 'message'

    respond_to do |format|
      if @message.save
        PrivatePub.publish_to "/rooms/#{@room.id}/messages/new",
          render_to_string("messages/update_messages.js.erb", layout: false)

        format.html { redirect_to @room, notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { redirect_to @room, alert: @message.errors.first }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /messages/1
  # DELETE /messages/1.json
  # def destroy
  #   @message.destroy
  #   respond_to do |format|
  #     format.html { redirect_to messages_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @room.messages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :type, :user_id, :room_id)
    end
end
