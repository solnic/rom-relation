require 'spec_helper'

describe Attribute::EmbeddedValue, '#finalize' do
  let(:attribute) { described_class.new(:title, options) }
  let(:options)   { {:type => model } }
  let(:mapper)    { mock('mapper') }
  let(:model)     { mock_model(:TestModel) }

  context 'when with mapper' do
    subject { attribute.finalize(mock('registry')) }
    before { options[:mapper] = mapper }

    it { should be(attribute) }

    its(:mapper) { should be(mapper) }
  end

  context 'when without mapper' do
    subject { attribute.finalize(model => mapper) }

    it { should be(attribute) }

    its(:mapper) { should be(mapper) }

    it 'remaps mapper with aliases when aliases given' do
      aliases = [mock('alias')]
      options[:aliases] = aliases

      new_mapper = mock('new mapper')
      mapper.stub(:remap).with(aliases) { new_mapper }

      subject.mapper.should be(new_mapper)
    end

    it 'does not remap mapper when no aliases given' do
      mapper.should_not_receive(:remap)
      subject
    end
  end
end
