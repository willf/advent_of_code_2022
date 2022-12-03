def read_rucksacks(input)
  File.readlines(input).map do |line|
    # split each line in half
    line = line.strip
    chars = line.chars
    left, right = chars.take(chars.size / 2), chars.drop(chars.size / 2)
    [left, right].map { |side| side.to_set }
  end
end

require 'set'

def group_rucksacks(rucksacks)
  rucksacks.each_slice(3).to_a
end

def all_items(rucksack)
  rucksack[0] + rucksack[1]
end

def items_common_to_groups(rucksack_group)
  a, b, c = rucksack_group.map{ |rucksack| all_items(rucksack) }
  a & b & c
end

def lc_item_to_priority(letter)
  (letter.ord - 'a'.ord) + 1
end

def uc_item_to_priority(letter)
  (letter.ord - 'A'.ord) + 26 + 1
end

def item_to_priority(letter)
  if letter == letter.downcase
    lc_item_to_priority(letter)
  else
    uc_item_to_priority(letter)
  end
end

def main
  rucksacks = read_rucksacks('input.txt')
  rucksack_groups = group_rucksacks(rucksacks)
  common = rucksack_groups.map { |rucksack_group| items_common_to_groups(rucksack_group) }
  priorities = common.map { |item| item_to_priority(item.first) }
  priorities.sum
end

puts main
