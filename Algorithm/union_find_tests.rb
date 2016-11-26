require "./union_find.rb"
require "test/unit"
require "benchmark"

class UFTest < Test::Unit::TestCase
    def setup
        @testData = []

        input = [[4, 3],[3, 8],[6, 5],[9, 4],[2, 1],[8, 9],[5, 0],[7, 2],[6, 1],[1, 0],[6, 7]]
        output = [[4, 3, 8, 9], [6, 5, 0, 2, 1, 7]]

        @testData.push [input, output]

        @uf = UnionFind.new(@testData[0][0])
        @uf.debug = true
    end

    def teardown
    end

    def testHasCorrectDefaultSet
        assert(@uf.unionSets == @testData[0][1])
    end

    def testFindNumInSet
        puts
        puts "findNumInSet benchmark"
        Benchmark.bm do |x|
            x.report { @uf.union(9, 7, true) }
        end
        assert(@uf.unionSets == [[4, 3, 8, 9, 6, 5, 0, 2, 1, 7]])
    end

    def testFindSetForNum
        puts
        puts "findSetInNum benchmark"
        Benchmark.bm do |x|
            x.report { @uf.union(9, 7)}
        end
        assert(@uf.unionSets == [[4, 3, 8, 9, 6, 5, 0, 2, 1, 7]])
    end
end