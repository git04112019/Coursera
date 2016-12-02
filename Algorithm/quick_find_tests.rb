require "./quick_find.rb"
require "test/unit"
require "benchmark"

include Benchmark

class QuickFindBenchmarkTests < Test::Unit::TestCase
    def setup
        @divider = "\n----------------------------------------------------------------"

        @iterations = 10000000
        @numObjects = 300000

        puts @divider
        puts "generating test data"
        @data = nil
        Benchmark.benchmark(CAPTION, 10, FORMAT) do |x|
            x.report("time:") { @data = TestHelper.getAllUnions(@numObjects) }
        end
    end

    def teardown
    end

    def testInitialize
        qf = nil
        assert_nil qf

        @iteraions = 100

        TestHelper.benchmark("testing initialize", @iterations) do
            qf = QuickFind.new(@numObjects)
        end
        puts @divider
    end

    def testUnionFind
        qf = QuickFind.new(@numObjects)
        assert_not_nil qf

        TestHelper.benchmark("testing union function", @iterations) do
            index = rand(@data.length - 1)
            qf.union(index, @data[index])
        end

        TestHelper.benchmark("testing connected function", @iterations) do
            qf.connected(rand(@numObjects - 1), rand(@numObjects - 1))
        end
        puts @divider
    end

    def testQuickUnionFind
        qf = QuickFind.new(@numObjects)
        assert_not_nil qf

        TestHelper.benchmark("testing quick union function", @iterations) do
            index = rand(@data.length - 1)
            qf.quickUnion(index, @data[index])
        end

        TestHelper.benchmark("testing connected after quick union", @iterations) do
            qf.quickConnected(rand(@numObjects - 1), rand(@numObjects - 1))
        end

        qf = QuickFind.new(@numObjects)

        TestHelper.benchmark("testing weighted quick union function", @iterations) do
            index = rand(@data.length - 1)
            qf.weightedQuickUnion(index, @data[index])
        end

        TestHelper.benchmark("testing connected after weighted quick union", @iterations) do
            qf.quickConnected(rand(@numObjects - 1), rand(@numObjects - 1))
        end

        puts @divider
    end
end

module TestHelper
    ##
    # => numObjects     The number of objects N, from 0 to N-1, to be held in the dataset
    # => numConnections The number of pairs of connections to be made, e.g. [1, 3] is a connection between 1 and 3
    ##
    def self.getAllUnions(numObjects)
        result = []
        for i in 0..numObjects - 1
            result[i] = rand(numObjects - 1)
        end
        return result
    end

    def self.benchmark(name, iterations, cleanup = {})
        divider = "\n----------------------------------------------------------------"

        puts divider
        puts name
        Benchmark.benchmark(CAPTION, 10, FORMAT, "avg:") do |x|
            time = x.report("aggregate:") {
                for _ in 0..iterations - 1
                    yield
                end
            }
            avg = time / iterations
            [avg]
        end

        begin
            cleanup.()
            puts "performed clean up"
        rescue
            puts "no clean up performed"
        end
    end
end