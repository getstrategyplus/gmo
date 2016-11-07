
class BufferNewsletterJob < ApplicationJob
  queue_as :default
 
  def perform(id)
    newsletter = Newsletter.find(id)
    url = Rails.application.routes.url_helpers.newsletter_show_url(date: newsletter.sent_at, host: 'getstrategyplus.com')

    client = Buffer::Client.new('1/9f76e6480849461d9f34bf1e29fefc26')

    create_update(client, 
      text: "#{newsletter.title} - #{url}", 
      image: newsletter.news.first.image, 
      services: ['twitter']
    )

    create_update(client, 
      text: "#{newsletter.title} - #{newsletter.excerpt} - #{url}", 
      image: newsletter.news.first.image,
      services: ['facebook', 'instagram']
    )

    unless newsletter.sent_at.sunday? || newsletter.sent_at.saturday?
      newsletter.news.each do |n|
        create_update(client, 
          text: "#{newsletter.title} - #{url}", 
          image: n.image, 
          services: ['twitter']
        )

        create_update(client, 
          text: "#{newsletter.title} - #{newsletter.excerpt} - #{url}", 
          image: n.image, 
          services: ['facebook', 'instagram']
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