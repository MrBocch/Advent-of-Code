import Data.List (sortOn)

-- Basement.String package contains this
splitDash :: String -> (String, String)
splitDash s = splitDash' s ""
  where 
    splitDash' :: String -> String -> (String, String)
    splitDash' (x:xs) carry = if x == '-'
                                then (carry, xs)
                                else splitDash' xs (carry ++ [x]) 

sTupIntg :: (String, String) -> (Integer, Integer)
sTupIntg (a, b) = (read a :: Integer, read b :: Integer)

parseInput :: [String] -> ([(Integer, Integer)], [Integer])
parseInput input = parseInput' input [] []
  where
    parseInput' :: [String] -> [(Integer, Integer)] -> [Integer] -> ([(Integer, Integer)], [Integer])
    parseInput' (x:xs) ranges ids 
      | elem '-' x = parseInput' xs (parseDashLine x : ranges) (ids)
      | otherwise  = parseInput' xs (ranges) ((read x :: Integer) :ids) 
    parseInput' [] ranges ids = (ranges, ids)

    parseDashLine = sTupIntg . splitDash  

isFresh :: Integer -> (Integer, Integer) -> Bool 
isFresh n (start, end) = start <= n && n <= end 

part1 :: [(Integer, Integer)] -> [Integer] -> Int
part1 ranges ids = part1' ids 0
  where
    part1' (ix:ixs) acc
      | any (isFresh ix) ranges  = part1' ixs (acc+1)
      | otherwise                = part1' ixs acc 
    part1' [] acc = acc 

part2 :: [(6nteger, Integer)] -> [(Integer, Integer)]
part2 ranges = srange 
  where
    srange = sortOn (\(a,b) -> (a,b)) ranges 
    solver' :: [(Integer, Integer)] -> [(Integer, Integer)] 
    solver' ((a,b):(c,d):rest) acc
      | a > d && 

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let (ranges, ids) =  parseInput . words $ contents
  putStrLn "Part 1"
  print $ part1 ranges ids 
  putStrLn "Part 2"
  print $ part2 ranges 
