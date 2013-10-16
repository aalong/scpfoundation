class MainController < ApplicationController
  before_filter :check_auth, except: :index

  def edits
    @pages = @namespace.pages.accessible_by(current_ability, :show).paginate(per_page: 30, page: params[:page]).order('updated_at DESC')
  end

  def new_pages
    @pages = @namespace.pages.accessible_by(current_ability, :show).paginate(per_page: 30, page: params[:page]).order('created_at DESC')
  end

  def comments
    @pages = @namespace.pages.accessible_by(current_ability, :show).order('created_at DESC')
    @comments = []
    @pages.each do |page|
      @comments = @comments + page.comments
    end
    @comments = @comments.sort_by(&:created_at).reverse.paginate(per_page: 30, page: params[:page])
  end

  def inbox
    @pages = Page.accessible_by(current_ability, :show).where( namespace_id: inbox_namespace.id )
    @comments = []
    @pages.each do |page|
      @comments = @comments + page.comments
    end
    @comments = @comments.sort_by(&:created_at).reverse.paginate(per_page: 30, page: params[:page])
  end

  def markdown_preview
    content = params[:content] || ''
    result = MarkdownParser.new(content).to_html.html_safe
    render text: result, layout: false
  end


  private

    def check_auth
      redirect_to(root_url, alert: 'Auth requested') unless current_user
    end

    def inbox_namespace
      @inbox_namesace ||= Namespace.find_by_name! 'inbox'
    end
end
