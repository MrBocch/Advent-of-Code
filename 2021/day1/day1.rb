def part1
  buck = []
  diff = 0

  File.open("input.txt", "r").each {|line| buck << line.chomp!.to_i}
  buck.each_cons(2){|a, b| if a < b then diff +=1 end}
  return diff
end

def part2
  buck = []
  File.open("input.txt", "r").each {|line| buck << line.chomp!.to_i}

  diff = 0
  (0..buck.length-4).each do |i|
    group1 = [buck[i], buck[i+1], buck[i+2]].sum 
    group2 = [buck[i+1], buck[i+2], buck[i+3]].sum
    diff += 1 if group1 < group2  
  end

  return diff
end


puts "Part1: #{part1}"
puts "Part2: #{part2}"