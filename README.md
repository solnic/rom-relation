# Ruby Object Mapper

[![Gem Version](https://badge.fury.io/rb/rom.png)][gem]
[![Build Status](https://travis-ci.org/rom-rb/rom.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/rom-rb/rom.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/rom-rb/rom.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/rom-rb/rom/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/rom
[travis]: https://travis-ci.org/rom-rb/rom
[gemnasium]: https://gemnasium.com/rom-rb/rom
[codeclimate]: https://codeclimate.com/github/rom-rb/rom
[coveralls]: https://coveralls.io/r/rom-rb/rom

The mapper supports mapping data from any data source into Ruby objects
based on mapper definitions. It uses [axiom](https://github.com/dkubb/axiom),
a relational algebra library which will give us the ability to talk to
different data sources and even performing cross-database joins.

## Establishing Connection & Defining PORO with mappers

``` ruby
# Define a PORO
class User
  attr_reader :id, :name

  def initialize(attributes)
    @id, @name = attributes.values_at(:id, :name)
  end
end

# Create DM environment
config = { :default => 'postgres://localhost/test' }
env    = Rom::Environment.coerce(config)

# Define a mapper
env.build(User, :postgres) do
  relation_name :users

  map :id,   Integer, :key => true
  map :name, String,  :to => :username
end

# Finalize the environment
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

# Create DM environment
config = { :default => 'postgres://localhost/test' }
env    = Rom::Environment.coerce(config)

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
    restrict { |r| r.product.eq('Apple') }
  end
end

# Finalize the environment
env.finalize

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
  include Rom::Model

  attribute :id,      Integer
  attribute :product, String
end

class User
  include Rom::Model

  attribute :id,     Integer
  attribute :name,   String
  attribute :age,    Integer
  attribute :orders, Array[Order]
end

# Create DM environment
config = { :default => 'postgres://localhost/test' }
env    = Rom::Environment.coerce(config)

env.build(Order, :postgres) do
  key :id
end

env.build(User, :postgres) do
  key :id

  map :name, :to => :username

  has 0..n, :orders, Order
end

# Finalize the environment
env.finalize

# ...and you're ready to go :)
env[User].include(:orders).to_a
```

## Finding Objects

Mappers come with a simple high-level query API similar to what you know from other Ruby ORMS:

```ruby
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
# Get them all
env[User].to_a

# Iterate on all users
env[User].each { |user| puts user.name }

# Restrict
env[User].restrict { |relation| relation.name.eq('John') }.to_a

# Sort by
env[User].sort_by { |r| [ r.name, r.id ] }.to_a
```

## 2.0.0.alpha Roadmap

 * Make rake ci pass
 * Add interface for insert/update/delete to relation graph
 * Add interface for preparing objects for insert/update/delete (will be used by session)
 * Extract Axiom and Arel engines into separate gems
 * Push a release? :)
