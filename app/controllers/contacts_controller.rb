class ContactsController < ApplicationController
	def add_contacts
		@contacts = request.env['omnicontacts.contacts']
	  @contacts.each do |contact|
	  	@contact = current_user.contacts.where(email: contact[:email]).first_or_initialize do |contact|
	  		contact.name = contact[:name] if contact[:name]
		  	contact.email = contact[:email]
		  	contact.save
	  	end
	  end
	  redirect_to root_url
	end
end