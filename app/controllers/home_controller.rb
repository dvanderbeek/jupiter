class HomeController < ApplicationController
  def index
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

	    @contacts = []
	    unless current_user.contacts.nil?
		    current_user.contacts.each do |contact|
		    	@contacts.push contact[:email]
		    end
		  end
  	end
  end
end
