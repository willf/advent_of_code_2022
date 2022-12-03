def read_rucksacks(input)
  File.readlines(input).map do |line|
    # split each line in half
    line = line.strip
    left, right = line[0..line.size / 2 -1], line[line.size / 2 ..-1]
    [left, right].map { |side| side.split('').to_set }
  end
end

def common_items(rucksacks)
  rucksacks.map { |rucksack| rucksack[0] & rucksack[1] }
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
common_items = common_items(rucksacks)
priorities = common_items.map { |item| item_to_priority(item.first) }
puts priorities.sum
