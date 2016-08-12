module Docbot
  module Websocket
    class Event
      module Types
        MESSAGE = 'message'.freeze
      end

      attr_reader :data

      def initialize(botuser_id: nil, raw_data:)
        @raw_data = raw_data
        @data = parse
        @botuser_id = botuser_id
      end

      def handle
        case data['type']
        when Types::MESSAGE
          handle_message_event
        else
          handle_other_events
        end
      end

      private
      attr_reader :raw_data, :botuser_id

      def parse
        JSON.parse(raw_data)
      rescue => e
        {}
      end

      def handle_message_event
        if message = Docbot::Message.new(botuser_id: botuser_id).parse(data['text'])
          { ok: true, message: message, channel: data['channel'] }
        else
          { ok: false }
        end
      end

      def handle_other_events
        { ok: false }
      end
    end
  end
end
