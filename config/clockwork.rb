require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(5.minutes, 'crawler.fetch') { ::CrawlerJob.perform_later }
end