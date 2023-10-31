
def part1
  pairs = [] 
  open("input.txt", "r").each do |line|
    line.chomp!

    pairs.push line.split(","). map{|part| part.split("-")}
  end

  contain = 0
  pairs.each do |pair|
    # variable names are so bad
    lbeg = pair.first[0].to_i
    rbeg = pair.first[1].to_i

    lend = pair.last[0].to_i
    rend = pair.last[1].to_i

    if lend <= lbeg and rend >= rbeg 
      contain += 1 
    elsif lbeg <= lend and rbeg >= rend 
      contain += 1
    end
  end

  return contain
end

def part2
  pairs = [] 
  open("input.txt", "r").each do |line|
    line.chomp!

    pairs.push line.split(","). map{|part| part.split("-")}
  end

  overlap = 0
  pairs.each do |pair|
    p1start = pair.first[0].to_i
    p1end = pair.first[1].to_i

    p2start = pair.last[0].to_i
    p2end = pair.last[1].to_i

    if p1start <= p2start and p1end >= p2start 
      overlap += 1
    elsif p2start <= p1start and p2end >= p1start
      overlap += 1
    end
  end

  return overlap 
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"