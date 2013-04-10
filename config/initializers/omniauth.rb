OmniAuth.config.logger = Rails.logger

Gon.global.FACEBOOK_APP_ID = ENV['FACEBOOK_APP_ID']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], scope: 'email'
end