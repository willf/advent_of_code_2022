def read_rucksacks(input)
  File.readlines(input).map do |line|
    # split each line in half
    line = line.strip
    line.split('').to_set
  end
end

def group_rucksacks(rucksacks)
  rucksacks.each_slice(3).to_a
end

def common_items(rucksack_group)
  rucksack_group[0] & rucksack_group[1] & rucksack_group[2]
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

rucksacks = read_rucksacks('input.txt')
rucksack_groups = group_rucksacks(rucksacks)
common_items = rucksack_groups.map { |rucksack_group| common_items(rucksack_group) }
priorities = common_items.map { |item| item_to_priority(item.first) }
puts priorities.sum
