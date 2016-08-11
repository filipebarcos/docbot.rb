if ENV.fetch('RACK_ENV') != 'production'
  require 'dotenv'
  Dotenv.load
end

require 'json'
require_relative '../lib/docbot/documentation'
require_relative '../lib/docbot/slack/client'
require_relative '../lib/docbot/slack/message'
require_relative '../lib/docbot/websocket/event'
require_relative '../lib/docbot'
