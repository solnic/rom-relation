*The Mapper for DataMapper 2.0 (code spike)*

This is a code spike to implement a prototype of a mapper for [Veritas](https://github.com/dkubb/veritas) which can work with PORO or [Virtus](https://github.com/solnic/virtus) objects.

See spec/integration for examples of what already works.

More information coming soon...

**Sample code**

Here's an idea of how a mapper API could look like:

``` ruby
  class User
    attr_reader :id, :name

    def initialize(attributes)
      @id, @name = attributes.values_at(:id, :name)
    end

    class Mapper < DataMapper::VeritasMapper
      map :id, :type => Integer
      map :name, :to => :username, :type => String

      model User
      name 'users'
    end
  end

  # find all users
  User::Mapper.find

  # find users with name 'John'
  User::Mapper.find(:name => 'John')
```
