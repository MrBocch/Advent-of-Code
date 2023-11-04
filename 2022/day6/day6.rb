
def part1 
  f = IO.read("input.txt")
  (4...f.length).each do |i|
    s = Set[f[i-4], f[i-3], f[i-2], f[i-1]]
    return i if s.length == 4
  end

  return nil
end

def part2 
  f = IO.read("input.txt")
  (14...f.length).each do |i|
    # ugly
    s = Set[f[i-14], f[i-13], f[i-12], f[i-11],
            f[i-10], f[i-9], f[i-8], f[i-7],
            f[i-6], f[i-5], f[i-4], f[i-3],
            f[i-2], f[i-1]]
    return i if s.length == 14
  end

  return nil
end
puts "Part1: #{part1}"
puts "Part2: #{part2}"