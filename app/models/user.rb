class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :refresh_token, :provider, :uid, :activity_ids

  has_many :contacts
  has_many :calendars
  has_many :activities_users
  has_many :activities, through: :activities_users

  def google_client
    @google_client ||= Google::APIClient.new(:application_name => "Jupiter")
    @google_client.authorization.access_token = self.oauth_token
    return @google_client
  end

  def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.email = auth.info.email
	    user.oauth_token = auth.credentials.token
	    user.refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!
	  end
	end
	
end
