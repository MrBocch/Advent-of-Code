class Assignment
  attr_reader :start, :ends 

  def initialize(start, ends)
    @start = start 
    @ends = ends
  end
end

def part1
  pairs = [] 
  open("input.txt", "r").each do |line|
    line.chomp!

    pairs.push line.split(","). map{|part| part.split("-")}
  end

  contain = 0
  pairs.each do |pair|
    p1 = Assignment.new(pair.first[0].to_i, pair.first[1].to_i)
    p2 = Assignment.new(pair.last[0].to_i, rend = pair.last[1].to_i)

    if p2.start <= p1.start and p2.ends >= p1.ends 
      contain += 1 
    elsif p1.start <= p2.start and p1.ends >= p2.ends
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
    p1 = Assignment.new(pair.first[0].to_i,  pair.first[1].to_i)
    p2 = Assignment.new(pair.last[0].to_i, pair.last[1].to_i)

    if p1.start <= p2.start and p1.ends >= p2.start  
      overlap += 1
    elsif p2.start <= p1.start and p2.ends >= p1.start  
      overlap += 1
    end
  end

  return overlap 
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"