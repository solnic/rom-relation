require 'spec_helper'

describe Attribute, '#finalize' do
  subject { attribute.finalize }

  let(:attribute) { subclass.new(:title, EMPTY_HASH) }

  it { should be(attribute) }
end
