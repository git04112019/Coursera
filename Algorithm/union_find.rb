class UnionFind
    attr_reader :unionSets
    attr_reader :connections
    attr_accessor :debug

    def initialize(connections)
        @unionSets = []
        @connections = []
        @debug = false

        connections.each do |connection|
            union(connection[0], connection[1])
            @connections.push(connection)
        end
    end

    def union(p, q, findNumInSet = false)
        # if currently connected
        if(@connections.include?([p, q]) || @connections.include?([q, p]))
            return
        end

        if(findNumInSet)
            sets = findNumInSet([p, q])
        else
            sets = findSetForNum([p, q])
        end

        if (sets[p] == nil && sets[q] == nil)
            puts "neither #{p} nor #{q} are in a set" if @debug
            @unionSets.push([p, q])
            @connections.push([p, q])
        elsif (sets[p] != nil && sets[q] == nil)
            puts "#{q} is not in a set" if @debug
            sets[p].push(q)
            @connections.push([p, q])
        elsif (sets[p] == nil && sets[q] != nil)
            puts "#{p} is not in a set" if @debug
            sets[q].push(p)
            @connections.push([p, q])
        else # both of them are in a set
            unless (sets[p] == sets[q])
                puts "both #{p} and #{q} are in a set" if @debug
                @unionSets.delete(sets[p])
                @unionSets.delete(sets[q])
                @unionSets.push(sets[p] | sets[q])
            else
                puts "#{p} and #{q} are in the same set already" if @debug
            end
        end
    end

    def connected(p, q)
    end

    def find(p)

    end

    def count()

    end

    private
    def findNumInSet(arrayOfNums)
        numToSet = Hash.new
        
        arrayOfNums.each do |num|
            @unionSets.each do |set|
                if(set.include?(num))
                    numToSet[num] = set
                    break
                end
            end
        end

        return numToSet
    end

    def findSetForNum(arrayOfNums)
        arrayOfNums.uniq!
        numToSet = Hash.new

        @unionSets.each do |set|
            arrayOfNums.each do |num|
                if(set.include?(num))
                    if(numToSet[num] != nil) # if true, number is appearing in multiple sets
                        puts "UnionFind.findSetForNum found same number in multiple unionSets" if @debug
                        return
                    end
                    numToSet[num] = set
                end
            end
        end
        return numToSet
    end
end