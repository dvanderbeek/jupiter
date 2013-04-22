class ContactsController < ApplicationController
	def add_contacts
		@contacts = request.env['omnicontacts.contacts']
	  current_user.contacts = @contacts
	  current_user.save
	  redirect_to '/invites', notice: "Contacts imported!"
	end
end