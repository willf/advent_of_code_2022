require './allen_algebra.rb'

class Range
  include AllenAlgebra
end


def convert_to_range(range)
  Range.new(*range.split("-").map(&:to_i))
end

def convert_to_ranges(line)
  line.split(",").map { |range| convert_to_range(range) }
end

def includes_range(range1, range2)
  range1.first <= range2.first && range2.last <= range1.last
end

def read_input(filename)
  File.readlines(filename).map{ |line| convert_to_ranges(line) }
end

def count_include_ranges(range_pairs)
  range_pairs.count { |range1, range2| range1.commpletely_includes?(range2) || range2.commpletely_includes?(range1) }
end

def solve_part_1(filename)
  pairs = read_input(filename)
  pairs.count { |range1, range2| range1.commpletely_includes?(range2) || range2.commpletely_includes?(range1) }
end

def solve_part_2(filename)
  pairs = read_input(filename)
  pairs.count { |range1, range2| range1.overlaps_at_all?(range2) }
end

puts solve_part_1("input.txt")
puts solve_part_2("input.txt")
