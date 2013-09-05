class MarkdownParser
  def initialize text
    @text = text

    if Rails.env == "production"
      @domain = 'scpfoundation.net'
    else
      @domain = 'scpfoundation.dev'
    end
  end

  def to_html
    parse @text
  end

  private

  def parse text
    post (markdown_parse (pre text))
  end

  def markdown_parse(text)
    renderer_params = {
      hard_wrap: true,
      filter_html: true,
      with_toc_data: true
    }

    markdown_params = {
      tables: true,
      no_intra_emphasis: true,
      # autolink: true,
      strikethrough: true,
      fenced_code_blocks: true,
      superscript: true
    }

    renderer = Redcarpet::Render::HTML.new(renderer_params)
    markdown = Redcarpet::Markdown.new(renderer, markdown_params)
    markdown.render(text)
  end

  def pre(text)
    result = text.gsub(/(\D)(\=|%|x|х)(\)|\(){1,}/i, '\1:\3')

    result
  end

  def post(text)
    result = text.gsub(/\[left\]([\S\s]*?)\[\/left\]/i,'<div class="left-align">\1</div>')
    result = result.gsub(/\[right\]([\S\s]*?)\[\/right\]/i,'<div class="right-align">\1</div>')
    result = result.gsub(/\[center\]([\S\s]*?)\[\/center\]/i,'<div class="center-align">\1</div>')
    result = result.gsub(/\^(.*?)\^/i,'<small>\1</small>')
    result = result.gsub(/\(c\)/i, '&copy;')
    result = result.gsub(/\(r\)/i, '&reg;')
    result = result.gsub(/\(tm\)/i, '&trade;')
    result = result.gsub(/\.{3,}/i, '&hellip;')
    result = result.gsub(/\s--\s/i, '&mdash;')
    result = result.gsub(/\[img (\w+) ([\w.\-\:\/]+) ([\wа-яА-Я\d\s\-\:]+)\]/i, 
      '<p class="\1 img"><a href="\2" rel="external"><img src="\2" alt="\3"></a><span>\3</span></p>')
    toggle_regexp = /\[toggle \&quot\;(.*?)\&quot\; \&quot\;(.*?)\&quot\;\]([\s\S]*)\[\/toggle\]/i
    result =~ toggle_regexp
    result = result.gsub(toggle_regexp,
      "<div class=\"toggle\">
        <span class=\"hide_action\">#{$2}</span>
        <span class=\"show_action\">#{$1}</span>
        <span class=\"fold_action\">#{$1}</span>
        <div class='spoiler'>
          #{$3}
        </div>
      </div>")
    result = result.gsub /\[\[([\w.\-\_\/]+)\:([\w.\-\_\/]+)\s*\|\s*([\wа-яА-Я\d\s\-\:\!\?]+)\]\]/, '<a href="http://\1.' + @domain + '/\2">\3</a>'
    result = result.gsub /\[\[([\w.\-\_\/]+)\s*\|\s*([\wа-яА-Я\d\s\-\:\!\?]+)\]\]/, '<a href="http://' + @domain + '/\1">\2</a>'
    result = result.gsub /\[\[\*([\w.\-\_\/]+)\]\]/, '<a href="http://' + @domain + '/users/\1">\1</a>'
    result = result.gsub /\[\[([\w.\-\_\/]+)\]\]/, '<a href="http://' + @domain + '/\1">\1</a>'
  end
end
