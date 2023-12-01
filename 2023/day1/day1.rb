
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

  nums = {"one" => '1',
          "two" => '2',
          "three" => '3',
          "four" => '4',
          "five" => '5',
          "six" => '6',
          "seven" => '7',
          "eight" => '8',
          "nine" => '9'
  }

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
    # this is so bad, this is actually halarious 
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

    w_first_idx = w_first_idx.to_a .filter{|n| n[1] != nil} .min{|a, b| a[1] <=> b[1]}

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

    w_last_idx = w_last_idx.to_a .filter{|n| n[1] != nil} .max{|a, b| a[1] <=> b[1]}

    # so now this is the easy part 
    # we want to get the first number, that is digit or word 
    # then we want to get last number, that is digir or word 

    n = ""
    # dig_first_idx
    # dig_last_idx
    # is the index of a number found 
    # check if these are nil
    # "1" <- index
    # "2" line[dig_first_idx]

    # w_first_idx
    # w_last_idx
    # is the [number, index] of first letter word we found 
    # ["eight", 0]

    if not dig_first_idx.nil?
      if w_first_idx.nil?
        n << line[dig_first_idx]
      
      elsif dig_first_idx.to_i < w_first_idx[1].to_i
        n << line[dig_first_idx]
      else 
        n << nums[w_first_idx[0]]
      end 
    else 
      n << nums[w_first_idx[0]]
    end

    if not dig_last_idx.nil?
      if w_last_idx.nil?
        n << line[dig_last_idx]

      elsif dig_last_idx.to_i < w_last_idx[1].to_i
        n << line[dig_last_idx]
      else 
        n << nums[w_last_idx[0]]
      end 
    else
      n << nums[w_last_idx[0]]
    end
    
    puts "digits"
    p [line[dig_first_idx], line[dig_last_idx]]

    puts "words"
    p [nums[w_first_idx[0]], nums[w_last_idx[0]]]
    
    puts "#{line.join("")} #{n}"
    x += n.to_i
  end

  return x 
end

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"