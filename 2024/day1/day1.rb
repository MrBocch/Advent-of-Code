def part1
  l1 = []
  l2 = []
  File.open("input.txt", "r").each do |line|
    l = line.split("   ")
    l1.push l[0].to_i
    l2.push l[1].to_i
  end
  l1.sort!
  l2.sort!

  total_distance = 0
  l1.each_index do |i|
    total_distance += (l1[i] - l2[i]).abs
  end
  return total_distance
end


def part2
  l1 = []
  l2 = []
  File.open("input.txt", "r").each do |line|
    l = line.split("   ")
    l1.push l[0].to_i
    l2.push l[1].to_i
  end
  set1 = l1.tally
  set2 = l2.tally

  sim_score = 0
  set1.each_key do |key|
    puts "Key #{key} times #{set1[key]}"
    if set2.include? key
      sim_score += key * set2[key]
    end
  end

  return sim_score
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
