require 'set'

# Given a string, and a length, return an enumeration of items than contain:
# an index, which starts at length and increases by 1 each time and terminates at string.size
# a substring, which is the string from the index to index-length
# For example
#  enumerate_parts("abcdef", 3) => [3, "abc"], [4, "bcd"], [5, "cde"], [6, "def"]]

def enumerate_parts(string, length)
  (length..string.size).map { |i| [i, string[i-length...i]] }
end

# Find the first part in which all of the chars are unique; return then index and substring
def find_unique_part(string, length)
  enumerate_parts(string, length).find { |i, part| part.chars.uniq.size == part.size }
end



def solve_part_1(input)
  File.open(input).each_line do |line|
    puts find_unique_part(line.chomp, 4)[0]
  end
  true
end

def solve_part_2(input)
  File.open(input).each_line do |line|
    puts find_unique_part(line.chomp, 14)[0]
  end
end


solve_part_1('input.txt')
solve_part_2('input.txt')

# The following introduces to me a new method, each_cons, which is like each_slice, but returns
# overlapping slices.  This is a much more elegant solution than the above.

def start_cons(n, input)
  input.each_cons(n).each_with_index{|g, i| return i + n if Set.new(g).size == n}
end

puts start_cons(4, File.read("input.txt").chomp.chars)
puts start_cons(14, File.read("input.txt").chomp.chars)
