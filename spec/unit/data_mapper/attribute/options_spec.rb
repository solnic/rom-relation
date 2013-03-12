require 'spec_helper'

describe Attribute, '#options' do
  subject { attribute.options }

  let(:attribute) { subclass.new(:full_name, options) }
  let(:options) { {:some_key => :some_value} }

  it { should eql(options) }
  it { should_not equal(options) }
  it { should be_frozen }
end
