require "minitest/autorun"
require "./objectable_hash.rb"

describe ObjectableHash do
  before do
    @objectable_hash = ObjectableHash.new({a: {b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]}})
  end

  describe "#method_missing" do
    describe "when the last is hash" do
      it "should return the ObjectableHash object using the hash" do
        @objectable_hash.a.must_equal ObjectableHash.new({b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]})
      end
    end

    describe "when a attr is an Array" do
      it "should return the ObjectableHash object using the array" do
        @objectable_hash.a.d.must_equal ObjectableHash.new([{e: "bar"}, {f: 20}, "baz"])
      end
    end

    describe "when the last is string or number" do
      it "should return the itself" do
        @objectable_hash.a.b.must_equal "foo"
        @objectable_hash.a.c.must_equal 10
      end
    end
  end

  describe "#val" do
    describe "when the object is a Objectable hash" do
      it "should return the real object" do
        @objectable_hash.a.val.must_equal({b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]})
        @objectable_hash.a.d.val.must_equal([{e: "bar"}, {f: 20}, "baz"])
      end
    end
  end

  describe "#==" do
    describe "when other is itself" do
      it "return true" do
        @objectable_hash.must_be :==, @objectable_hash
      end
    end

    describe "when other is not an instance of the Class" do
      it "return false" do
        @objectable_hash.wont_be :==, "foo"
      end
    end

    describe "when other is an instance of the Class" do
      it "return true when the #val is equal" do
        @objectable_hash.must_be :==, ObjectableHash.new({a: {b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]}})
      end

      it "return false when the #val is not equal" do
        @objectable_hash.wont_be :==, ObjectableHash.new({a: {b: "bar", c: 10}})
      end
    end
  end

  describe "#to_s" do
    it "return the inner hash object's value" do
      @objectable_hash.to_s.must_equal("{:a=>{:b=>\"foo\", :c=>10, :d=>[{:e=>\"bar\"}, {:f=>20}, \"baz\"]}}")
      @objectable_hash.a.to_s.must_equal("{:b=>\"foo\", :c=>10, :d=>[{:e=>\"bar\"}, {:f=>20}, \"baz\"]}")
      @objectable_hash.a.d.to_s.must_equal("[{:e=>\"bar\"}, {:f=>20}, \"baz\"]")
    end
  end

  describe "#[]" do
    describe "when the the inner obj is a hash" do
      it "return the ObjectableHash for the object" do
        @objectable_hash[:a].must_equal ObjectableHash.new({b: "foo", c: 10, d: [{e: "bar"}, {f: 20}, "baz"]})
      end
    end

    describe "when the inner obj is a array" do
      it "returns the ObjectableHash for the object" do
        @objectable_hash.a.d[0].must_equal ObjectableHash.new({e: "bar"})
        @objectable_hash.a.d[1].must_equal ObjectableHash.new({f: 20})
        @objectable_hash.a.d[2].must_equal "baz"
      end
    end

    describe "when the inner obj is neither a array nor a hash" do
      it "returns the real obj" do
        @objectable_hash[:a][:b].must_equal "foo"
      end
    end
  end
end
