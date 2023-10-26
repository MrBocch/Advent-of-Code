
def day1
  posy = 0
  posx = 0

  File.open("input.txt", "r").each do |line|
    command = line.split(" ")
    if command[0] == "forward" then posx += command[1].to_i end
    if command[0] == "up" then posy -= command[1].to_i end
    if command[0] == "down" then posy += command[1].to_i end
  end

  return posy * posx
end

def day2
  posx = 0
  posy = 0
  aim  = 0

  File.open("input.txt", "r").each do |line|
    command = line.split(" ")
    if command[0] == "forward" 
      posx += command[1].to_i
      posy += aim * command[1].to_i
    end

    if command[0] == "up" then aim -= command[1].to_i end
    if command[0] == "down" then aim += command[1].to_i end
  end

  return posy * posx
end

puts "part1: #{day1()}"
puts "part2: #{day2()}"