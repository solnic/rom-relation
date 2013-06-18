require 'rom/support/axiom/adapter'
require 'rom/support/axiom/adapter/in_memory/gateway'

module Axiom
  module Adapter

    # A axiom in memory adapter
    #
    # This is basically a "null adapter"
    # as it doesn't make use of it's uri
    # and only passes through the given
    # +relation+ in {#gateway}
    #
    class InMemory
      extend Adapter

      include Concord::Public.new(:uri, :data)

      uri_scheme :in_memory

      # Initialize a new instance
      #
      # @param [Addressable::URI] uri
      #   the URI to use for establishing a connection
      #
      # @return [undefined]
      #
      # @api private
      def self.new(uri, data = {})
        super(uri, data)
      end

      # @api public
      def insert(name, tuple)
        storage     = data[name.to_sym]
        tuple_key   = storage.values.count + 1
        inserted    = tuple.unshift(tuple_key)

        storage[tuple_key] = inserted

        inserted
      end

      # Return the passed in relation
      #
      # @param [Axiom::Relation] relation
      #   the relation to be returned as is
      #
      # @return [Axiom::Relation]
      #
      # @api private
      def gateway(relation)
        data[relation.name.to_sym] = {}
        Gateway.new(self, relation)
      end

    end # class InMemory
  end # module Adapter
end # module Axiom
