require 'ostruct'

class VersionsController < ApplicationController
  before_filter :load_page

  def index
    authorize! :read, @page
    @versions = @page.versions
  end

  def show
    authorize! :read, @page
    @version = @page.versions.find version_params[:id]
  end

  def rollback
    authorize! :edit, @page
    @version = @page.versions.find version_params[:id]
    redirect_to @page, alert: 'Version not found' unless @version
    @page.title, @page.content = @version.title, @version.content
    @page.commit_message = "Rollback to the version #{version_params[:id]}"
    @page.editor_id = current_user.id
    @page.updated_at = Time.now
    @page.save
    redirect_to page_path(@page), notice: 'Rollback'
  end

  def diff
    authorize! :read, @page
    if version_params[:from] == '0' || version_params[:from].blank?
      @first_version = current_version
    else
      @first_version = Version.find(version_params[:from])
    end

    if version_params[:to] == '0' || version_params[:to].blank?
      @second_version = current_version
    else
      @second_version = Version.find(version_params[:to])
    end
  end

  

  private

  def load_page
    @page = @namespace.pages.find_by_slug "#{@namespace.name}:#{version_params[:page_id]}"
  end

  def current_version
    @current_version ||= OpenStruct.new(
      originator: User.find(@page.versions.last.user_id).username,
      created_at: @page.updated_at,
      object_updated_at: @page.updated_at,
      title: @page.title,
      content: @page.content)
  end

  def version_params
    params.permit(:page_id, :id, :from, :to)
  end
end

