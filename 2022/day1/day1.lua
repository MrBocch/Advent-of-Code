file = io.open("input1.txt", "r")
io.input(file)

max = {0, 0, 0}
i = 0

while true do
    local line = io.read("*line")
    if line == nil then break end

    if line == "" then
        for k=1, #max do
            if max[k] < i then
                max[k] = i
                break
            end
        end
        i = 0
    else
        i = i + tonumber(line)
    end
end

--part 1, 66306
print(max[1])

--part 2, 195292
sum = 0
for k=1, #max do
    sum = sum + max[k]
end
print(sum)
