class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :history]
  authorize_resource

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all.accessible_by(current_ability).paginate(per_page: 40, page: params[:page])
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @messages = @room.messages.last(150)
  end

  def history
    @messages = @room.messages.reverse.paginate(per_page: 30, page: params[:page])
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = current_user.rooms.build(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render action: 'show', status: :created, location: @room }
      else
        format.html { render action: 'new' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      if current_user.staff?
        params.require(:room).permit(:title, :description, :topic, :access, user_ids: [])
      else
        params.require(:room).permit(:title, :description, :topic, user_ids: [])
      end
    end
end
