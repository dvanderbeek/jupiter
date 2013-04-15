OmniAuth.config.logger = Rails.logger

Gon.global.FACEBOOK_APP_ID = ENV['FACEBOOK_APP_ID']
Gon.global.FACEBOOK_PERMISSION = ENV['FACEBOOK_PERMISSION']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], scope: ENV['FACEBOOK_PERMISSION']

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
  	approval_prompt: 'auto',
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar https://www.google.com/m8/feeds',
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
end