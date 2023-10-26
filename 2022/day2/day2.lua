--[[
Total score is 
the sum of your scores for each round

A rock
B paper
C scissors

shape 
1 for rock
2 for paper
3 for sciccors

plus the outcome of round
0 if lost
3 if draw
6 if you won

points for round is (shape + lost/draw/won)    
--]]

p1 = {
    rock = "A",
    paper = "B",
    sciccors = "C" 
}

p2 = {
    rock = "X",
    paper = "Y",
    sciccors = "Z" 
}

rock = 1
paper = 2
sciccors = 3

lost = 0
draw = 3
won = 6

points = 0

function part1()
    file = io.open("input2.txt", "r")
    io.input(file)

    while true do
        local line = io.read("*line")
        if line == nil then break end
        left = string.sub(line, 1,1)
        right = string.sub(line, 3,3)

        if p1.rock == left then
            if p2.sciccors == right then
                points = points + (sciccors + lost)

            elseif p2.rock == right then
                points = points + (rock + draw)

            elseif p2.paper == right then
                points = points + (paper + won)
            end
        end

        if p1.paper == left then
            if p2.sciccors == right then
                points = points + (sciccors + won)

            elseif p2.rock == right then
                points = points + (rock + lost)

            elseif p2.paper == right then
                points = points + (paper + draw)
            end
        end

        if p1.sciccors == left then
            if p2.sciccors == right then
                points = points + (sciccors + draw)

            elseif p2.rock == right then
                points = points + (rock + won)

            elseif p2.paper == right then
                points = points + (paper + lost)
            end
        end

    end
    print(points) -- 13565
end

part1()

function part2()
    -- X: lose
    -- Y: draw
    -- Z: win    
    file = io.open("input2.txt", "r")
    io.input(file)

    points = 0
    while true do
        local line = io.read("*line")
        if line == nil then break end
        
        left = string.sub(line, 1,1)
        right = string.sub(line, 3,3)

        --maybe could use hashmap to make quicker + using elseif's/else
        --lose
        if right == "X" then
            if p1.rock == left then
                points = points + (sciccors + lost)
            end
            if p1.paper == left then
                points = points + (rock + lost)
            end
            if p1.sciccors == left then
                points = points + (paper + lost)
            end
        end

        --draw
        if right == "Y" then
            if p1.rock == left then
                points = points + (rock + draw)
            end
            if p1.paper == left then
                points = points + (paper + draw)
            end
            if p1.sciccors == left then
                points = points + (sciccors + draw)
            end
        end

        --win
        if right == "Z" then
            if p1.rock == left then
                points = points + (paper + won)
            end
            if p1.paper == left then
                points = points + (sciccors + won)
            end
            if p1.sciccors == left then
                points = points + (rock + won)
            end
        end
    end
    print(points)
end
--12324 
part2()