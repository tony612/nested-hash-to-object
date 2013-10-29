require 'forwardable'
class ObjectableHash
  extend Forwardable
  def_delegators :@obj, :[]

  def initialize( obj )
    @obj = obj
  end

  def method_missing(m, *args, &block)
    (v = @h.fetch( m )).is_a?(Hash) ? ObjectableHash.new(v) : v
  end

  def to_s
    @obj.to_s
  end

  def val
    @obj
  end

  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    self.val == other.val
  end
end
