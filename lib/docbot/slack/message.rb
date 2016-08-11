module Docbot
  module Slack
    class Message
      POST_MESSAGE = 'chat.postMessage'

      def initialize(client = Client.new)
        @client = client
      end

      def send(text:, channel:)
        response = client.request(path: POST_MESSAGE, params: {
          text: text,
          channel: channel,
        })

        response.has_key?("ok") && response["ok"]
      end

      private
      attr_reader :client
    end
  end
end
