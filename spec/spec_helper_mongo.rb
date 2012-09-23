require 'backports'
require 'backports/basic_object'
require 'rubygems'

begin
  require 'rspec'  # try for RSpec 2
rescue LoadError
  require 'spec'   # try for RSpec 1
  RSpec = Spec::Runner
end

require 'veritas'
require 'veritas/optimizer'
require 'veritas-mongo-adapter'

require 'dm-mapper'

DataMapper.setup(:mongo, "mongo://localhost/test")

class Veritas::Adapter::Mongo::Gateway < Veritas::Relation
  def name
    @relation.name
  end
end
