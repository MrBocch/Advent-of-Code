values = {"a","b","c","d","e","f","g","h",
"i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
          "A","B","C","D","E","F","G","H",
"I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
}

function part1()
    file = io.open("input3.txt", "r")
    io.input(file)
    local sum = 0
    while true do
        local line = io.read("*line")
        if line == nil then break end

        local comp1 = string.sub(line, 1, #line/2)
        local comp2 = string.sub(line, #line/2 +1, #line)

        local set = {}
        for i=1, #comp1 do
            set[string.sub(comp1, i, i)] = true
        end

        local letter = nil
        for i=1, #comp2 do
            if set[string.sub(comp2, i, i)] then
                letter = (string.sub(comp2,i,i))
                break
            end
        end

        for k, v in ipairs(values) do
            if v == letter then
                sum = sum + k
                break
            end
        end
    end
    print("Part 1:", sum)
end

function part2()
    file = io.open("input3.txt", "r")
    io.input(file)
    
    local sum = 0
    while true do
        local line1 = io.read("*line")
        local line2 = io.read("*line")
        local line3 = io.read("*line")

        if line1 == nil then break end
        
        local set1 = {}
        for i=1, #line1 do
            set1[string.sub(line1, i, i)] = true
        end

        local set2 = {}
        for i=1, #line2 do
            set2[string.sub(line2, i, i)] = true
        end

        local letter = nil
        for i=1, #line3 do
            if set1[string.sub(line3, i, i)] and set2[string.sub(line3, i, i)] then

                letter = string.sub(line3, i,i)
                
                for k, v in ipairs(values) do
                    if v == letter then
                        sum = sum + k
                        break
                    end
                end

                --will not work without this break 
                break --the letter could show up multiple times so you need to break out
            end
        end


    end 

    print("Part 2: "..sum)
end

part1()
part2()