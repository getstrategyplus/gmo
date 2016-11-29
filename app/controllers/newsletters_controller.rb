class NewslettersController < ApplicationController

  class InvalidDateParam < StandardError ; end

  rescue_from InvalidDateParam, with: -> { redirect_to root_path, status: :moved_permanently  }

  def show
    @news_date = param_to_date(params[:date])
    @newsletters = Newsletter.sent_at_date(@news_date)
    gon.dates_with_news = Newsletter.get_dates_with_news
    gon.base_url = request.domain
    gon.current_index = get_index(@news_date)
    
    #puts @dates_with_news.to_json
    #abort
    
     if @newsletters.empty?
       @news_date = Newsletter.next_sent_date(@news_date) 
       if @news_date
         redirect_to newsletter_show_path(date: date_to_param(@news_date)) 
       else
         @news_date = param_to_date(params[:date])
       end      
     end

  end

  private

  def date_to_param(date)
    date.strftime("%d-%m-%Y")
  end

  def get_index (date)
    
    index = 0
    gon.dates_with_news.each do |date_with_news|         
      if date > date_with_news.sent_at
        puts date.to_s + " > " + date_with_news.sent_at.to_s        
        gon.dates_with_news[index].sent_at = date_to_param(date_with_news.sent_at)        
        index = index + 1        
      else
        puts date.to_s + " <= " + date_with_news.sent_at.to_s
        gon.dates_with_news[index].sent_at = date_to_param(date_with_news.sent_at)        
        return index  
      end

    end
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