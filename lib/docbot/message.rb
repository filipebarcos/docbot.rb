module Docbot
  class Message

    def initialize(botuser_id:, bot_class: Docbot)
      @bot_class = bot_class

      @valid_message_patterns = [
        /\A(\w+(\#|\:{2})\w+)\Z/,
        /\A\<\@?#{botuser_id}\>\:?\s(\w+(\#|\:{2})\w+)\Z/,
        /\Aplease explain\s(\w+(\#|\:{2})\w+)\Z/,
        /\A\<\@?#{botuser_id}\>\:?\splease explain\s(\w+(\#|\:{2})\w+)\Z/,
      ]
    end

    def parse(message)
      valid_message_patterns.map do |pattern|
        if message.match(pattern)
          bot_class.message($1)
        end
      end.compact.first
    end

    private
    attr_reader :bot_class, :valid_message_patterns
  end
end
