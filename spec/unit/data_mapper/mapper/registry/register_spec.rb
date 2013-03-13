require 'spec_helper'

describe Mapper::Registry, '#register' do
  let(:model) { stub(:model) }
  let(:mapper) { stub(:mapper, :model => model) }

  it "stores the mapper in the Registry with a Registry::Identifier as its key" do
    ident = stub(:ident)
    Mapper::Registry::Identifier.stub!(:new).and_return(ident)

    subject.send(:mappers).should_receive(:[]=).with(ident, mapper)

    subject.register(mapper)
  end

  it "returns itself" do
    expect(subject.register(mapper)).to eq(subject)
  end

  context "when only provided with the mapper" do
    it "creates an Identifier with the model to be registered" do
      Mapper::Registry::Identifier.should_receive(:new).with(model, [])
      subject.register(mapper)       
    end
  end

  context "when provided both the mapper and the relationship it is mapping" do
    let(:relationship) { stub(:relationships) }

    it "creates an Indeitifer with both the model and the relationship" do
      Mapper::Registry::Identifier.should_receive(:new).with(model, relationship)
      subject.register(mapper, relationship)      
    end
  end
end
