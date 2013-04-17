class InvitationsController < ApplicationController
	def create
		@invitation = Invitation.new(params[:invitation])
	  @invitation.sender = current_user
	  if @invitation.save
      Mailer.invitation(@invitation, signup_url(@invitation.token)).deliver
      redirect_to root_url, notice: "Your invitation has been sent!"
	  else
	  	puts "Failure"
	    redirect_to root_url, notice: "There was a problem sending your invitation."
	  end
	end
end