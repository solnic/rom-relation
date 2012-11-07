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
          left  = relation.source
          right = other.relation.source

          # TODO: make the method accept a relationship and get the join keys from it
          join = left.join(right).on(left[:id].eq(right[:user_id])).order(left[:id])

          # TODO: come up with a more abstract way of representing joined header (in AliasSet or AttributeSet?)
          left_header = aliases.attributes.map { |attribute|
            "#{name}.#{attribute.field} AS #{aliases[attribute.name]}"
          }

          right_header = other.aliases.attributes.map { |attribute|
            "#{other.name}.#{attribute.field} AS #{other.aliases[attribute.name]}"
          }

          self.class.new(name, relation.new(join, left_header.concat(right_header)))
        end

        def base?
          # TODO: push it down to ArelEngine::Gateway
          relation.relation.kind_of?(Arel::Table)
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
