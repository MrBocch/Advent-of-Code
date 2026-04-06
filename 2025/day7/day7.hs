import Data.Array

-- should probably just have a Array Int (Array Int Char)
mazeToArray :: [String] -> Array Int (Array Int Char)
mazeToArray maze = listArray (0, length maze - 1) rows
    where
        rows = map toRow maze
        toRow s = listArray (0, length s - 1) s

-- the wrong approach, considering time complexity
--                     and its not even correct
--                     you are over counting,
--                     should have tried with example input
--                     instead of going straight to writing code
splitBeams :: [String] -> Int
splitBeams maze = splitBeams' (si) sj
    where
        ma = mazeToArray maze
        baseLimit = length maze
        si = 0
        sj = findStart (maze !! 0) 0
        findStart :: String -> Int -> Int
        findStart (x:xs) i
            | x == 'S'    = i
            | otherwise   = findStart xs (i+1)

        splitBeams' :: Int -> Int -> Int
        splitBeams' i j
            | i+1 >= baseLimit          = 0
            | (ma ! (i+1)) ! j == '.'   = splitBeams' (i+1) j
            | (ma ! (i+1)) ! j == '^'   = 1 + (splitBeams' (i+1) (j-1)) + (splitBeams' (i+1) (j+1))

main :: IO ()
main = do
    maze <- readFile "test.txt"
    print $ splitBeams . lines $ maze
