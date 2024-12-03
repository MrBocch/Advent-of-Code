
def part1
  file = File.read("input.txt")
  pattern = /mul\((\d+),(\d+)\)/

  matches = file.scan(pattern)
  return matches.map{|pair| pair[0].to_i * pair[1].to_i}.sum
end

def part2
  file = File.read("input.txt")
  file.concat("----------------------")# so dont have to do the math for not 'outof index error'

  pattern = /mul\((\d+),(\d+)\)/
  read = true
  result = 0

  file.chars.each_index do |i|
    if file[i..i+4] == "-----" then break end

    if file[i] == "d"
      if file.slice(i..i+6) == "don't()"
        read = false
      end
      if file.slice(i..i+3) == "do()"
        read = true
      end
    end

    if file[i] == "m" and read
      # cavemanmode:
      # if pair = file[i..i+15].match(pattern)
      # if pair = file[i..i+14].match(pattern)
      # if pair = file[i..i+13]match(pattern)
      # i correctly suspected i was overcounting certain matches (is this whats happening?)
      # this is a terrible solution, the first part was so elegant
      # what if i still did the same but, you split the string up into only the parts that have the do() before the don't()
      if pair = file[i..i+12].match(pattern)
        result +=  pair[1].to_i * pair[2].to_i
      end
    end
  end

  return result
end

def part2_pretty
  # yeah, this is sooo much better, not count because i had helped from chatgpt
  # besides the regex bit

  # yeah, as soon as i saw the 'mul(num,num)' i first thought, ok, a regex will solve this
  # but why did it not occure to me to do the same on the 'do()' and 'don\'t()'
  # well only after i solved it like a caveman lol

  file = File.read("input.txt")
  file = file.prepend "do()"
  pattern = /mul\((\d+),(\d+)\)/

  segments = file.split(/(?=do\(\)|don't\(\))/) # Split where 'do()' or 'dont()' starts

  filtered_segments = segments.select do |segment|
    segment.strip.start_with?('do()') # Keep only segments starting with 'do()'
  end
  # did not knew you could do this

  matches = filtered_segments.join().scan(pattern)
  return matches.map{|pair| pair[0].to_i * pair[1].to_i}.sum
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
puts "Part2(chatgpt): #{part2_pretty}"
