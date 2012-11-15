require 'spec_helper_integration'

unless DataMapper.engines[:postgres_arel]
  DataMapper.setup(
    :postgres_arel,
    'postgres://postgres@localhost/dm-mapper_test',
    DataMapper::Engine::ArelEngine
  )
end

describe "Inserting new objects with ARel" do
  before(:all) do
    setup_db

    class User
      include DataMapper::Model

      attribute :id,   Integer, :key => true
      attribute :name, String
      attribute :age,  Integer

      class Mapper < DataMapper::Mapper::Relation

        model         User
        relation_name :users
        repository    :postgres_arel

        map :id,   Integer, :key => true
        map :name, String,  :to  => :username
        map :age,  Integer
      end
    end
  end

  after(:all) do
    Object.send(:remove_const, :User)
  end

  it "actually works ZOMG" do
    relation = DataMapper[User].relation

    relation.insert(:username => 'Piotr', :age => 29)

    relation.first.should == { :id => '1', :username => 'Piotr', :age => '29' }
  end
end
