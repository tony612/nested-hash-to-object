Given a hash `h = {:a => {:b => {:c => "foo"}}, :d => {:e => "bar"}}`, how can you get `p h.a.b.c # => "foo"` and `p h.d.e # => "bar"`?

There is a [gem](https://github.com/aetherknight/recursive-open-struct) which can implement this, it's pretty good.

Then I make use of the magical `method_missing` in ruby to implement it. It's very simple.

## Usage

```
$ irb
> require './objectable_hash'
> h = {a: {b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]}}
> o_h = ObjectableHash.new(h)
> p o_h.a.b         # => "foo"
> p o_h.a.c         # => 10
> p o_h.a.d         # => [{e: "bar"}, {f: 20}, "baz"]
> p o_h.a.d[0]      # => {e: "bar"}
> p o_h.a.d[0].e    # => "bar"
> p o_h.a.d[1]      # => {f: 20}
> p o_h.a.d[1].f    # => 20
> p o_h.a.d[2]      # => "baz"
```

In fact `o_h.a`, `o_h.a.d` and any other Hash or Array are objects of ObjectableHash, so you can get the hash or array value via `o_h.a.val` or `o_h.a.d.val`.

## TODO

* Pack to a gem
