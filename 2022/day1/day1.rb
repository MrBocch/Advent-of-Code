def part1
  max_sum = 0
  bucket = []
  File.open("input.txt", "r").each do |line|
    line.chomp!

    if line != "" 
      bucket.push line.to_i
    else 
      max_sum = [max_sum, bucket.sum].max
      bucket = []
    end
  end

  return max_sum
end

def part2
  sum = 0
  bucket = []
  File.open("input.txt", "r").each do |line|
    line.chomp!

    if line != "" 
      sum += line.to_i
    else 
      bucket.push sum
      sum = 0
    end
  end

  # return bucket.max(3).sum
  # what is faster? 
  return bucket.sort_by{|n| -n}.take(3).sum
end


puts "Part1: #{part1}"
puts "Part2: #{part2}"