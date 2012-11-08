begin
  require 'pathname'
  require 'yardstick'
  require 'yardstick/rake/measurement'
  require 'yardstick/rake/verify'
  require 'yaml'

  module Yardstick
    module Method

      def visibility

        # FIXME
        #
        # This is needed because yardstick hangs with
        #
        #   undefined method `visibility' for nil:NilClass
        #
        # at declarations like
        #
        #   abstract_method :foo
        #
        # when they are documented using yard tags.
        #
        # Assuming :public method visibility in such cases
        # seems to be a reasonable workaround for now, as
        # our abstract methods are all public atm.
        #
        # Not adding this workaround makes our yardstick
        # tasks unusable, leaving us with no way to track
        # doc coverage.
        #
        # When parsing the source, yard does not attach
        # a {Yard::CodeObject} to the {Yard::Docstring}
        # in case of a "method definition" like
        #
        #   abstract_method :foo
        #
        # Since this method operates in {Yard::Docstring}
        # context, there's no easy way for us to get at
        # the code object, or even at the raw "source" of
        # the method (abstract_method(:foo) in our case).

        object ? object.visibility : :public
      end
    end
  end

  config = YAML.load_file(File.expand_path('../../../config/yardstick.yml', __FILE__))

  # yardstick_measure task
  Yardstick::Rake::Measurement.new

  # verify_measurements task
  Yardstick::Rake::Verify.new do |verify|
    verify.threshold = config.fetch('threshold')
  end
rescue LoadError
  %w[ yardstick_measure verify_measurements ].each do |name|
    task name.to_s do
      abort "Yardstick is not available. In order to run #{name}, you must: gem install yardstick"
    end
  end
end
