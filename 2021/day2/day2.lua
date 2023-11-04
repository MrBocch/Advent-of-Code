
function part1()
    local sub = {
        x = 0,
        y = 0
    }

    for line in io.lines("input.txt") do
        command, num = string.match(line, "(%w+) (%d+)")
        num = tonumber(num)

        if command == "forward" then
            sub.x = sub.x + num

        elseif command == "down" then
            sub.y = sub.y + num 

        elseif command == "up" then
            sub.y = sub.y - num
        end
    end

    return sub.x * sub.y
end

function part2()
    local sub = {
        x = 0,
        y = 0,
        aim = 0
    }

    for line in io.lines("input.txt") do
        command, num = string.match(line, "(%w+) (%d+)")
        num = tonumber(num)

        if command == "forward" then
           sub.x = sub.x + num
           sub.y = sub.y + (sub.aim * num) 

        elseif command == "down" then
            sub.aim = sub.aim + num

        elseif command == "up" then
            sub.aim = sub.aim - num
        end
    end

    return sub.x * sub.y
end

print("Part1: " .. part1())
print("Part2: " .. part2())