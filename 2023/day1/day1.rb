
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

  # this is so ugly, im sorry
  # i thought, i should write quick and dirty
  # code, so that i could reach a high rank on
  # the leaderboard, but that only slowed me 
  # down when i could not solve it first try
  # and had to see what did i do wrong
  # valuable lesson here

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
  open("input.txt","r").each do |line|
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

    # how do i handle the nil cases?
   
    # helpfull debugging lol
    # puts "#{line.join("")}"

    n = ""
    if not dig_first_idx.nil? and not w_first_idx.nil?
      # if both are not nil
      if dig_first_idx.to_i < w_first_idx[1].to_i
        n << line[dig_first_idx]
      else 
        n << nums[w_first_idx[0]]
      end
    
      # my mistake was this, i was not using greater than here, lol im tired ok 
      if dig_last_idx > w_last_idx[1].to_i 
        n << line[dig_last_idx]
      else 
        n << nums[w_last_idx[0]] 
      end   

    # if dig is nil but words is not nil
    elsif dig_first_idx.nil? and not w_first_idx.nil? 
      n << nums[w_first_idx[0]]
      n << nums[w_last_idx[0]]

    # if dig is not nil but words is nil
    elsif not dig_first_idx.nil? and w_first_idx.nil?
      n << line[dig_first_idx]
      n << line[dig_last_idx]
    end

    # helpfull debuggin lol
    # puts n + "\n\n"

    x += n.to_i
  end

  return x 
end

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"