# First, we read all lines that have `/\[.*\]/` in them.
def lines_with_crates(input)
  File.readlines(input).select { |line| line =~ /\[.*\]/ }
end

# This was literally the hardest part of the puzzle for me !! :)
# We will get rid of the extra spaces and brackets
# and convert 'blank' crates to `x`
# The secret is that the crates are 4 characters wide
# and the second character is the one we want
def convert_line(line)
  line.chomp.chars.each_slice(4).map{|x| x[1]}.join.gsub(/ /, 'x')
end

# We will convert all lines to the same length by adding `x` to the end
def convert_lines(lines)
  converted = lines.map { |line| convert_line(line) }
  max_length = converted.map(&:length).max
  converted.map { |line| line.ljust(max_length, 'x') }
end

# And traspose the lines to get the stacks
def transpose_crates(crates)
  crates.map(&:chars).transpose.map(&:join)
end

def read_stacks(input)
  transpose_crates(convert_lines(lines_with_crates(input)))
end

def create_stack_from_text(text)
  stack = []
  text.reverse.gsub(/x/, '').each_char do |char|
    stack << char
  end.chars
end

def stacks(input)
  read_stacks(input).map { |stack| create_stack_from_text(stack) }
end

# A Move is a triple (count, from, to) where count is the number of crates
def read_move_input(input)
  File.readlines(input).select { |line| line =~ /move/ }.map { |line| line.scan(/\d+/).map { |d| d.to_i } }
end

def adjust_stack_numbers(moves)
  moves.map do |move|
    move[1] -= 1
    move[2] -= 1
    move
  end
end

def moves(input)
  adjust_stack_numbers(read_move_input(input))
end

def make_move(move, stacks)
  count, from, to = move
  count.times do
    stacks[to] << stacks[from].pop
  end
end

def make_move_2(move, stacks)
  count, from, to = move
  # take the top count elements from the from stack and push them to the to stack
  x = []
  count.times do
    x << stacks[from].pop
  end
  stacks[to] += x.reverse
end

def move_all_9000(stacks, moves)
  moves.each do |move|
    make_move(move, stacks)
  end
  stacks
end

def move_all_9001(stacks, moves)
  moves.each do |move|
    make_move_2(move, stacks)
  end
  stacks
end

def solve_part_1(input)
  s = stacks(input)
  m = moves(input)
  move_all_9000(s, m)
  s.map { |stack| stack.last }.join
end

def solve_part_2(input)
  s = stacks(input)
  m = moves(input)
  move_all_9001(s, m)
  s.map { |stack| stack.last }.join
end

def main()
  puts solve_part_1('input.txt')
  puts solve_part_2('input.txt')
end

main
