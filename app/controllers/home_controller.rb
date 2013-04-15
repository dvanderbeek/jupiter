class HomeController < ApplicationController
  def index
  	begin
	    if current_user
		    #Use the token from the data to request a list of calendars
		    @token = current_user.oauth_token
		    client = Google::APIClient.new
		    client.authorization.access_token = @token
		    calendar = client.discovered_api('calendar', 'v3')
		    @calendar_list = client.execute(
		      :api_method => calendar.calendar_list.list,
		      :parameters => {},
		      :headers => {'Content-Type' => 'application/json'})

		    client2 = Google::APIClient.new
		    client2.authorization.access_token = @token
		    # contacts = client.discovered_api('contacts', 'v3')
		    
	  	end
	  rescue
	  	session[:user_id] = nil
    	redirect_to root_url
	  end
  end
end
