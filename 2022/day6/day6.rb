
def part1 
  f = IO.read("input.txt")
  (4...f.length).each do |i|
    s = Set[f[i-4], f[i-3], f[i-2], f[i-1]]
    return i if s.length == 4
  end

  return nil
end

puts "Part1: #{part1}"