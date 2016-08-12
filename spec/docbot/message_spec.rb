require 'docbot/message'

RSpec.describe Docbot::Message do
  describe '#parse' do
    let(:bot_class)     { double(Docbot) }
    let(:documentation) { 'some docs' }
    let(:botuser_id)    { 'YADA'}
    subject { described_class.new(botuser_id: botuser_id, bot_class: bot_class) }

    context 'when message contains only Class(#||::)method' do
      before { allow(bot_class).to receive(:message).and_return(documentation) }

      it 'replies with formatted documentation for Class#method asked' do
        expect(subject.parse('Class#method')).to eq documentation
      end

      it 'replies with formatted documentation for Class::method asked' do
        expect(subject.parse('Class::method')).to eq documentation
      end
    end

    context 'when message has a mention' do
      before do
        allow(bot_class)
          .to receive(:message)
          .with('Class#method')
          .and_return(documentation)
      end

      it 'replies with formatted documentation for Class#method asked' do
        expect(subject.parse('<@YADA>: Class#method')).to eq documentation
        expect(subject.parse('<@YADA> Class#method')).to eq documentation
      end
    end

    context 'when message includes a polite request for docs' do
      before do
        allow(bot_class)
          .to receive(:message)
          .with('Class::method')
          .and_return(documentation)
      end

      it 'replies with formatted documentation for Class::method asked' do
        expect(subject.parse('please explain Class::method')).to eq documentation
      end
    end

    context 'when message includes a polite request and a mention' do
      before do
        allow(bot_class)
          .to receive(:message)
          .with('Class::method')
          .and_return(documentation)
      end

      it 'replies with formatted documentation for Class::method asked' do
        expect(subject.parse('<@YADA> please explain Class::method')).to eq documentation
      end
    end

    context 'when no pattern is satisfied' do
      it 'ignores the message and returns nil' do
        expect(subject.parse('<@YADA> please explain')).to be_nil
      end
    end
  end
end
