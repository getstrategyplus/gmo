
class BufferNewsletterJob < ApplicationJob
  queue_as :default
  
  include ActionView::Helpers::SanitizeHelper
  
  def perform(id)
    newsletter = Newsletter.find(id)
    url = Rails.application.routes.url_helpers.newsletter_show_url(date: newsletter.sent_at.strftime("%d-%m-%Y"), host: 'getstrategyplus.com')

    client = Buffer::Client.new(Rails.application.secrets.buffer_api_key)

    create_update(client, 
      text: "#{newsletter.title} - #{url}", 
      image: newsletter.news.first.image, 
      services: ['twitter', 'instagram']
    )

    create_update(client, 
      text: "#{newsletter.title} - #{strip_tags(newsletter.excerpt)} - #{url}", 
      image: newsletter.news.first.image,
      services: ['facebook']
    )
  end

  private

  def create_update(client, text: '', image: '', services: [])
    profile_ids = client.profiles.delete_if { |p| !services.include?(p.service) }.map(&:id)

    client.create_update(body: { 
      text: text,
      shorten: services.include?('twitter'),
      profile_ids: profile_ids, 
      media: { photo: image}
    })
  end
end