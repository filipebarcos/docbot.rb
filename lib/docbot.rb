require 'dotenv'
Dotenv.load
require_relative 'docbot/documentation'
require_relative 'docbot/slack/client'
require_relative 'docbot/slack/message'

module Docbot
  def self.message(class_method)
    documentation = Documentation.new.for(class_method)
    return fail_message(class_method) unless documentation
    wrap_backticks(documentation)
  end

  private

  def self.wrap_backticks(text)
    "```\n#{text}\n```"
  end

  def self.fail_message(text)
    "Sorry, I could not find documentation for `#{text}`."
  end
end
