def read_commands(input)
  File.readlines(input, chomp: true)
end

def signal_strength(acc, cycle)
  acc * cycle
end

def cycle_inspector(cycle, acc, index)
  [cycle, acc, signal_strength(acc, cycle), index]
end

def execute(commands, debug: true)
  cycles = []
  cycle = 0
  acc = 1
  commands.each_with_index do |command, index|
    case command
    when /noop/
      cycle += 1
      cycles << cycle_inspector(cycle, acc, index) if debug
    when /addx (-?\d+)/
      cycle += 1
      cycles << cycle_inspector(cycle, acc, index) if debug

      cycle += 1
      cycles << cycle_inspector(cycle, acc, index) if debug
      acc += Regexp.last_match(1).to_i
    else
      raise "Unknown command #{command}"
    end
  end
  [acc, cycles]
end

def sample_cycles(cycles)
  total_sample_strength = 0
  check_at = 20
  cycles.each_with_index do |sample, _index|
    cycle, acc, signal_strength, index = sample
    next unless cycle == check_at

    total_sample_strength += signal_strength
    check_at += 40
    puts "Cycle: #{cycle}, acc: #{acc}, signal strength: #{signal_strength}"
    puts "Sampled strength at cycle #{cycle} is  #{signal_strength} total; #{total_sample_strength}"
  end
  total_sample_strength
end

cycles = execute(read_commands('input.txt'), debug: true)[1].each do |cycle, acc, signal_strength|
  # puts "Cycle: #{cycle}, acc: #{acc}, signal strength: #{signal_strength}"
end

sampled_strength = sample_cycles(cycles)

puts "Part 1: #{sampled_strength}"
