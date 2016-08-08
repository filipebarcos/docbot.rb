require 'httparty'

module Docbot
  module Slack
    class Client
      def initialize(token = ENV.fetch('SLACK_API_TOKEN'))
        @token = token
      end

      def request(path:, params:)
        response = HTTParty.get(uri(path), query: params.merge(default_params))
        parse_response(response.body)
      end

      private

      attr_reader :token
      BASE_URL = 'https://slack.com/api/'

      def parse_response(body)
        begin
          JSON.parse(body)
        rescue => e
          body
        end
      end

      def uri(path)
        URI.join(BASE_URL, path)
      end

      def default_params
        { token: token, as_user: true }
      end
    end
  end
end
