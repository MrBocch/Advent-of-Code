
function part1()
    local file = io.open("input4.txt", "r")
    io.input(file)

    local contained = 0
    local nums = {}

    while true do
        local line = io.read("*line")
        if line == nil then break end

        -- I did not knew about pattern matching functions
        start1, end1, start2, end2 = string.match(line, "(%d+)-(%d+),(%d+)-(%d+)")
        
        start1 = tonumber(start1)
        end1 = tonumber(end1)

        start2 = tonumber(start2)
        end2= tonumber(end2)

        if (start1 <= start2) and (end1 >= end2) then
            contained = contained + 1

        elseif (start2 <= start1) and (end2 >= end1) then
            contained = contained + 1
        end

    end


    print("Part1: "..contained)
    --Correct 542 
end

function part2()
    local file = io.open("input4.txt", "r")
    io.input(file)

    local overlaps = 0
    local nums = {}

    while true do
        local line = io.read("*line")
        if line == nil then break end

        -- I did not knew about pattern matching functions
        start1, end1, start2, end2 = string.match(line, "(%d+)-(%d+),(%d+)-(%d+)")
        
        start1 = tonumber(start1)
        end1 = tonumber(end1)

        start2 = tonumber(start2)
        end2= tonumber(end2)

        -- I dont understand why this works.
        -- I been hitting a wall a day4. Whats wrong?
        if start1 <= end2 and start2 <= end1 then
            overlaps = overlaps + 1
        end
        --Would of not figured it out if not for 
        -- https://github.com/cideM/aoc2022/blob/main/d4/main.lua
    end


    print("Part2: "..overlaps)
end

part1()
part2()