namespace :db do

  desc 'Populates all your development database with fake data.'
  task populate: :environment do
    return unless Rails.env.development?

    [News, Source, Newsletter].map(&:delete_all)
    
    euronews = Source.create({ address_url: 'http://www.euronews.com/', name: 'Euronews' })
    bbc = Source.create({ address_url: 'http://www.bbc.com/', name: 'BBC' })
    spiegel = Source.create({ address_url: 'http://www.spiegel.de/', name: 'Der Spiegel' })

    newsletter = Newsletter.create( 
      title: 'The civil war in Syria keeps going on (first page)', 
      excerpt: %{Today we explore the latest events unfolding in Syria's civil war. U.S. & Russia superpowers can't seem to agree.
      Raids keep occurring on Syrians forces, rebels and IS as well as UN convoy. China is surprisingly absent and the UN remains week.},
      sent_at: Date.today
    )

    News.create(
      title: 'Eurozone Q2 growth weakens',
      excerpt: 'There was only weak growth again for the eurozone economy between April and June.',
      address_url: 'http://www.euronews.com/2016/09/06/eurozone-q2-growth-weakens',
      image: 'http://www.placehold.it/116x116',
      image_alt: 'Eurozone Growth Fears',
      source: euronews,
      newsletter: newsletter
    )

    News.create(
      title: 'Bayer rises bid price for Monsanto',
      excerpt: 'Bayer’s quest to become the world’s largest producer of seeds and pesticides has led it to bump up the price it is willing to pay for US firm Monsanto.',
      address_url: 'http://www.bbc.com/news/business-37281453',
      image: 'http://www.placehold.it/116x116',
      image_alt: 'Bayer buys Monsanto',
      source: bbc,
      newsletter: newsletter
    )

    newsletter = Newsletter.create( 
      title: 'The civil war in Syria keeps going on (second page)', 
      excerpt: %{Today we explore the latest events unfolding in Syria's civil war. U.S. & Russia superpowers can't seem to agree.
      Raids keep occurring on Syrians forces, rebels and IS as well as UN convoy. China is surprisingly absent and the UN remains week.},
      sent_at: Date.yesterday
    )

    News.create(
      title: 'Eurozone Q2 growth weakens',
      excerpt: 'There was only weak growth again for the eurozone economy between April and June.',
      address_url: 'http://www.euronews.com/2016/09/06/eurozone-q2-growth-weakens',
      image: 'http://www.placehold.it/116x116',
      image_alt: 'Eurozone Growth Fears',
      source: euronews,
      newsletter: newsletter
    )

    News.create(
      title: 'Bayer rises bid price for Monsanto',
      excerpt: 'Bayer’s quest to become the world’s largest producer of seeds and pesticides has led it to bump up the price it is willing to pay for US firm Monsanto.',
      address_url: 'http://www.bbc.com/news/business-37281453',
      image: 'http://www.placehold.it/116x116',
      image_alt: 'Bayer buys Monsanto',
      source: bbc,
      newsletter: newsletter
    )          
  end
end