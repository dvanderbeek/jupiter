class ContactsController < ApplicationController
	def add_contacts
		@contacts = request.env['omnicontacts.contacts']
	  current_user.contacts = @contacts
	  current_user.save
	  redirect_to '/invite_friends', notice: "Contacts imported!"
	end
end