module DataMapper
  class RelationRegistry
    class RelationNode < Graph::Node

      # Relation node wrapping arel relation
      #
      class ArelRelation < self
        include Enumerable

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
          source     = relation.source
          target     = other.relation.source
          source_key = source[relationship.source_key]
          target_key = target[relationship.target_key]
          join       = source.join(target).on(source_key.eq(target_key)).order(source_key)

          self.class.new(name, relation.new(join, join_header(other)))
        end

        # @api private
        def base?
          # TODO: push it down to ArelEngine::Gateway
          relation.relation.kind_of?(Arel::Table)
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

        private

        # TODO: come up with a more abstract way of representing joined header
        #
        # @api private
        def join_header(other)
          left_header = aliases.attributes.map { |attribute|
            "#{name}.#{attribute.field} AS #{aliases[attribute.name]}"
          }

          right_header = other.aliases.attributes.map { |attribute|
            "#{other.name}.#{attribute.field} AS #{other.aliases[attribute.name]}"
          }

          left_header.concat(right_header)
        end

      end # class ArelRelation

    end # class RelationNode
  end # class RelationRegistry
end # module DataMapper
