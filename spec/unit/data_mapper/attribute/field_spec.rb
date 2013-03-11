require 'spec_helper'

describe Attribute, '#field' do
  subject { attribute.field }

  let(:attribute) { subclass.new(:title, options) }

  context 'when "to" option given' do
    let(:options) { {:to => :bookTitle} }

    it { should be(:bookTitle) }
  end

  context 'when "to" option is not given' do
    let(:options) { EMPTY_HASH }

    it 'defaults to name' do
      subject.should be(:title)
    end
  end
end
