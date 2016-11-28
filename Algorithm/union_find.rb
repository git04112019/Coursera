class UnionFind
    attr_accessor :debug
    attr_accessor :method

    attr_reader :connectedComponents
    attr_reader :connections

    def initialize(method = :eager)
        @connectedComponents = []
        @connections = []
        @method = method
        @debug = false
    end

    def loadConnections(connections, numForSet = true)
        connections.each do |connection|
            union(connection[0], connection[1], numForSet)
            @connections.push(connection)
        end
    end

    def clear()
        @connectedComponents = []
        @connections = []
    end

    def union(p, q, numForSet = true)
        # if currently connected
        if(@connections.include?([p, q]) || @connections.include?([q, p]))
            return
        end

        sets = find([p, q], numForSet)

        if (sets[p] == nil && sets[q] == nil)
            puts "neither #{p} nor #{q} are in a set" if @debug
            @connectedComponents.push([p, q])
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
                @connectedComponents.delete(sets[p])
                @connectedComponents.delete(sets[q])
                @connectedComponents.push(sets[p] | sets[q])
            else
                puts "#{p} and #{q} are in the same set already" if @debug
            end
        end
    end

    def connected(p, q)
    end

    # p could be a single digit or array
    def find(p, numForSet = true)
        arrayOfNums = nil

        if(p.kind_of?(Array))
            arrayOfNums = p
            arrayOfNums.uniq!
        else
            arrayOfNums = p.to_a
        end

        numToSet = Hash.new

        if(numForSet)
            # for each number, look through the sets
            arrayOfNums.each do |num|
                @connectedComponents.each do |set|
                    if(set.include?(num))
                        numToSet[num] = set
                        break
                    end
                end
            end
        else
            # for each set, find the number
            @connectedComponents.each do |set|
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
        end

        return numToSet
    end

    def count()

    end
end