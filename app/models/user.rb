class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :refresh_token, :provider, :uid, :activity_ids, :contacts, :invitation_token

  has_many :calendars
  has_many :activities_users
  has_many :activities, through: :activities_users
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
	belongs_to :invitation

  serialize :contacts

  def first_name
  	name.to_s.split(" ")[0]
  end

  def invitation_token
	  invitation.token if invitation
	end

	def invitation_token=(token)
	  self.invitation = Invitation.find_by_token(token)
	end

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
