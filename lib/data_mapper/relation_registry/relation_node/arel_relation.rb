module DataMapper
  class RelationRegistry
    class RelationNode < Graph::Node

      # Relation node wrapping arel relation
      #
      class ArelRelation < self
        include Enumerable

        # @see {RelationNode#initialize}
        def initialize(name, relation, aliases)
          super
        end

        # @api public
        def each(&block)
          return to_enum unless block_given?
          relation.each do |row|
            yield(row.symbolize_keys!)
          end
          self
        end

        # @api private
        def join(other, relationship)
          source     = relation.arel_table
          source_key = source[relationship.source_key]

          target = if relationship.via
            via = DataMapper[relationship.source_model].relationships[relationship.via]
            relation.engine.relations[via.name].relation
          else
            other.relation
          end.arel_table

          target_key   = target[via ? via.target_key : relationship.target_key]
          left, right  = other.base? ? [ source, other.relation.relation ] : [ other.relation.relation, source ]

          join         = left.join(right).on(source_key.eq(target_key)).order(source_key)
          join_aliases = aliases.join(other.aliases)

          self.class.new(name, relation.new(join, join_aliases), join_aliases)
        end

        # @api private
        def base?
          # TODO: push it down to ArelEngine::Gateway
          relation.relation.kind_of?(Arel::Table)
        end

        # @api public
        def [](name)
          relation.relation[name]
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
