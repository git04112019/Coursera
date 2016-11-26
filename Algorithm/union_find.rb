class UnionFind

	def initialize(connections = Test.connections)
		@union = []
		@connections = connections

		connections.each do |connection|
			union(connection[0], connection[1])
		end
	end

	def union(p, q)
		sets = findNumInSet([p, q])

		if (sets[p] == nil && sets[q] == nil)
			puts "neither #{p} nor #{q} are in a set"
			@union.push([p, q])
			# @connections.push([p, q])
		elsif (sets[p] != nil && sets[q] == nil)
			puts "#{q} is not in a set"
			sets[p].push(q)
		elsif (sets[p] == nil && sets[q] != nil)
			puts "#{p} is not in a set"
			sets[q].push(p)
		else # both of them are in a set
			unless (sets[p] == sets[q])
				puts "both #{p} and #{q} are in a set"
				@union.delete(sets[p])
				@union.delete(sets[q])
				@union.push(sets[p] | sets[q])
			else
				puts "#{p} and #{q} are in the same set already"
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