# Coursera implementation
# eager approach
class QuickFind
    attr_reader :ids

    # @ids
    # index - N
    # value - value/root

    # N array access
    def initialize(n)
        @ids = Array.new(n)
        @size = {}

        for i in 0..@ids.length - 1
            @ids[i] = i
            @size[i] = 1
        end
    end

    ################################################
    # => Quick Find
    ################################################

    # 2 array accesses
    # cost: 1
    def connected(p, q)
        return @ids[p] == @ids[q]
    end

    # 2N + 2 array access
    # quadratic time, too slow
    # cost: N
    def union(p, q)
        pid = @ids[p]
        qid = @ids[q]
        for i in 0..@ids.length - 1
            ids[i] = qid if ids[i] == pid
        end
    end

    ################################################
    # => Quick Union
    ################################################

    # cost: N - dependent on the root() operation
    def quickConnected(p, q)
        return root(p) == root(q)
    end

    # cost: N
    # tree needs to be weighted - smaller trees go under large trees to reduce depth
    # large tree going udner small is guaranteed to add one depth to maximum depth
    def quickUnion(p, q)
        pRoot = root(p)
        qRoot = root(q)
        @ids[pRoot] = qRoot
    end

    # depth of any tree is at most log2 N
    def weightedQuickUnion(p, q)
        pRoot = root(p)
        qRoot = root(q)
        return if pRoot == qRoot
        # smaller tree go under bigger tree
        if @size[pRoot] < @size[qRoot]
            @ids[pRoot] = qRoot
            @size[qRoot] += @size[pRoot]
        else
            @ids[qRoot] = pRoot
            @size[pRoot] += @size[qRoot]
        end
    end

    private
        def root(id)
            while(@ids[id] != id)
                @ids[id] = @ids[@ids[id]] # compresses the tree
                id = @ids[id]
            end
            return id
        end
end