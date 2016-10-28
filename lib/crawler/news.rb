class Crawler::News

  def initialize(node)
    @node = node
  end

  def title
    @node.css('a').last.text
  end

  def excerpt
    @node.css('p').first.text
  end

  def address_url
    @node.css('a').last['href']
  end

  def image
    @node.css('img').first['src']
  end

  def image_alt
    @node.css('img').first['alt']
  end
end
