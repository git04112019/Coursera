require "./union_find.rb"
require "./test_helpers.rb"
require "test/unit"
require "benchmark"

include Benchmark

class UFTest < Test::Unit::TestCase
    def setup
        @testData = []

        input = [[4, 3],[3, 8],[6, 5],[9, 4],[2, 1],[8, 9],[5, 0],[7, 2],[6, 1],[1, 0],[6, 7]]
        output = [[4, 3, 8, 9], [6, 5, 0, 2, 1, 7]]

        @testData.push [input, output]

        @uf = UnionFind.new
        @uf.loadConnections @testData[0][0]
        @uf.debug = true
    end

    def teardown
    end

    def testHasCorrectConnectedComponents
        assert(@uf.connectedComponents == @testData[0][1])
    end

    def testFind
        puts
        puts "find benchmark"
        Benchmark.bm do |x|
            x.report { @uf.union(9, 7)}
        end
        assert(@uf.connectedComponents == [[4, 3, 8, 9, 6, 5, 0, 2, 1, 7]])
    end

    # answer: there is no difference...
    def testLargeNumOfConnections
        data = nil
        uf = nil

        iterations = 10
        numObjects = 200
        numConnections = 1000

        divider = "-------------------------------------------------------"

        puts "generate random data"
        # benchmark(CAPTION, label width, FORMAT)
        Benchmark.benchmark(CAPTION, 8, FORMAT) do |x|
            x.report("data:") { data = TestHelper.generateRandomData(numObjects, numConnections) }
            x.report("init:") { uf = UnionFind.new }
        end

        puts divider
        puts "for each number, look through the sets"
        Benchmark.benchmark(CAPTION, 8, FORMAT, ">total:", ">avg:") do |x|
            times = []
            for i in 0..iterations
                times.push x.report("loadN4S:") { uf.loadConnections data }
                uf.clear
            end
            total = times.reduce(:+)
            avg = total / times.length
            [divider, total, avg]
        end

        puts divider
        puts "for each set, look through the numbers"
        Benchmark.benchmark(CAPTION, 8, FORMAT, ">total:", ">avg:") do |x|
            times = []
            for i in 0..iterations
                times.push x.report("loadS4N:") { uf.loadConnections(data, false) }
                uf.clear
            end
            total = times.reduce(:+)
            avg = total / times.length
            [total, avg]
        end

        puts divider

        assert_not_nil data
        assert_not_nil uf
    end
end

module TestHelper
    def self.generateRandomData(numObjects, numConnections)
        counter = 0
        result = []
        while counter < numConnections do
            data = [rand(numObjects), rand(numObjects)]
            unless(result.include?(data) || result.include?([data[1], data[0]]))
                result.push data
            end
            counter += 1
        end
        return result
    end
end