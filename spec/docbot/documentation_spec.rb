require 'spec_helper'
require 'docbot/documentation'

RSpec.describe Docbot::Documentation do
  let(:array_push)  { FIXTURES[:array_push] }
  let(:array_class) { FIXTURES[:array_class] }

  describe '#for' do
    it 'returns documentation for Class#method' do
      expect(subject.for('Array#push')).to eq array_push
    end

    it 'retuns documentation for Class' do
      expect(subject.for('Array')).to eq array_class
    end

    it 'returns nil when cannot guess the doc for input' do
      expect(subject.for('Arruy#pash')).to be_nil
    end

    it 'returns nil when nil is given' do
      expect(subject.for(nil)).to be_nil
    end
  end
end
