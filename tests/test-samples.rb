require './lib/jsonrehasher.rb'
require "test/unit"
require 'json'

class TestRehash < Test::Unit::TestCase
    @@dir = "./sample_input"
    @@input_type = ".json"
    @@result_ext = "result"
    @@files = [
        "input",
        "input2",
        "input3",
        "input4",
        "input_full"
    ]

    def getFile(name)
        return "#{@@dir}/#{name}#{@@input_type}"
    end

    def getExpected(name)
        return "#{@@dir}/#{name}.#{@@result_ext}#{@@input_type}"
    end

    def test_samples()
        @@files.each { |i|
            puts "testing #{getFile(i)} -> #{getExpected(i)}"
            result_hash = JsonRehasher.new().processFile(getFile(i))
            expected_file = File.read(getExpected(i))
            assert_equal(result_hash, expected_file)
        }
    end
end
