require 'spec_helper'

describe Attribute, '#type' do
  subject { attribute.type }

  let(:attribute) { subclass.new(:title, EMPTY_HASH) }

  it { should be_nil }
end
