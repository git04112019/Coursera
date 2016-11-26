class UnionFind
	attr_reader :union

	def initialize(connections = Test.connections)
		@union = []
		@connections = []
		@debug = false

		connections.each do |connection|
			union(connection[0], connection[1])
			@connections.push(connection)
		end
	end

	def union(p, q)
		# if currently connected
		if(@connections.include?([p, q]) || @connections.include?([q, p]))
			return
		end

		sets = findNumInSet([p, q])
		# sets = findSetForNum([p, q])

		if (sets[p] == nil && sets[q] == nil)
			puts "neither #{p} nor #{q} are in a set" if @debug
			@union.push([p, q])
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
				@union.delete(sets[p])
				@union.delete(sets[q])
				@union.push(sets[p] | sets[q])
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
		# for each num in arrayOfNums, search sets
		def findNumInSet(arrayOfNums)
			numToSet = Hash.new
			
			arrayOfNums.each do |num|
				@union.each do |set|
					if(set.include?(num))
						numToSet[num] = set
						break
					end
				end
			end

			return numToSet
		end

		# for each set, search the num in arrayOfNums
		def findSetForNum(arrayOfNums)
			numToSet = Hash.new

			return numToset
		end
end