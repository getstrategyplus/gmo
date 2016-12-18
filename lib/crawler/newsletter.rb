class Crawler::Newsletter < Struct.new(:address_url)

  def title
    parser.at_css('#templateBody .mcnTextContent h3').text
  end

  def excerpt
    parser.css('#templateBody .mcnTextContent p')[1].inner_html
  end

  def sent_at
    Date.new(*URI(self.address_url).path.split('/')[1..3].map(&:to_i))
  end

  def news
    parser.css('.mcnTextContentContainer table').map do |node|
      Crawler::News.new(node)
    end
  end

  def reload
    @parser = Nokogiri::HTML(Net::HTTP.get(URI("#{self.address_url}?body=true")))
  end

  private

  def parser
    @parser ||= reload
  end
end
