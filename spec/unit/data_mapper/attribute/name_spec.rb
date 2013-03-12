require 'spec_helper'

describe Attribute, '#name' do
  subject { attribute.name }

  let(:attribute) { subclass.new(:title, EMPTY_HASH) }

  it { should be(:title) }
end
