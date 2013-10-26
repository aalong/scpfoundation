class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = @namespace.pages.accessible_by(current_ability).paginate(per_page: 30, page: params[:page])
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    begin
      @page = @namespace.pages.accessible_by(current_ability).find_by_slug! "#{@namespace.name}:#{params[:id]}"
      authorize! :read, @page
      render :show
    rescue ActiveRecord::RecordNotFound
      render :page_not_found, status: 404
    end
  end

  # GET /pages/new
  def new
    @page = @namespace.pages.build
    authorize! :use, @namespace
  end

  # GET /pages/1/edit
  def edit
    authorize! :use, @namespace
  end

  # POST /pages
  # POST /pages.json
  def create
    authorize! :use, @namespace
    @page = @namespace.pages.build(page_params.merge(user_id: current_user.id, editor_id: current_user.id, commit_message: "Page creation"))

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    authorize! :use, @namespace
    respond_to do |format|
      if @page.update(page_params.merge(editor_id: current_user.id))
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    authorize! :destroy, @page
    authorize! :use, @namespace
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = @namespace.pages.accessible_by(current_ability).find_by_slug "#{@namespace.name}:#{params[:id]}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :content, :name, :slug, :commit_message, :namespace_id, :tag_list, user_ids: [])
    end
end

