class NewsletterController < ApplicationController
  def show
    @newsletters = Newsletter.all
  end
end
