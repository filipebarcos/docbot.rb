require 'docbot/slack/message'
require 'docbot/slack/client'

RSpec.describe Docbot::Slack::Message do
  describe '#send' do
    let(:client)       { double(Docbot::Slack::Client) }
    let(:message_text) { 'yada, yolo' }
    let(:channel)      { 'my-channel' }

    subject { described_class.new(client) }

    it 'sends specific text to a slack channel using client' do
      expect(client).to receive(:request).with(hash_including({
        params: { text: message_text, channel: channel }
      })).and_return({"ok": true})

      subject.send(text: message_text, channel: channel)
    end
  end
end
