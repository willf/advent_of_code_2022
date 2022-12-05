# First, we read all lines that have `/\[.*\]/` in them.
# removing the brackets, we get the list of crates.

def lines_with_crates(input)
  File.readlines(input).select { |line| line =~ /\[.*\]/ }
end

# next, we pad the crates with spaces, so that have the same length.
# this is necessary, because we want to align the crates in the output.

def pad_crates(crates)
  max_length = crates.map(&:length).max
  crates.map { |crate| crate.ljust(max_length) }
end

# replace double spaces with ' x' and then remove the spaces.
# this is necessary, because we want to align the crates in the output.

def replace_double_spaces_with_x_and_remove_spaces(crates)
  crates.map do |crate|
    crate.gsub('  ', ' x').gsub(' ', '').gsub(/\n/, '').gsub(/\[/, '').gsub(/\]/, '').gsub('xx', 'x')
  end
end

def transpose_crates(crates)
  crates.map(&:chars).transpose.map(&:join)
end

def read_stacks(input)
  transpose_crates(replace_double_spaces_with_x_and_remove_spaces(pad_crates(lines_with_crates(input))))
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
  stacks[to] << stacks[from].pop(count)
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

def main(_input)
  puts solve_part_1('input.txt')
  puts solve_part_2('input.txt')
end
