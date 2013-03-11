require 'spec_helper'

describe Attribute, '#key?' do
  subject { attribute.key? }

  let(:attribute) { subclass.new(:full_name, options) }

  context 'when key is given' do
    let(:options) { {:key => 'name'} }
    it { should be(true) }
  end

  context 'when key is not given' do
    let(:options) { EMPTY_HASH }
    it { should be(false) }
  end
end
