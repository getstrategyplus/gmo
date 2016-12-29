
class BufferNewsletterJob < ApplicationJob
  queue_as :default
 
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
      text: "#{newsletter.title} - #{ActionView::Helpers::SanitizeHelper.strip_tags(newsletter.excerpt)} - #{url}", 
      image: newsletter.news.first.image,
      services: ['facebook']
    )

    unless newsletter.sent_at.sunday? || newsletter.sent_at.saturday?
      newsletter.news.each do |n|
        create_update(client, 
          text: "#{news.title} - #{url}", 
          image: n.image, 
          services: ['twitter']
        )

        create_update(client, 
          text: "#{news.title} - #{ActionView::Helpers::SanitizeHelper.strip_tags(news.excerpt)} - #{url}", 
          image: n.image, 
          services: ['facebook']
        )
      end
    end
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