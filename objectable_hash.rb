require 'forwardable'
class ObjectableHash
  extend Forwardable
  def_delegators :@h, :[]

  def initialize( h )
    @h = h
  end

  def method_missing(m, *args, &block)
    (v = @h.fetch( m )).is_a?(Hash) ? ObjectableHash.new(v) : v
  end

  def to_s
    @h.to_s
  end

  def val
    @h
  end

  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    self.val == other.val
  end
end
