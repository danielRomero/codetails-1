require 'dragonfly'
require 'dragonfly/mongoid_data_store'
# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "5caf521942015a57192c5cfb5974ea4b1fe78b7c2467f02462ea24319e9ac89e"

  url_format "/media/:job/:name"

  datastore :mongoid
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
