
def part1
  x = 0
  open("input.txt","r").each do |line|
    line.chomp!
    a = line.split("").grep(/[0-9]/)
    x += (a.first + a.last).to_i
  end

  return x
end

def part2

  nums = {"one" => 1,
          "two" => 2,
          "three" => 3,
          "four" => 4,
          "five" => 5,
          "six" => 6,
          "seven" => 7,
          "eight" => 8,
          "nine" => 9}

  x = 0
  open("test.txt","r").each do |line|
    line.chomp!
    line = line.split("")
    # find value of first digit 
    # find value of the last digit 
    # first digit is 0-9 that appears or word
    dig = line.grep(/[0-9]/)
    dig_first_idx = line.index(dig.first)
    dig_last_idx = line.rindex(dig.last)

    w_first_idx = {}
    w_last_idx = {}
    # p (line.join("")).rindex(/num/)
    # this is so bad, this is actually halarious 
    # i dont understand why some times
    # 'eighttwothree'
    # returns [["two", 4], ["three", 7]]
    # WHY DOES IT JUST SKIP 8????????????????
    (1..10).each do |i|
      if i == 1 
        w_first_idx["one"] = (line.join("")).index('one')
      elsif i == 2
        w_first_idx["two"] = (line.join("")).index('two')
      elsif i == 3
        w_first_idx["three"] = (line.join("")).index('three')      
      elsif i == 4
        w_first_idx["four"] = (line.join("")).index('four')
      elsif i == 5
        w_first_idx["five"] = (line.join("")).index('five')
      elsif i == 6
        w_first_idx["six"] = (line.join("")).index('six')
      elsif i == 7
        w_first_idx["seven"] = (line.join("")).index('seven')
      elsif i == 8
        w_first_idx["eight"] = (line.join("")).index('eight')
      elsif i == 9
        w_first_idx["nine"] = (line.join("")).index('nine')
      end
   end

   # w_first_idx = w_first_idx.to_a .filter{|n| n[1] != nil} .min{|n| n[1]}
   w_first_idx = w_first_idx.to_a
    (1..9).each do |i|
      if i == 1 
        w_last_idx["one"] = (line.join("")).rindex('one')
      elsif i == 2
        w_last_idx["two"] = (line.join("")).rindex('two')
      elsif i == 3
        w_last_idx["three"] = (line.join("")).rindex('three')      
      elsif i == 4
        w_last_idx["four"] = (line.join("")).rindex('four')
      elsif i == 5
        w_last_idx["five"] = (line.join("")).rindex('five')
      elsif i == 6
        w_last_idx["six"] = (line.join("")).rindex('six')
      elsif i == 7
        w_last_idx["seven"] = (line.join("")).rindex('seven')
      elsif i == 8
        w_last_idx["eight"] = (line.join("")).rindex('eight')
      elsif i == 9
        w_last_idx["nine"] = (line.join("")).rindex('nine')
      end
   end

   # w_last_idx = w_last_idx.to_a .filter{|n| n[1] != nil} .max{|n| n[1]}
   w_last_idx = w_last_idx.to_a
   p [w_first_idx, w_last_idx]
  end

  return x
end

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"