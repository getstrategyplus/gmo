class Crawler::Archive

  @@url = 'http://static.getstrategyplus.com/archive'

  def newsletters
    @newsletters = load_newsletters
  end

  def reload
    Nokogiri::HTML(Net::HTTP.get(@@url))
  end

  private

  def parser
    @parser ||= reload
  end

  def load_newsletters
    parser.css('#public-issue-reader ul a').map do |n| 
      Newsletter.new(url: n['href'])
    end
  end
end
