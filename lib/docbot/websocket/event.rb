module Docbot
  module Websocket
    class Event
      module Types
        MESSAGE = 'message'.freeze
      end

      attr_reader :data

      def initialize(raw)
        @raw = raw
        @data = parse
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
      attr_reader :raw

      def parse
        JSON.parse(raw)
      rescue => e
        {}
      end

      def handle_message_event
        if message = Docbot::Message.new.parse(data['text'])
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
