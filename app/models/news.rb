class News < ApplicationRecord
  belongs_to :source
  belongs_to :newsletter
end
