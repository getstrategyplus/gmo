class Newsletter < ApplicationRecord
  has_many :news

  scope :sent_at_date, -> (date) { where(sent_at: date) }
  scope :next_sent_date, -> (date) { where('sent_at > ?', date).minimum(:sent_at) }
end
