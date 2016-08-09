require 'spec_helper'
require 'docbot'

RSpec.describe Docbot do
  describe '.message' do
    let(:doc_double) { double(Docbot::Documentation) }
    let(:class_method) { 'Class#method' }

    before do
      expect(Docbot::Documentation)
        .to receive(:new)
        .and_return(doc_double)

      expect(doc_double)
        .to receive(:for)
        .with(class_method)
        .and_return(doc_return)
    end

    context 'when documentation is found' do
      let(:doc_return) { 'docs' }

      it 'responds with documentation wrapped in backticks' do
        expect(Docbot.message(class_method)).to eq "```\n#{doc_return}\n```"
      end
    end

    context 'when documentation is not found' do
      let(:doc_return) { nil }

      it 'replies with polite message' do
        expect(Docbot.message(class_method)).to eq "Sorry, I could not find documentation for #{class_method}."
      end
    end
  end
end
