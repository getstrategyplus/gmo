class Newsletter < ApplicationRecord
  has_many :news, dependent: :destroy

  scope :sent_at_date, -> (date) { where(sent_at: date) }

  after_commit :send_to_buffer, on: [:create]

  def self.next_sent_date(date)
    Newsletter.select(:sent_at).where('sent_at > ?', date).minimum(:sent_at) 
  end

  def self.get_dates_with_news
  	Newsletter.select('sent_at').group(:sent_at).order(:sent_at)
  end

  def send_to_buffer
    BufferNewsletterJob.perform_later(self.id)
  end
end
