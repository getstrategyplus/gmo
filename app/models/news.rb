class News < ApplicationRecord
  belongs_to :newsletter

  alias_attribute :url, :address_url

  def source_name
    URI(self.address_url).host.gsub(/^www./,'').split('.').first.upcase
  end
end
