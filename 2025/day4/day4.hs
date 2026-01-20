-- Dont want to fully get into it because im busy
-- but I'll write down the function signatures
-- have a basic idea of what im going to do.
-- I could probably just reuse the code from when
-- implemented game of life in C.

parseInput :: [String] -> [[Int]]
-- turn ".@", if . -> 0
--            if @ -> 1

countNeighbors :: [[Int]] -> (Int, Int) -> Int  
-- takes matrix, x,y, returns the count of neighbors

surroundingHelper :: (Int, Int) -> [(Int, Int)] 
-- lets say for cell at 0,0
-- check for
-- [ ( 0,  1)
--   ( 0, -1)
--   ( 1,  0)
--   (-1,  0)
--   ( 1,  1)
--   ( 1, -1)
--   (-1,  1)
--   (-1, -1)
-- ]
-- do i just manually write it out?
-- don't know how to automate it with code.
-- after im done should look for examples of game of life.
