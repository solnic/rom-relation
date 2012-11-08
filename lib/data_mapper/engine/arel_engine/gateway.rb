module DataMapper
  class Engine
    class ArelEngine < self

      class Gateway
        include Enumerable

        attr_reader :name
        attr_reader :header
        attr_reader :adapter
        attr_reader :relation

        def initialize(adapter, relation, name = nil, header = nil)
          @adapter  = adapter
          @relation = relation
          @header   = if relation.respond_to?(:columns)
                        relation.columns.map(&:name)
                      else
                        header
                      end

          @name = if relation.respond_to?(:name)
                    relation.name
                  else
                    name
                  end
        end

        def each(&block)
          return to_enum unless block_given?
          read.each(&block)
          self
        end

        # FIXME: break down gateway into 2 subclasses to handle this better
        def source
          if relation.kind_of?(Arel::Table)
            relation
          else
            relation.source.left
          end
        end

        def new(relation, header = @header)
          self.class.new(adapter, relation, name, header)
        end

        private

        def read
          adapter.execute(to_sql)
        end

        def to_sql
          relation.project(header.join(', ')).to_sql
        end

      end # class Gateway

    end # class ArelEngine
  end # class Engine
end # module DataMapper
