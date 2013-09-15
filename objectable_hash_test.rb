require "test/unit"
require "./objectable_hash.rb"

class ObjectableHashTest < Test::Unit::TestCase
  def setup
    @objectable_hash = ObjectableHash.new({a: {b: "foo", c: "bar"}})
  end

  def test_method_missing
    assert_equal @objectable_hash.a.b, "foo"
    assert_equal @objectable_hash.a.c, "bar"
    assert_equal @objectable_hash.a, ObjectableHash.new({b: "foo", c: "bar"})
  end

  def test_to_s
    assert_equal @objectable_hash.a.to_s, {b: "foo", c: "bar"}.to_s
  end

  def test_delegate_method
    assert_equal @objectable_hash[:a], {b: "foo", c: "bar"}
    assert_equal @objectable_hash[:a][:b], "foo"
    assert_equal @objectable_hash[:a][:c], "bar"
  end
end
