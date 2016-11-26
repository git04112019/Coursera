require "test/unit"
require "./union_find.rb"

class UFTest < Test::Unit::TestCase
    def setup
        @uf = UnionFind.new
    end

    def teardown
    end

    def testHasCorrectSet
        
    end
end

module Test
    def self.connections
        return [
                [4, 3],
                [3, 8],
                [6, 5],
                [9, 4],
                [2, 1],
                [8, 9],
                [5, 0],
                [7, 2],
                [6, 1],
                [1, 0],
                [6, 7]]
    end

    def self.numbers
        return (0..9).to_a
    end
end