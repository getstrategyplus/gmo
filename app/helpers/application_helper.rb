module ApplicationHelper

  def page_title
    content_tag :title do 
      content_for?(:title) ? "#{content_for(:title)} - Strategy+" : 'A simple newsletter made by experts to understand global politics - Strategy+'
    end
  end

  def page_meta_description
    description = content_for?(:meta_description) ? content_for(:meta_description) : 'Strategy+ is the smartest way to follow various topics about the global political agenda. Receive every day a small email to receive a briefing about key geopolitical issues.'
    tag :meta, name: 'description', content: sanitize(truncate(description, length: 150))
  end
end
