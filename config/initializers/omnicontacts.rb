require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {:max_results => 10000}
  # importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => '/callback'}
  # importer :hotmail, "client_id", "client_secret"
end