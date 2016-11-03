
class MailchimpSubscriptionJob < ApplicationJob
  queue_as :default
 
  def perform(email)
    gibbon = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key, debug: true)
    gibbon.lists('16f27fd2dc').members.create(body: {email_address: email, status: "subscribed"})
  end
end