require './lib/jsonrehasher.rb'
require "test/unit"
require 'json'

class TestRehash < Test::Unit::TestCase
    @@input = '{"a.b.c.d": 1}'
    @@expected_hash = '{"a":{"b":{"c":{"d":1}}}}'

    def test_strings()
        puts "testing #{@@input}, expecting: #{@@expected_hash}"
        result_hash = JsonRehasher.new().process(@@input)
        assert_equal(result_hash, @@expected_hash)
    end
end
