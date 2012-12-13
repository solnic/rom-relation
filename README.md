# Mapper

[![Build Status](https://secure.travis-ci.org/datamapper/dm-mapper.png?branch=master)](http://travis-ci.org/datamapper/dm-mapper)
[![Dependency Status](https://gemnasium.com/datamapper/dm-mapper.png)](https://gemnasium.com/datamapper/dm-mapper)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/datamapper/dm-mapper)

The mapper supports mapping data from any data source into Ruby objects based on
mapper definitions. It uses engines that implement common interface for CRUD
operations.

## Engines

In the most simple case a bare-bone mapper engine needs to provide a relation
object that has a name and implements `#each` which yields objects that respond
to `#[]`. That's the minimum contract.

Here's an example of an in-memory engine which uses an `Array` subclass for the
relation object and `Hash` as the class for the yielded objects.

Since `Array` implements `#each` and `Hash` implements `#[]` we've got all we need:

``` ruby
class MemoryEngine < DataMapper::Engine

  class Relation < Array
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  def base_relation(name, header = nil)
    Relation.new(name)
  end
end

# create DM env object
env = DataMapper::Environment.new

env.engines[:memory] = MemoryEngine.new

User = Class.new(OpenStruct)

env.build(User, :memory) do
  relation_name :users

  map :name, String,  :to => :UserName
  map :age,  Integer, :to => :UserAge
end

env.finalize

mapper = env[User]

mapper.relations[:users] << { :UserName => 'Piotr', :UserAge => 29 }

mapper.to_a
# [#<User name="Piotr", age=29>]
```

DataMapper 2 will come with support for [Veritas](https://github.com/dkubb/veritas)
and [ARel](https://github.com/rails/arel) engines.

Veritas is a polyglot relational algebra library which will give us ability to
talk to different data sources and even performing cross-database joins whereas
ARel will only give you support for RDBMS.

## Establishing Connection & Defining PORO with mappers

``` ruby
# Create DM env
env = DataMapper::Environment.new

# Setup db connection
DataMapper.setup(:postgres, "postgres://localhost/test", env)

# Define a PORO
class User
  attr_reader :id, :name

  def initialize(attributes)
    @id, @name = attributes.values_at(:id, :name)
  end
end

# Define a mapper
env.build(User, :postgres) do
  relation_name :users

  map :id,   Integer, :key => true
  map :name, String,  :to => :username
end

# Finalize setup
env.finalize
```

## Defining relationships

``` ruby
class Order
  attr_reader :id, :product

  def initialize(attributes)
    @id, @product = attributes.values_at(:id, :product)
  end
end

class User
  attr_reader :id, :name, :age, :orders, :apple_orders

  def initialize(attributes)
    @id, @name, @age, @orders, @apple_orders = attributes.values_at(
      :id, :name, :age, :orders, :apple_orders
    )
  end
end

env.build(Order, :postgres) do
  relation_name :orders

  map :id,      Integer, :key => true
  map :user_id, Integer
  map :product, String
end

env.build(User, :postgres) do
  relation_name :users

  map :id,     Integer, :key => true
  map :name,   String,  :to => :username
  map :age,    Integer

  has 0..n, :orders, Order

  has 0..n, :apple_orders, Order do
    restrict { |r| r.order_product.eq('Apple') }
  end
end

# Find all users and eager-load their orders
env[User].include(:orders).to_a

# Find all users and eager-load restricted apple_orders
env[User].include(:apple_orders).to_a
```

## Model Extension and Generating Mappers

To simplify the process of defining mappers you can extend your PORO with a small
extension (which uses `Virtus` under the hood) and specify only special mapping
cases:

``` ruby
class Order
  include DataMapper::Model

  attribute :id,      Integer
  attribute :product, String
end

class User
  include DataMapper::Model

  attribute :id,     Integer
  attribute :name,   String
  attribute :age,    Integer
  attribute :orders, Array[Order]
end

env = DataMapper::Environment.new

env.build(Order, :postgres) do
  key :id
end

env.build(User, :postgres) do
  key :id

  map :name, :to => :username

  has 0..n, :orders, Order
end

env.finalize

# ...and you're ready to go :)
env[User].include(:orders).to_a
```

## Finding Objects

Mappers come with a simple high-level query API similar to what you know from other Ruby ORMS:

```ruby
env = DataMapper::Environment.new

# Find all users matching criteria
env[User].find(:age => 21)

# Find and sort users
env[User].find(:age => 21).order(:name, :age)

# Get one object matching criteria
env[User].one(:name => 'Piotr')
```

## Low-level API using underlying relations

You can interact with the underlying relations if you want. A more "user friendly"
API will be built on top of that.

Mappers are enumerables so it should feel natural when working with them.

```ruby
# Grab the user mapper instance and have fun
user_mapper = DataMapper[User]

# Get them all
user_mapper.to_a

# Iterate on all users
user_mapper.each { |user| puts user.name }

# Restrict
user_mapper.restrict { |relation| relation.name.eq('John') }.to_a

# Sort by
user_mapper.sort_by { |r| [ r.name, r.id ] }.to_a
```

## 2.0.0.alpha Roadmap

 * Make rake ci pass
 * Add interface for insert/update/delete to relation graph
 * Add interface for preparing objects for insert/update/delete (will be used by session)
 * Extract Veritas and Arel engines into separate gems
 * Push a release? :)
