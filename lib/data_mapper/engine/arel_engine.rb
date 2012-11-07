require 'active_record' # lol

module DataMapper
  class Engine

    # Engine for Arel
    #
    class ArelEngine < self
      class GatewayRelation
        include Enumerable

        attr_reader :name
        attr_reader :adapter
        attr_reader :relation
        attr_reader :header

        def initialize(adapter, relation, name = relation.name, header = relation.columns)
          @name     = name
          @header   = header
          @adapter  = adapter
          @relation = relation
        end

        def each(&block)
          return to_enum unless block_given?
          read.each(&block)
          self
        end

        def join(other)
          raise NotImplementedError
        end

        private

        def read
          @adapter.execute(to_sql)
        end

        def to_sql
          @relation.project(*@header.map(&:name)).to_sql
        end
      end

      attr_reader :adapter
      attr_reader :arel_engines

      def initialize(uri)
        super

        # FIXME: parse uri here
        ActiveRecord::Base.establish_connection(
          :database => 'dm-mapper_test',
          :username => 'postgres',
          :adapter  => 'postgresql'
        )

        @adapter = ActiveRecord::Base.connection

        @arel_engines = {}
      end

      # @api private
      def relation_node_class
        RelationRegistry::RelationNode::ArelRelation
      end

      # @api private
      def base_relation(name, header)
        Arel::Table.new(name, arel_engine_for(name, header))
      end

      # @api private
      def gateway_relation(relation)
        GatewayRelation.new(adapter, relation)
      end

      private

      # @api private
      def arel_engine_for(name, header)
        # TODO: this is temporary. we need to find out how to create a thin arel engine
        arel_engines.fetch(name) {
          Class.new(ActiveRecord::Base) { self.table_name = name }
        }
      end

    end # class VeritasEngine
  end # class Engine
end # module DataMapper
