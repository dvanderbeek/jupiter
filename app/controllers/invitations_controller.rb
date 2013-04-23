class InvitationsController < ApplicationController
	def index
		@sent_invitations = current_user.sent_invitations.order('sent_at DESC')
	end

	def create
		@invitation = Invitation.new(params[:invitation])
	  @invitation.sender = current_user

	  if @invitation.save
	  	EmailWorker.perform_async(@invitation.id, signup_url(@invitation.token))
      redirect_to '/invitations', notice: "Your invitation has been sent!"
	  else
	  	puts "Failure"
	    redirect_to '/invite_friends', :flash => { :error => "There was an error sending your invitation!" }
	  end
	end

	def batch_create
		params[:emails].each do |email|
			@invitation = Invitation.new(recipient_email: email)
	  	@invitation.sender = current_user
	  	if @invitation.save
	  		EmailWorker.perform_async(@invitation.id, signup_url(@invitation.token))
	  	end
	  end
		redirect_to "/invitations", notice: "Your invitations are being sent.  Refresh the page and they will show up as they are processed."
	end
end