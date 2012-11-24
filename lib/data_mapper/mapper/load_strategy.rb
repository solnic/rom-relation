module DataMapper
  class Mapper

    class LoadStrategy
      def initialize(mapper)
        @mapper = mapper
      end

      class Default < self
        def call(model, tuple)
          model.new(@mapper.attributes.load(tuple))
        end
      end

      class WithProc < Default
        def initialize(*args, &block)
          super(*args)
          @block = block
        end

        def call(model, tuple)
          super
          @block.call(tuple)
        end
      end

    end # class LoadStrategy

  end # class Mapper
end # module DataMapper
