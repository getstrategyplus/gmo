class Crawler::Archive

  @@address_url = 'http://static.getstrategyplus.com/archive'

  def newsletters
    parser.css('#public-issue-reader ul a').map do |n| 
      Crawler::Newsletter.new(URI.join(@@address_url, n['href']).to_s)
    end
  end

  def reload
    @parser = Nokogiri::HTML(Net::HTTP.get(URI(@@address_url)))
  end

  private

  def parser
    @parser ||= reload
  end

end
