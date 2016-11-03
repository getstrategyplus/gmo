class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def subscribe
    MailchimpSubscriptionJob.perform_later params[:email]
  end
end
