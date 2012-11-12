module DataMapper
  class Engine
    class ArelEngine < self

      class Gateway
        include Enumerable

        attr_reader :name
        attr_reader :header
        attr_reader :engine
        attr_reader :relation

        def initialize(engine, relation, name = nil, header = nil)
          @engine   = engine
          @relation = relation
          @header   = relation.respond_to?(:columns) ? relation.columns : header
          @name     = relation.respond_to?(:name) ? relation.name : name
        end

        def each(&block)
          return to_enum unless block_given?
          read.each(&block)
          self
        end

        def new(relation, header = @header)
          self.class.new(engine, relation, name, header)
        end

        private

        def read
          engine.adapter.execute(to_sql)
        end

        def to_sql
          relation.project(header.map(&:name).join(', ')).to_sql
        end

      end # class Gateway

    end # class ArelEngine
  end # class Engine
end # module DataMapper
