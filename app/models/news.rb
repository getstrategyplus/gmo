class News < ApplicationRecord
  belongs_to :newsletter

  def source_name
    URI(self.address_url).host
  end
end
