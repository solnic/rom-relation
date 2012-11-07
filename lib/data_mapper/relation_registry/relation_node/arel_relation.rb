module DataMapper
  class RelationRegistry
    class RelationNode < Graph::Node

      # Relation node wrapping arel relation
      #
      class ArelRelation < self
        include Enumerable

        def each(&block)
          return to_enum unless block_given?
          relation.each do |row|
            yield(row.symbolize_keys!)
          end
          self
        end

        def join(other)
          raise NotImplementedError

          left  = relation
          right = other.relation

          left.join(right).on(left[:id].eq(right[:user_id]))
        end

        def base?
          relation.kind_of?(Arel::Table)
        end

        def rename(new_aliases)
          raise NotImplementedError
        end

        def header
          raise NotImplementedError
        end

        def restrict(*args, &block)
          raise NotImplementedError
        end

        def sort_by(&block)
          raise NotImplementedError
        end

      end # class ArelRelation

    end # class RelationNode
  end # class RelationRegistry
end # module DataMapper
