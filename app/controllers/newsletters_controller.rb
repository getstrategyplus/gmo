class NewslettersController < ApplicationController

  class InvalidDateParam < StandardError ; end

  rescue_from InvalidDateParam, with: -> { redirect_to root_path, status: :moved_permanently  }

  def show
    @news_date = param_to_date(params[:date])
    @newsletters = Newsletter.sent_at_date(@news_date)
    @dates = Newsletter.get_dates_with_news
    gon.dates_with_news = @dates

     if @newsletters.empty?
       @news_date = Newsletter.next_sent_date(@news_date) 
       if @news_date
         redirect_to newsletter_show_path(date: date_to_param(@news_date)) 
       else
         @news_date = param_to_date(params[:date])
       end      
     end

    gon.next_url = newsletter_url(next_date(@news_date))
    gon.previous_url = newsletter_url(previous_date(@news_date))
  end

  private

  def newsletter_url(date)
    newsletter_show_url(date: date_to_param(date)) if date
  end

  def next_date(date)
    @dates&.to_a&.map{ |b| b.sent_at.to_date }.sort.reject { |i| i <= date }&.first
  end

  def previous_date(date)
    @dates&.to_a&.map{ |b| b.sent_at.to_date }.sort.reverse.reject { |i| i >= date }&.first
  end

  def date_to_param(date)
    date.strftime("%d-%m-%Y")
  end

  def param_to_date(date)
    begin
      if date
        Date.strptime(date, "%d-%m-%Y")
      else
        Date.today
      end
    rescue ArgumentError
      raise InvalidDateParam
    end
  end
end