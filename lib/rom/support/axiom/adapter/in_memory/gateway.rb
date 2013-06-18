module Axiom
  module Adapter
    class InMemory

      class Gateway < Axiom::Relation
        include Concord.new(:adapter, :relation)

        DECORATED_CLASS = superclass

        # remove methods so they can be proxied
        undef_method *DECORATED_CLASS.public_instance_methods(false).map(&:to_s) - %w[ materialize ]
        undef_method :project, :remove, :extend, :rename, :restrict, :sort_by, :reverse, :drop, :take

        def each(&block)
          if relation.materialized?
            relation.each(&block)
          else
            adapter.read(relation).each(&block)
          end
        end

        def insert(tuples)
          inserted = []

          tuples.each do |tuple|
            inserted << adapter.insert(relation.name, tuple)
          end

          relation.insert(inserted)
        end

        private

        def method_missing(method, *args, &block)
          forwardable?(method) ? forward(method, *args, &block) : super
        end

        def forwardable?(method)
          relation.respond_to?(method)
        end

        def forward(*args, &block)
          inner_relation = relation
          response = inner_relation.public_send(*args, &block)
          if response.equal?(inner_relation)
            self
          elsif response.kind_of?(DECORATED_CLASS)
            self.class.new(adapter, response)
          else
            response
          end
        end

      end # Gateway

    end # InMemory
  end # Adapter
end # Axiom
