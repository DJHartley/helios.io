class Web < Sinatra::Base
  set :markdown, layout_engine: :haml

  helpers do
    def markdown(template, options = {}, locals = {})
      options.merge!({
        hard_wrap: true,
        filter_html: true,
        autolink: true,
        no_intraemphasis: true,
        fenced_code_blocks: true,
        gh_codeblock: true,
        with_toc_data: true
      })

      render(:markdown, template, options.merge(renderer: Redcarpet::Render::HTML.new), locals)
    end
  end

  get '/' do
    haml :index
  end
end

module Haml::Filters::Markdown
  require 'redcarpet/compat'
  include Haml::Filters::Base

  def render(text)
    ::Markdown.new(text).to_html
  end
end
