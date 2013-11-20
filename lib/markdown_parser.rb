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
      autolink: false,
      strikethrough: true,
      fenced_code_blocks: true,
      superscript: true
    }

    renderer = Redcarpet::Render::HTML.new(renderer_params)
    markdown = Redcarpet::Markdown.new(renderer, markdown_params)
    markdown.render(text)
  end

  def pre(text)
    result = text

    result = result.gsub(/(\D)(\=|%|x|х)(\)|\(){1,}/i, '\1:\3')


    # wikidot export block

    result = result.gsub(/\[\[\>\]\]([\S\s]*?)\[\[\/\>\]\]/i,'[right]\1[/right]')
    result = result.gsub(/\[\[=\]\]([\S\s]*?)\[\[\/=\]\]/i,'[center]\1[/center]')
    result = result.gsub(/\[\[\<\]\]([\S\s]*?)\[\[\/\<\]\]/i,'[left]\1[/left]')
    result = result.gsub(/\/\/(.*?)\/\//i, '*\1*')
    result = result.gsub("[[module Rate]]", '')

    result = result.gsub('[[div class="rimg"]]', '[[div class="right"]]')
    result = result.gsub('[[div class="cimg"]]', '[[div class="center"]]')
    result = result.gsub('[[div class="limg"]]', '[[div class="left"]]')
    result = result.gsub(/\[\[div class=\"(\w+)\"\]\]\s*\[\[image (.*?) [\s\S]*\]\]\s*\[\[span\]\]([\s\S]+?)\[\[\/span\]\]\s*\[\[\/div\]\]/i, '[img \1 resure.net/scp/\2 \3]')
    result = result.gsub(/\[\[\[(.*?)\]\]\]/i, '[[\1]]')
    result = result.gsub(/\[\[\[\/(.*?)\]\]\]/i, '[[/\1]]')
    result = result.gsub(/(?<=[^\[])\[([\w-]+)\](?=[^\]])/i, '[[\1]]')
    result = result.gsub(/^#(.*?)$/i, '1. \1')
    result = result.gsub(/\[\[collapsible\s*show="(.*?)"\s*hide="(.*?)"\s*\]\]([\s\S]*)\[\[\/collapsible\]\]/i, '[toggle "\1" "\2"]\3[/toggle]')

    result
  end

  def post(text)
    result = text

    result = result.gsub(/\[left\]([\S\s]*?)\[\/left\]/i,'<div class="left-align">\1</div>')
    result = result.gsub(/\[right\]([\S\s]*?)\[\/right\]/i,'<div class="right-align">\1</div>')
    result = result.gsub(/\[center\]([\S\s]*?)\[\/center\]/i,'<div class="center-align">\1</div>')
    result = result.gsub(/\^(.*?)\^/i,'<small>\1</small>')
    result = result.gsub(/\(c\)/i, '&copy;')
    result = result.gsub(/\(r\)/i, '&reg;')
    result = result.gsub(/\(tm\)/i, '&trade;')
    result = result.gsub(/\.{3,}/i, '&hellip;')
    result = result.gsub(/\s--\s/i, '&mdash;')
    result = result.gsub(/\[img (\w+) ([\w.,\/_:-]+) ([\wа-яА-Яё\d\s.,:_«»-]+)\]/i,
      '<p class="\1 img"><a href="//\2" rel="external"><img src="//\2" alt="\3"></a><span>\3</span></p>')
    result = result.gsub(/\[toggle &quot;(.*?)&quot; &quot;(.*?)&quot;\]([\s\S]*?)\[\/toggle\]/i,
      '<div class="toggle">
        <span class="hide_action">\2</span>
        <span class="show_action">\1</span>
        <span class="fold_action">\1</span>
        <div class="spoiler">
          \3
        </div>
      </div>')
    result = result.gsub /\[\[([\w.\-\_\/]+)\:([\w.\-\_\/#]+)\s*\|\s*([\wа-яА-Я\d\s\-\:\!\?.,#'"&;]+)\]\]/i, '<a href="http://\1.' + @domain + '/\2">\3</a>'
    result = result.gsub /\[\[([\w.,\-\_\/#]+)\s*\|\s*([\wа-яА-Я\d\s\-\:\!\?,.#'"&;]+)\]\]/i, '<a href="http://' + @domain + '/\1">\2</a>'
    result = result.gsub /\[\[\*([\w.,\-\_\/#]+)\]\]/i, '<a href="http://' + @domain + '/users/\1">\1</a>'
    result = result.gsub /\[\[([\w.,\-\_\/#]+)\]\]/i, '<a href="http://' + @domain + '/\1">\1</a>'
  end
end
