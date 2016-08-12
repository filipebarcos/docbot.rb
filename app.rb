require_relative './config/boot'
require 'faye/websocket'
require 'eventmachine'

Signal.trap("INT")  { exit }
Signal.trap("TERM") { exit }

EM.run do
  response = Docbot::Slack::Rtm.start
  ws_url = response[:url]
  botuser_id = response[:botuser]

  ws = Faye::WebSocket::Client.new(ws_url)

  ws.on(:open) { |_| puts "Connected to Slack Chat" }

  ws.on :message do |event|
    ws_event = Docbot::Websocket::Event.new(botuser_id: botuser_id, raw_data: event.data)
    puts "[#{Time.now.utc.iso8601}] Received: #{ws_event.data.inspect}"

    response = ws_event.handle
    Docbot::Slack::Message.new.send(
      text: response[:message],
      channel: response[:channel]
    ) if response.has_key?(:message) && response.has_key?(:channel)
  end

  ws.on :close do |_|
    puts "Closing WS connection..."
    ws = nil
  end
end
