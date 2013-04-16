class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :refresh_token, :provider, :uid, :contacts

  serialize :contacts

  def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	  	if user.oauth_token.blank?
		    user.provider = auth.provider
		    user.uid = auth.uid
		    user.name = auth.info.name
		    user.email = auth.info.email
		    user.oauth_token = auth.credentials.token
		    user.refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token
		    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		    user.save!
		  else
		  	# Refresh auth token from google_oauth2 and then requeue the job.
			  options = {
			    body: {
			      client_id: ENV['GOOGLE_CLIENT_ID'],
			      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
			      refresh_token: user.refresh_token,
			      grant_type: 'refresh_token'
			    },
			    headers: {
			      'Content-Type' => 'application/x-www-form-urlencoded'
			    }
			  }
			  @response = HTTParty.post('https://accounts.google.com/o/oauth2/token', options)
			  if @response.code == 200
			    user.oauth_token = @response.parsed_response['access_token']
			    user.oauth_expires_at = DateTime.now + @response.parsed_response['expires_in'].seconds
			    user.save        
			  else
			    Rails.logger.error("Unable to refresh google_oauth2 authentication token.")
			    Rails.logger.error("Refresh token response body: #{@response.body}")
			  end
		  	user.save!
		  end
	  end
	end

	# def facebook
	#   @facebook ||= Koala::Facebook::API.new(oauth_token)
	#   block_given? ? yield(@facebook) : @facebook
	# rescue Koala::Facebook::APIError => e
	#   logger.info e.to_s
	#   nil # or consider a custom null object
	# end
end
