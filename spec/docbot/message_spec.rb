require 'docbot/message'

RSpec.describe Docbot::Message do
  describe '#parse' do
    let(:bot_user)      { double(Docbot) }
    let(:documentation) { 'some docs' }
    subject { described_class.new(bot_user) }

    context 'when message contains only Class(#||::)method' do
      before { allow(bot_user).to receive(:message).and_return(documentation) }

      it 'replies with formatted documentation for Class#method asked' do
        expect(subject.parse('Class#method')).to eq documentation
      end

      it 'replies with formatted documentation for Class::method asked' do
        expect(subject.parse('Class::method')).to eq documentation
      end
    end

    context 'when message has a mention' do
      before do
        allow(bot_user)
          .to receive(:message)
          .with('Class#method')
          .and_return(documentation)
      end

      it 'replies with formatted documentation for Class#method asked' do
        expect(subject.parse('@docbot: Class#method')).to eq documentation
        expect(subject.parse('@docbot Class#method')).to eq documentation
      end
    end

    context 'when message includes a polite request for docs' do
      before do
        allow(bot_user)
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
        allow(bot_user)
          .to receive(:message)
          .with('Class::method')
          .and_return(documentation)
      end

      it 'replies with formatted documentation for Class::method asked' do
        expect(subject.parse('docbot please explain Class::method')).to eq documentation
      end
    end

    context 'when no pattern is satisfied' do
      it 'ignores the message and returns nil' do
        expect(subject.parse('@dobot please explain')).to be_nil
      end
    end
  end
end
