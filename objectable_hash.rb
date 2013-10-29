require 'forwardable'
class ObjectableHash
  extend Forwardable
  def_delegators :@obj, :[]

  def initialize( obj )
    @obj = obj
  end

  def method_missing(m, *args, &block)
    if (v = @obj.fetch(m)).is_a?(Hash) or v.is_a?(Array)
      ObjectableHash.new(v)
    else
      v
    end
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
