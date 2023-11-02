
def part1
  # i cant think of way of parsin the initial stacks
  # that is not super uglly
  stacks = {
    "1" => %w[B Z T],
    "2" => %w[V H T D N],
    "3" => %w[B F M D],
    "4" => %w[T J G W V Q L],
    "5" => %w[W D G P V F Q M],
    "6" => %w[V Z Q G H F S],
    "7" => %w[Z S N R L T C W],
    "8" => %w[Z H W D J N R M],
    "9" => %w[M Q L F D S]
  }
          
  open("input.txt", "r").each do |line|
    if line[0] != "m" then next end

    split = line.scan(/\d+/)
    quantity = split[0].to_i
    from = split[1]
    to = split[2]
    
    # what a monstrosity
    stacks[to].push (stacks[from].slice! -quantity, quantity).reverse
    stacks[to].flatten!
  end

  ans = ""
  stacks.each_value{|crates| ans << crates.last}

  return ans
end

def part2
  # i cant think of way of parsin the initial stacks
  # that is not super uglly
  stacks = {
    "1" => %w[B Z T],
    "2" => %w[V H T D N],
    "3" => %w[B F M D],
    "4" => %w[T J G W V Q L],
    "5" => %w[W D G P V F Q M],
    "6" => %w[V Z Q G H F S],
    "7" => %w[Z S N R L T C W],
    "8" => %w[Z H W D J N R M],
    "9" => %w[M Q L F D S]
  }
          
  open("input.txt", "r").each do |line|
    if line[0] != "m" then next end

    split = line.scan(/\d+/)
    quantity = split[0].to_i
    from = split[1]
    to = split[2]
    
    # atleast only have to remove #.reverse
    stacks[to].push (stacks[from].slice! -quantity, quantity)
    stacks[to].flatten!
  end

  ans = ""
  stacks.each_value{|crates| ans << crates.last}

  return ans
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"