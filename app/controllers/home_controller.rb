class HomeController < ApplicationController
	def events
		calendar = current_user.google_client.discovered_api('calendar', 'v3')
		@calendar_list = current_user.google_client.execute(
	      :api_method => calendar.calendar_list.list,
	      :parameters => {},
	      :headers => {'Content-Type' => 'application/json'})
		if params[:page_token].nil?
	    @events ||= current_user.google_client.execute(
	    	api_method: calendar.events.list,
	    	parameters: {'calendarId' => 'earlynovrock@gmail.com'},
	    	headers: {'Content-Type' => 'application/json'}
	    )
	  else
	  	@events ||= current_user.google_client.execute(
	    	api_method: calendar.events.list,
	    	parameters: {'calendarId' => 'earlynovrock@gmail.com', 'pageToken' => params[:page_token]},
	    	headers: {'Content-Type' => 'application/json'}
	    )
	  end
	end

  def index
  	if params[:invitation_token]
  		@invite = Invitation.find_by_token(params[:invitation_token])
  	end



    if current_user
	    #Use the token from the data to request a list of calendars
	    # current_user.google_client.authorization.access_token = current_user.oauth_token
	    calendar = current_user.google_client.discovered_api('calendar', 'v3')
	    @calendar_list = current_user.google_client.execute(
	      :api_method => calendar.calendar_list.list,
	      :parameters => {},
	      :headers => {'Content-Type' => 'application/json'})

	    @events ||= current_user.google_client.execute(
	    	api_method: calendar.events.list,
	    	parameters: {'calendarId' => 'primary', 'max_results' => '10000', 'time_max' => Time.zone.now},
	    	headers: {'Content-Type' => 'application/json'}
	    )

	    @activities = Activity.all

	    @invitation = Invitation.new

	    @sent_invitations = current_user.sent_invitations.order('sent_at DESC')

	    @contacts = []
	    unless current_user.contacts.nil?
		    current_user.contacts.each do |contact|
		    	@contacts.push contact[:email]
		    end
		  end
  	end
  end

  def activities
  	@activities = Activity.all
  end

  def invites
    if current_user
	    @invitation = Invitation.new

	    @sent_invitations = current_user.sent_invitations.order('sent_at DESC')

	    @contacts = []
	    unless current_user.contacts.nil?
		    current_user.contacts.each do |contact|
		    	@contacts.push contact[:email]
		    end
		  end
  	end
  end
end
