require 'dotenv'
Dotenv.load

module Docbot
  require_relative 'docbot/documentation'
  require_relative 'docbot/slack/client'
  require_relative 'docbot/slack/message'
end
