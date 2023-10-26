function part1()
    stacks = {
        {"B","Z","T"},
        {"V","H","T","D","N"},
        {"B","F","M","D"},
        {"T","J","G","W","V","Q","L"},
        {"W","D","G","P","V","F","Q","M"},
        {"V","Z","Q","G","H","F","S"},
        {"Z","S","N","R","L","T","C","W"},
        {"Z","H","W","D","J","N","R","M"},
        {"M","Q","L","F","D","S"}
    }

    local file = io.open("input5.txt","r")
    io.input(file)

    for i=1, 10 do --skips over the stacks
        io.read("*line")
    end

    while true do
        local line = io.read("*line")
        if line == nil then break end
                                                --("%d+") becuse it might be more than 9
        crates, pile1, pile2 = string.match(line, "move (%d+) from (%d+) to (%d+)")
        local crates = tonumber(crates)
        local pile1 = tonumber(pile1)
        local pile2 = tonumber(pile2)

        --print(#stacks[pile1])  length of pile1
        --print(stacks[pile1][#stacks[pile1]]) what value
        
        --print(#stacks[pile2]) length of pile2
        --print(stacks[pile2][#stacks[pile2]]) what value 

        for i=1, crates do
            table.insert(stacks[pile2], stacks[pile1][#stacks[pile1]])
            table.remove(stacks[pile1], #stacks[pile1])
        end

    end

    io.write("Part 1: ")
    for i=1, 9 do
        io.write(stacks[i][#stacks[i]])
    end
    print()
end

function part2()
    -- my solution is to first push into intermediate stack
    -- then pop into the other stack
    stacks = {
        {"B","Z","T"},
        {"V","H","T","D","N"},
        {"B","F","M","D"},
        {"T","J","G","W","V","Q","L"},
        {"W","D","G","P","V","F","Q","M"},
        {"V","Z","Q","G","H","F","S"},
        {"Z","S","N","R","L","T","C","W"},
        {"Z","H","W","D","J","N","R","M"},
        {"M","Q","L","F","D","S"}
    }

    local file = io.open("input5.txt","r")
    io.input(file)

    for i=1, 10 do --skips over the stacks
        io.read("*line")
    end

    while true do
        local line = io.read("*line")
        if line == nil then break end
                                                --("%d+") becuse it might be more than 9
        crates, pile1, pile2 = string.match(line, "move (%d+) from (%d+) to (%d+)")
        local crates = tonumber(crates)
        local pile1 = tonumber(pile1)
        local pile2 = tonumber(pile2)

        local intermediate = {}

        for i=1, crates do
            table.insert(intermediate, stacks[pile1][#stacks[pile1]])
            table.remove(stacks[pile1], #stacks[pile1])
        end

        for i=1, crates do
            table.insert(stacks[pile2], intermediate[#intermediate])
            table.remove(intermediate, #intermediate)
        end
    end

    io.write("Part 2: ")
    for i=1, 9 do
        io.write(stacks[i][#stacks[i]])
    end
end

part1()
part2()
