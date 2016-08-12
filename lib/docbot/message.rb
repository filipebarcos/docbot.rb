module Docbot
  class Message

    def initialize(bot_user = Docbot)
      @bot_user = bot_user
    end

    def parse(message)
      VALID_MESSAGE_PATTERNS.map do |pattern|
        if message.match(pattern)
          bot_user.message($1)
        end
      end.compact.first
    end

    private
    attr_reader :bot_user

    VALID_MESSAGE_PATTERNS = [
      /\A(\w+(\#|\:{2})\w+)\Z/,
      /\A\@?docbot\:?\s(\w+(\#|\:{2})\w+)\Z/,
      /\Aplease explain\s(\w+(\#|\:{2})\w+)\Z/,
      /\A\@?docbot\:?\splease explain\s(\w+(\#|\:{2})\w+)\Z/,
    ]
  end
end
