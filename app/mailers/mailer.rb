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

    attachments.inline['jupiter-logo.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/logo.jpg")
    attachments.inline['accept-invite.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/accept-invite.jpg")
    attachments.inline['step1.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step1.jpg")
    attachments.inline['step2.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step2.jpg")
    attachments.inline['step3.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step3.jpg")
    attachments.inline['step1-large.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step1-large.jpg")
    attachments.inline['step2-large.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step2-large.jpg")
    attachments.inline['step3-large.jpg'] = File.read("#{Rails.root}/app/assets/images/emails/step3-large.jpg")

    mail(
      subject: "Invitation to join Jupiter!",
      to: invitation.recipient_email,
      from: "hello@jupiter.com"
    )
    invitation.update_attribute(:sent_at, Time.zone.now)
  end
end
