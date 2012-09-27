require 'spec_helper_mongo'

describe "Reading from MongoDB" do
  before do
    connection = Mongo::Connection.new
    db         = connection.db('test')
    users      = db.collection("users")
    users.remove

    users.insert :firstname => 'John'
    users.insert :firstname => 'Jane'

    class User
      attr_reader :id, :name

      def initialize(attributes)
        @id, @name = attributes.values_at(:id, :name)
      end

      class Mapper < DataMapper::Mapper::Relation::Base

        model          User
        relation_name :users
        repository    :mongo

        map :id,   String, :to => :_id
        map :name, String, :to => :firstname
      end
    end

    DataMapper.finalize
  end

  after do
    User.send(:remove_const, :Mapper)
    Object.send(:remove_const, :User)
  end

  it "loads all user objects" do
    users = DataMapper[User].find_all.to_a

    users.should have(2).items

    user1, user2 = users

    user1.id.should_not be_nil
    user1.name.should eql("John")

    user2.id.should_not be_nil
    user2.name.should eql("Jane")
  end

  it "finds a specific user" do
    user = DataMapper[User].one(:name => 'Jane')

    user.id.should_not be_nil
    user.name.should eql("Jane")
  end
end
