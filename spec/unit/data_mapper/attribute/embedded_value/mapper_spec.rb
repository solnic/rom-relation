require 'spec_helper'

describe Attribute::EmbeddedValue, '#mapper' do
  subject { attribute.mapper }

  let(:attribute) { described_class.new(:title, :type => model, :mapper => mapper) }
  let(:model)     { mock_model(:TestModel) }
  let(:mapper)    { mock('mapper') }

  it { should be(mapper) }
end
