require 'docbot/websocket/event'

RSpec.describe Docbot::Websocket::Event do
  describe '#handle' do
    subject { described_class.new(raw_data: raw_data) }
    context 'when data fails to be parsed' do
      let(:raw_data) { nil }

      it 'is handled like every other non specific event' do
        expect(subject.handle).to eq({ ok: false })
      end
    end

    context 'when data is successfully parsed' do
      context 'when data type is message' do
        context 'when message text contains only Class#method' do
          let(:raw_data) { JSON.generate({type: 'message', text: 'Array#push', channel: 'channel'}) }

          before do
            expect(Docbot)
              .to receive(:message)
              .with('Array#push')
              .and_return('doc_message')
          end

          it 'returns documentation' do
            expect(subject.handle).to eq({
              ok: true,
              message: 'doc_message',
              channel: 'channel',
            })
          end
        end

        context 'when is just a general message' do
          let(:raw_data) { JSON.generate({type: 'message', text: 'yada yada yolo yolo'}) }

          it 'returns default construct' do
            expect(subject.handle).to eq({ ok: false })
          end
        end
      end

      context 'when is any other data type' do
        let(:raw_data) { JSON.generate({type: 'other'}) }

        it 'returns a default construct so we can act accordingly' do
          expect(subject.handle).to eq({ ok: false })
        end
      end
    end
  end
end
