namespace :crawler do

  desc 'Scrape newsletters from Goodbits and save in app database.'
  task fetch: :environment do
    ::CrawlerJob.new.sync
  end
end