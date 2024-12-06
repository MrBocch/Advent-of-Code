
def part1
  grid = File.open("input.txt").read.split("\n")

  ptr = find_pointer(grid)
  visited = [[ptr.x, ptr.y]]
  while true do
    visited << [ptr.x, ptr.y] if !visited.include? [ptr.x, ptr.y]
    if ptr.direction == :up
      if ptr.y-1 < 0 then break end

      if grid[ptr.y-1][ptr.x] == "#"
        ptr.direction = :right
      else
        ptr.y -= 1
      end

    elsif ptr.direction == :right
      if ptr.x+1 >= grid[0].length then break end

      if grid[ptr.y][ptr.x+1] == "#"
        ptr.direction = :down
      else
        ptr.x += 1
      end

    elsif ptr.direction == :down
      if ptr.y+1 >= grid.length then break end

      if grid[ptr.y+1][ptr.x] == "#"
        ptr.direction = :left
      else
        ptr.y += 1
      end

    elsif ptr.direction == :left
      if ptr.x-1 < 0 then break end

      if grid[ptr.y][ptr.x-1] == "#"
        ptr.direction = :up
      else
        ptr.x -= 1
      end
    end
  end

  return visited.length
end

def find_pointer(grid)
  pointer = Struct.new(:x, :y, :direction)
  pntr = pointer.new(0, 0, :up)

  grid.each_with_index do |row, y|
    row.each_char.with_index do |char, x|
      if char == "^"  then
        pntr.x = x
        pntr.y = y
        return pntr
      end
    end
  end
  return pntr
end

puts "part1: #{part1}"
