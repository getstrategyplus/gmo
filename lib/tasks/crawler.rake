namespace :crawler do

  require 'crawler/crawler'

  desc 'Scrape newsletters from Goodbits and save in app database.'
  task fetch: :environment do

    a = Crawler::Archive.new
    a.newsletters.each do |nt|
      newsletter = ::Newsletter.find_or_create_by(address_url: nt.address_url)

      newsletter.title = nt.title
      newsletter.sent_at = nt.sent_at
      newsletter.excerpt = nt.excerpt

      newsletter.save

      nt.news.each do |n|
        news = newsletter.news.find_or_create_by(address_url: n.address_url)

        news.title = n.title
        news.excerpt = n.excerpt
        news.image = n.image
        news.image_alt = n.image_alt

        news.save
      end

    end  
  end
end