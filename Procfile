web: puma -C config/puma.rb 
worker: bundle exec rake jobs:work
scheduler: bundle exec clockwork config/clockwork.rb