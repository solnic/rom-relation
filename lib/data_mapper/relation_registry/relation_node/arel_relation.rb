module DataMapper
  class RelationRegistry
    class RelationNode < Graph::Node

      # Relation node wrapping arel relation
      #
      class ArelRelation < self
        include Enumerable

        attr_reader :relations
        attr_reader :gateway

        # @see {RelationNode#initialize}
        def initialize(name, relation, aliases)
          super
          @relations = relation.engine.relations
          @gateway   = relation
        end

        # @api public
        def each(&block)
          return to_enum unless block_given?
          gateway.each do |row|
            yield(row.symbolize_keys!)
          end
          self
        end

        # @api private
        def join(other, relationship)
          left  = (relationship.through ? relations[relationship.through].gateway : gateway).relation
          right = other.gateway.relation

          left_key, right_key =
            if relationship.through
              [ left[relationship.via_source_key], right[relationship.via_target_key] ]
            else
              [ left[relationship.source_key], right[relationship.target_key] ]
            end

          source = gateway.relation
          target = other.gateway.relation

          join         = source.join(target).on(left_key.eq(right_key)).order(left_key)
          join_aliases = aliases.join(other.aliases)

          self.class.new(name, relation.new(join, join_aliases), join_aliases)
        end

        # @api private
        def base?
          # TODO: push it down to ArelEngine::Gateway
          gateway.relation.kind_of?(Arel::Table)
        end

        # @api public
        def [](name)
          gateway.relation[name]
        end

        # @api private
        def rename(new_aliases)
          raise NotImplementedError
        end

        # @api private
        def header
          raise NotImplementedError
        end

        # @api private
        def restrict(*args, &block)
          raise NotImplementedError
        end

        # @api private
        def sort_by(&block)
          raise NotImplementedError
        end

      end # class ArelRelation

    end # class RelationNode
  end # class RelationRegistry
end # module DataMapper
