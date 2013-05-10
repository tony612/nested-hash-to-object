require 'forwardable'
class ObjectableHash
  extend Forwardable
  def_delegators :@h, :[]
  def initialize( h )
    @h = h
  end

  def method_missing(m, *args, &block)
    (v = @h.fetch( m )).is_a?(Hash) ? Foo.new(v) : v
  end

  def to_s
    @h.to_s
  end

  def val
    @h
  end
end
