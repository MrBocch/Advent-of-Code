
function part1() 
    local file = io.open("input.txt", "r")
    io.input(file)

    local prev = nil
    local increase = 0

    while true do
        local line = io.read("*line")
        if line == nil then break end

        line = tonumber(line)

        if not(prev == nil) and prev < line then
            increase = increase + 1
        end 

        prev = line
    end

    print("Part 1: ".. increase)
end

function part2() 
    local file = io.open("input.txt", "r")
    io.input(file)

    local v = 0
    local count = 1
    local a = {}

    while true do 
        v = io.read("*line")
        if v == nil then break end

        a[count] = tonumber(v)
        count = count + 1
    end

    local nSums = 0
    for i=3, count do
        local sum1 = a[i-2] + a[i-1] + a[i] 
        if a[i+1] == nil then break end
        local sum2 = a[i-1] + a[i] + a[i+1] 

        if sum1 < sum2 then
            nSums = nSums + 1
        end
    end  

    print("Part 2: "..nSums)
end

part1()
part2()