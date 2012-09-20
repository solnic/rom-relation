# The Mapper for DataMapper 2

[![Build Status](https://secure.travis-ci.org/solnic/dm-mapper.png)](http://travis-ci.org/solnic/dm-mapper)

The mapper for DataMapper 2 is a thin wrapper around [Veritas](https://github.com/dkubb/veritas)
relations. It gives you the power of mapping data into PORO.

It currently works with PostgreSQL - more databases will be added soon.

## Roadmap

 * Mapping relationships (prototype is ready)
 * MongoDB support
 * Support for Veritas functions
 * Extend existing Query API with more common features
 * Integration with [Virtus](https://github.com/solnic/virtus)
 * Automatic generation of mappers based on model definitions

## Establishing Connection & Defining PORO with mappers

``` ruby
# Setup db connection
DataMapper.setup(:postgres, "postgres://localhost/test")

# Define a PORO
class User
  attr_reader :id, :name

  def initialize(attributes)
    @id, @name = attributes.values_at(:id, :name)
  end
end

# Define a mapper
class Mapper < DataMapper::VeritasMapper

  model         User
  relation_name :users
  repository    :postgres

  map :id,   Integer, :key => true
  map :name, String,  :to => :username
end

# Finalize setup
DataMapper.finalize
```

## Finding Objects

Mappers come with a simple high-level query API similar to what you know from other Ruby ORMS:

```ruby
# Find all users matching criteria
DataMapper[User].find(:age => 21)

# Find and sort users
DataMapper[User].find(:age => 21).order(:name, :age)

# Get one object matching criteria
DataMapper[User].one(:name => 'Piotr')
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
