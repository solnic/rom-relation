require 'spec_helper'

describe Axiom::Adapter::InMemory::Gateway do
  subject(:gateway) { adapter.gateway(relation) }

  let(:data)     { Hash.new }
  let(:adapter)  { Axiom::Adapter::InMemory.new('::memory::', data) }
  let(:relation) { Axiom::Relation::Base.new(:users, [ [:id, Integer], [:name, String] ]) }

  describe '#insert' do
    it 'updates data in the hash' do
      operation = gateway.insert [ [ 'Jane' ] ]

      expect(operation.to_a).to eq([ [ 1, 'Jane' ] ])
      expect(data[:users]).to include(1 => [ 1, 'Jane' ])
    end
  end

  describe '#to_a' do
    before do
      gateway.insert [ [ 'Jane' ], [ 'John' ] ]
    end

    it 'returns tuples' do
      tuples = gateway.to_a.map(&:to_ary)

      expect(tuples).to eq([[1, 'Jane'], [2, 'John']])
    end
  end
end
