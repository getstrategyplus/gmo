module ApplicationHelper

  def page_title
    content_tag :title do
      content_for?(:title) ? "#{content_for(:title)} - Startup Cuts" : 'A newsletter to learn how to launch & run a great online business - Startup Cuts'
    end
  end

  def page_meta_description
    description = content_for?(:meta_description) ? content_for(:meta_description) : 'Startup Cuts is the smartest way to keep track of awesome content regarding how to launch and operate a successful, global, digital business.'
    tag :meta, name: 'description', content: sanitize(truncate(description, length: 150))
  end
end
