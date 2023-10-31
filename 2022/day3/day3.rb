class String

  def isLower?
    return self == self.downcase
  end

end

def part1
  p1 = []
  p2 = []
  open("input.txt", "r").each {|line|
    line.chomp!
    p1.push line[0,line.length/2].split("").uniq
    p2.push line[line.length/2, line.length].split("").uniq
  }

  sum = 0
  # i think .count + sorting is terrible for performance
  (0..p2.length-1).each do |i|
    pp = p1[i] + p2[i]
    c = pp.sort_by {|c| pp.count(c)}.last

    c.isLower? ? sum += c.ord - 96
                : sum += c.ord - 38 
  end

  return sum 
end

def part2
  p1 = []
  p2 = []
  p3 = []
  i = 1
  open("input.txt", "r").each {|line|
    line.chomp!
    if i == 1 then p1.push(line.split("").uniq) end
    if i == 2 then p2.push(line.split("").uniq) end
    if i == 3 then p3.push(line.split("").uniq) end

    i+1 > 3 ? i = 1 : i += 1
    # i++ breaks code why?
  }

  sum = 0
  (0..p1.length-1).each do |i|
    # .tally would of made part1 much simpler
    c = (p1[i] + p2[i] + p3[i]).tally .filter{|key, val| val == 3}.keys.pop

    c.isLower? ? sum += c.ord - 96
                : sum += c.ord - 38 
  end

  return sum
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"