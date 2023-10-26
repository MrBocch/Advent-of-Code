
function part1()
    local file = io.open("input6.txt","r")
    io.input(file)

    local string = io.read("*all")

    for i=4, #string do
        -- This is a very slow solution
        -- This wont be a adecuate solution for part2
        -- have to check 14 seperate characters

        local let1 = string.sub(string, i-3,i-3)
        local let2 = string.sub(string, i-2,i-2)
        local let3 = string.sub(string, i-1,i-1)
        local let4 = string.sub(string, i,i)

        if let1 ~= let2 and let1 ~= let3 and let1 ~= let4 then
            if let2 ~= let3 and let2 ~= let4 then
                if let3 ~= let4 then
                    print("Part 1: "..i)
                    return
                end
            end
        end

    end

end

function part2()
    local file = io.open("input6.txt")
    io.input(file)

    local string = io.read("*all")

    for i=14, #string do
        set = {}
        setSize = 0

        for k= i-13, i do
            if set[string.sub(string, k,k)] == nil then
                set[string.sub(string, k,k)] = true
                setSize = setSize + 1
            else break end 
        end
    
        if setSize == 14 then
            print("Part 2: "..i)
            return
        end

    end
end

part1()
part2()