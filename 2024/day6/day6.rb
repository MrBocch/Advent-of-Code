
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

# i cant understand why it does not work
# what is this rare case that is messing it up, its overcounting
# meaning, its counting loops that it shouldnt
#
# 'The new obstruction can't be placed at the guard's starting position'
# i just now read this and added the code to stop it, yet i still
# get the same answer wtf,
def part2
  grid = File.open("input.txt").read.split("\n")
  ptr = find_pointer(grid)
  start_p = ptr.clone

  loops = 0
  while true do
    #puts "x: #{ptr.x+1} y: #{ptr.y+1}"
    if ptr.direction == :up
      if ptr.y-1 < 0 then break end

      if grid[ptr.y-1][ptr.x] == "#"
        ptr.direction = :right
      else
        # change it back, rather not use a deep clone
        if not (ptr.y-1 == start_p.y and ptr.x == start_p.x)
          pclone = ptr.clone
          grid[ptr.y-1][ptr.x] = "#"
          loops += 1 if a_loop? grid, pclone
          grid[ptr.y-1][ptr.x] = "."
        end

        ptr.y -= 1
      end

    elsif ptr.direction == :right
      if ptr.x+1 >= grid[0].length then break end

      if grid[ptr.y][ptr.x+1] == "#"
        ptr.direction = :down
      else
        if not (ptr.y == start_p.y and ptr.x+1 == start_p.x)
          pclone = ptr.clone
          grid[ptr.y][ptr.x+1] = "#"
          loops += 1 if a_loop? grid, pclone
          grid[ptr.y][ptr.x+1] = "."
        end

        ptr.x += 1
      end

    elsif ptr.direction == :down
      if ptr.y+1 >= grid.length then break end

      if grid[ptr.y+1][ptr.x] == "#"
        ptr.direction = :left
      else
        if not (ptr.y+1 == start_p.y and ptr.x == start_p.x)
          pclone = ptr.clone
          grid[ptr.y+1][ptr.x] = "#"
          loops += 1 if a_loop? grid, pclone
          grid[ptr.y+1][ptr.x] = "."
        end

        ptr.y += 1
      end

    elsif ptr.direction == :left
      if ptr.x-1 < 0 then break end

      if grid[ptr.y][ptr.x-1] == "#"
        ptr.direction = :up
      else
        if not (ptr.y == start_p.y and ptr.x-1 == start_p.x)
          pclone = ptr.clone
          grid[ptr.y][ptr.x-1] = "#"
          loops += 1 if a_loop? grid, pclone
          grid[ptr.y][ptr.x-1] = "."
        end

        ptr.x -= 1
      end
    end
  end

  return loops
end

def a_loop?(grid, ptr)
  visited = []
  passes = 0
  while true do
    if visited.include? [ptr.x, ptr.y, ptr.direction] and visited.count [ptr.x, ptr.y, ptr.direction] == 2 then return true end
    if not passes == 0
      visited << [ptr.x, ptr.y, ptr.direction]
    else
      passes += 1
    end

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

# puts "part1: #{part1}"
puts "part2: #{part2}"
# 1796
# 1663
# 133 over
