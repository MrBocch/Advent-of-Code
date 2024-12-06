
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

def part2
  grid = File.open("input.txt").read.split("\n")
  ptr = find_pointer(grid)
  loops = 0
  while true do
    if ptr.direction == :up
      if ptr.y-1 < 0 then break end

      if grid[ptr.y-1][ptr.x] == "#"
        ptr.direction = :right
      else
        pclone = ptr.clone
        # change it back, rather not use a deep clone
        grid[ptr.y-1][ptr.x] = "#"
        loops += 1 if a_loop? grid, pclone
        grid[ptr.y-1][ptr.x] = "."

        ptr.y -= 1
      end

    elsif ptr.direction == :right
      if ptr.x+1 >= grid[0].length then break end

      if grid[ptr.y][ptr.x+1] == "#"
        ptr.direction = :down
      else
        pclone = ptr.clone
        grid[ptr.y][ptr.x+1] = "#"
        loops += 1 if a_loop? grid, pclone
        grid[ptr.y][ptr.x+1] = "."

        ptr.x += 1
      end

    elsif ptr.direction == :down
      if ptr.y+1 >= grid.length then break end

      if grid[ptr.y+1][ptr.x] == "#"
        ptr.direction = :left
      else
        pclone = ptr.clone
        grid[ptr.y+1][ptr.x] = "#"
        loops += 1 if a_loop? grid, pclone
        grid[ptr.y+1][ptr.x] = "."

        ptr.y += 1
      end

    elsif ptr.direction == :left
      if ptr.x-1 < 0 then break end

      if grid[ptr.y][ptr.x-1] == "#"
        ptr.direction = :up
      else
        pclone = ptr.clone
        grid[ptr.y][ptr.x-1] = "#"
        loops += 1 if a_loop? grid, pclone
        grid[ptr.y][ptr.x-1] = "."

        ptr.x -= 1
      end
    end
  end

  return loops
end

def a_loop?(grid, ptr)
  visited = []
  while true do
    if visited.include? [ptr.x, ptr.y, ptr.direction] then return true end

    visited << [ptr.x, ptr.y, ptr.direction]

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
  return false
end

puts "part1: #{part1}"
puts "part2: #{part2}"
