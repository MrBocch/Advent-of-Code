# A ROCK
# B PAPER 
# C SCISSORS

# X ROCK 1
# Y PAPER 2
# Z SCISSORS 3

# won = 6
# draw = 3
# lost = 0

def part1
  table = {
  ["A","X"] => 1 + 3,
  ["A","Y"] => 2 + 6,
  ["A","Z"] => 3 + 0,  
  
  ["B","X"] => 1 + 0,
  ["B","Y"] => 2 + 3,
  ["B","Z"] => 3 + 6,

  ["C","X"] => 1 + 6,
  ["C","Y"] => 2 + 0,
  ["C","Z"] => 3 + 3
}
  total = 0
  open("input.txt", "r").each do |line| line.chomp!
    total += table[line.split("").filter{|s| s != " "}]
  end

  return total 
end

puts "Part1: #{part1}"