class NewslettersController < ApplicationController

  class InvalidDateParam < StandardError ; end

  rescue_from InvalidDateParam, with: -> { redirect_to root_path, status: :moved_permanently  }

  def show
    @news_date = param_to_date(params[:date])
    @newsletters = Newsletter.sent_at_date(@news_date)
    
    if @newsletters.empty?
      @news_date = Newsletter.next_sent_date(@news_date) 

      if @news_date
        redirect_to newsletter_show_path(date: date_to_param(@news_date))
      else
        redirect_to root_path 
      end
    end
  end

  private

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
