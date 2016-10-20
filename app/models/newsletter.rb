class Newsletter < ApplicationRecord
  has_many :news

  scope :sent_at_date, -> (date) { where(sent_at: date) }

  def self.next_sent_date(date)
    Newsletter.select(:sent_at).where('sent_at > ?', date).minimum(:sent_at) 
  end
end
