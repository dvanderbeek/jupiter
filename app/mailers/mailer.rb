class Mailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation(invitation, signup_url)
    @invitation = invitation
    @signup_url = signup_url
    mail(
      subject: "Invitation to join Jupiter!",
      to: invitation.recipient_email,
      from: "hello@jupiter.com"
    )
    invitation.update_attribute(:sent_at, Time.zone.now)
  end
end
