class ContactMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']
  layout 'mailer'

  def contact_email contact
    @contact = contact
    mail(to: contact.destination, subject: contact.subject)
  end
end
