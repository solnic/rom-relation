module DataMapper
  class Mapper

    module SessionInterface

      class Dumper < Struct.new(:object, :attributes)
        def identity
          @identity ||= attributes.key.map { |key| object.send(key.name) }
        end

        def tuple
          attributes.each_with_object({}) do |attribute, attributes|
            attributes[attribute.field] = object.send(attribute.name)
          end
        end
      end

      class Loader < Struct.new(:model, :tuple, :attributes)
        attr_reader :object

        def initialize(*args)
          super
          @object = model.new(attributes.load(tuple))
        end

        def identity
          @identity ||= attributes.key.map { |key| tuple[key.field] }
        end
      end

      # @api public
      def loader(tuple)
        Loader.new(model, tuple, attributes)
      end

      # @api public
      def dumper(object)
        Dumper.new(object, attributes)
      end

      # @api private
      def load_model(tuple)
        model.new(attributes.load(tuple))
      end

    end # module SessionInterface

  end # class Mapper
end # module DataMapper
