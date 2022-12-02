# read the input from the file, grouping by blank lines
input = File.read('input.txt').split("\n\n")
# split each group into an array of answers
groups = input.map { |group| group.split("\n") }
# sum the totals for each group
sums = groups.map {|group| group.map{|item| item.to_i}.sum}
# get the maximum sum
max = sums.max
puts max
