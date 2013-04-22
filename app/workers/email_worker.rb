class EmailWorker
	include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(invitation_id, signup_url)
  	@invitation = Invitation.find(invitation_id)
  	Mailer.invitation(@invitation, signup_url).deliver
  end
end