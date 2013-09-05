module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def markdown text
    MarkdownParser.new(text).to_html.html_safe
  end

  def avatar_url(user, size=100)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "//gravatar.com/avatar/#{gravatar_id}.png?size=#{size}"
  end

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def footer(footer_text, show_footer = true)
    content_for(:footer) { h(footer_text.to_s) }
    @show_footer = show_footer
  end

  def show_footer?
    if @show_footer.nil?
      true
    else
      @show_footer
    end
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
