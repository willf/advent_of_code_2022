# a 'directory' has a name and a list of files and directories
# a 'file' has a name and a size

class SimDirectory
  attr_accessor :name, :files, :parent
  def initialize(name)
    @name = name
    @files = []
    @parent = nil
  end

  def size
    @files.inject(0) { |sum, file| sum + file.size }
  end
end

class SimFile
  attr_accessor :name, :size
  def initialize(name, size)
    @name = name
    @size = size
  end
end

$root = SimDirectory.new("/")
$current = $root
$directories = []

inputs = File.read('input.txt').split("\n")
puts "Starting with $current directory is #{$current.name}"
inputs.each do |input|
  if input =~ /\$ cd (.*)/
    name = $1
    if name == ".."
      $current = $current.parent unless $current == $root
    elsif name == "/"
      $current = $root
    else
      dir = $current.files.find { |file| file.name == name }
      if dir.nil?
        dir = SimDirectory.new(name)
        dir.parent = $current
        $current.files << dir

        $directories << dir unless $directories.include?(dir) || dir == $root
        puts "Added new directory #{name}"
      end
      $current = dir
    end
    puts "Set current directory to #{$current.name}"
  elsif input =~ /\$ ls/
    # do nothing :)
  elsif input =~ /dir (.*)/
    name = $1
    found = $current.files.find { |file| file.name == name }
    if found.nil?
      newDirectory = SimDirectory.new(name)
      newDirectory.parent = $current
      $current.files << newDirectory
      $directories << newDirectory
      puts "Added new directory #{name}"
    else
      puts "Directory #{name} already exists"
    end
  elsif input =~ /(\d+) (.*)/
    name = $2
    size = $1.to_i
    found = $current.files.find { |file| file.name == name }
    if found.nil?
      newFile = SimFile.new(name, size)
      $current.files << newFile
      puts "Added new file #{name} with size #{size} to #{$current.name}"
    else
      puts "File #{name} already exists"
    end
else
  puts "Unrecognized input: #{input}"
end
end

#puts $directories.map { |directory| [directory.name, directory.size, directory.files.size] }.inspect
#puts $directories.map{ |directory| directory.size }.sum
#puts $directories.map{ |directory| directory.size }.filter{ |size| size <= 1000000 }.sum

# Find all of the directories with a total size of at most 100000. What is the sum of the total sizes of those directories?
puts "Part 1"
puts "Find all of the directories with a total size of at most 100000. What is the sum of the total sizes of those directories?"
puts $directories.map{ |directory| directory.size }.filter{ |size| size <= 100000 }.sum

$total_space = 70000000
$total_required = 30000000
$du = $root.size
$unused = $total_space - $du
$required = $total_required - $unused

puts "Part 2"
puts "Find the smallest directory that can be created to meet the requirements."
puts "Total space: #{$total_space}"
puts "Total required: #{$total_required}"
puts "Total used: #{$du}"
puts "Total unused: #{$unused}"
puts "Total required: #{$required}"

puts $directories.filter { |directory| directory.size >= $required }.min_by { |directory| directory.size }.size
