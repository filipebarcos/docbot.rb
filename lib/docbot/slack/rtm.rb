module Docbot
  module Slack
    class Rtm
      START = 'rtm.start'

      def initialize(client = Client.new)
        @client = client
      end

      def self.start
        new.start
      end

      def start
        response = @client.request(path: START, params: opts)
        if response.has_key?("ok") && response["ok"]
          { url: response["url"], botuser: response["self"]["id"] }
        end
      end

      private

      attr_reader :client

      def opts
        { simple_latest: true, no_unreads: true }
      end
    end
  end
end
