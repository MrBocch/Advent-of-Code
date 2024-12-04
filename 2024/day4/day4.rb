
def part1
  matrix = File.readlines("input.txt", chomp:true)
  christmas_total = 0
  # example have 18
  matrix.each_index do |y|
    0.upto(matrix[y].length()-1).each do |x|

      # check down
      if  ( (y+3) < matrix.length())
        #print "[#{matrix[y][x]}-#{matrix[y+1][x]}-#{matrix[y+2][x]}-#{matrix[y+3][x]}]"
        str = "#{matrix[y][x]}#{matrix[y+1][x]}#{matrix[y+2][x]}#{matrix[y+3][x]}"
        christmas_total += 1 if str == "XMAS"
      end
      # check up
      if not ( (y-3) < 0)
        #print "[#{matrix[y][x]}-#{matrix[y-1][x]}-#{matrix[y-2][x]}-#{matrix[y-3][x]}]"
        str =  "#{matrix[y][x]}#{matrix[y-1][x]}#{matrix[y-2][x]}#{matrix[y-3][x]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check right
      if ( (x+3) < matrix[x].length())
        #print "[#{matrix[y][x]}-#{matrix[y][x+1]}-#{matrix[y][x+2]}-#{matrix[y][x+3]}]"
        str = "#{matrix[y][x]}#{matrix[y][x+1]}#{matrix[y][x+2]}#{matrix[y][x+3]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check left
      if ( (x-3) >= 0)
        #print "[#{matrix[y][x]}-#{matrix[y][x-1]}-#{matrix[y][x-2]}-#{matrix[y][x-3]}]"
        str = "#{matrix[y][x]}#{matrix[y][x-1]}#{matrix[y][x-2]}#{matrix[y][x-3]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check bottm right
      if ( (x+3) < matrix[x].length()) and ( (y+3) < matrix.length())
        # print "[#{matrix[y][x]}-#{matrix[y+1][x+1]}-#{matrix[y+2][x+2]}-#{matrix[y+3][x+3]}]"
        str = "#{matrix[y][x]}#{matrix[y+1][x+1]}#{matrix[y+2][x+2]}#{matrix[y+3][x+3]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check bottom left
      if ( (y+3) < matrix.length()) and ( (x-3) >= 0)
        #print "[#{matrix[y][x]}-#{matrix[y+1][x-1]}-#{matrix[y+2][x-2]}-#{matrix[y+3][x-3]}]"
        str = "#{matrix[y][x]}#{matrix[y+1][x-1]}#{matrix[y+2][x-2]}#{matrix[y+3][x-3]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check top right
      if ( (x+3) < matrix[x].length()) and (not ( (y-3) < 0))
        # print "[#{matrix[y][x]}-#{matrix[y-1][x+1]}-#{matrix[y-2][x+2]}-#{matrix[y-3][x+3]}]"
        str = "#{matrix[y][x]}#{matrix[y-1][x+1]}#{matrix[y-2][x+2]}#{matrix[y-3][x+3]}"
        christmas_total += 1 if str == "XMAS"
      end

      # check top left
      if ( (x-3) >= 0) and (not ( (y-3) < 0))
        # print "[#{matrix[y][x]}-#{matrix[y-1][x-1]}-#{matrix[y-2][x-2]}-#{matrix[y-3][x-3]}]"
        str = "#{matrix[y][x]}#{matrix[y-1][x-1]}#{matrix[y-2][x-2]}#{matrix[y-3][x-3]}"
        christmas_total += 1 if str == "XMAS"
      end
      # puts ""
    end

  end

  return christmas_total
end

def part2
  matrix = File.readlines("input.txt", chomp:true)
  mass_total = 0

  # example have 9
  matrix.each_index do |y|
    0.upto(matrix[y].length()-1).each do |x|
      if ( (x+2) < matrix[x].length()) and ( (y+2) < matrix.length())

        top_left = matrix[y][x]
        top_right = matrix[y][x+2]

        mid = matrix[y+1][x+1]

        bot_left = matrix[y+2][x]
        bot_right = matrix[y+2][x+2]

        mass_total += 1 if (top_left == "M" and top_right == "M") and
                                (mid == "A") and
          (bot_left == "S" and bot_right == "S")

        mass_total += 1 if (top_left == "S" and top_right == "M") and
                                  (mid == "A") and
          (bot_left == "S" and bot_right == "M")

        mass_total += 1 if (top_left == "S" and top_right == "S") and
                                  (mid == "A") and
          (bot_left == "M" and bot_right == "M")

        mass_total += 1 if (top_left == "M" and top_right == "S") and
                                  (mid == "A") and
          (bot_left == "M" and bot_right == "S")


        #puts "#{matrix[y][x]}-.-#{matrix[y][x+2]}"
        #puts ".-#{matrix[y+1][x+1]}-."
        #puts "#{matrix[y+2][x]}-.-#{matrix[y+2][x+2]}"
      end
      # puts ""
    end
  end

  return mass_total
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
