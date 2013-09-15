Given a hash `h = {:a => {:b => {:c => "foo"}}, :d => {:e => "bar"}}`, how can you get `p h.a.b.c # => "foo"` and `p h.d.e # => "bar"`?

There is a [gem](https://github.com/aetherknight/recursive-open-struct) which can implement this, it's pretty good.

Then I make use of the magical `method_missing` in ruby to implement it. It's very simple.

## Usage

```
$ irb
> require './objectable_hash'
> h = {:a => {:b => {:c => "foo"}}, :d => {:e => "bar"}}
> o_h = ObjectableHash.new(h)
> p o_h.a.b.c # => "foo"
> p o_h.a.b   # => {:c=>"foo"}
> p o_h.d.e   # => "bar"
```

In fact `o_h.a.b` is an object of ObjectableHash, so you can get the hash value via `o_h.a.b.val`.

And I have added `Forwardable` module to it to let it work as an hash:

```
> p h[:a][:b][:c] # => "foo"
```

## TODO

* Add test
* Add the support for Array inside the hash
* Add support for more methods of hash
