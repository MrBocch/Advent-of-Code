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
  # i think .count is terrible for performance
  (0..p2.length-1).each do |i|
    pp = p1[i] + p2[i]
    c = pp.sort_by {|c| pp.count(c)}.last

    c.isLower? ? sum += c.ord - 96
                : sum += c.ord - 38 
  end

  return sum 
end

puts "Part1: #{part1}"