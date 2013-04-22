class InvitationsController < ApplicationController
	def create
		@invitation = Invitation.new(params[:invitation])
	  @invitation.sender = current_user

	  if @invitation.save
	  	EmailWorker.perform_async(@invitation.id, signup_url(@invitation.token))
      redirect_to '/invites', notice: "Your invitation has been sent!"
	  else
	  	puts "Failure"
	    redirect_to '/invites', :flash => { :error => "There was an error sending your invitation!" }
	  end
	end
end