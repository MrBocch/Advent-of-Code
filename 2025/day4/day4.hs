import Control.Monad ((>=>))

parseLine :: String -> [Int]
parseLine (x:xs) 
  | x == '@' = 1 : parseLine xs
  | x == '.' = 0 : parseLine xs
parseLine "" = []

parseInput :: [String] -> [[Int]]
parseInput = map parseLine 
    
-- part1 :: [[Int]] -> [Bool] 
part1 m = forLoop 0 0 [] 
  where
    rows           = length m
    cols           = (length . head) m  
    get :: Int -> [a] -> Maybe a 
    get i l 
      | i < 0 || i >= length l = Nothing
      | otherwise              = Just (l !! i)
    -- I was struggeling for ever, until decided to ask chatgpt how to compose the get function
    -- with itself
    -- It hit me like a truck when I saw the type definition for (>=>)
    -- when I read the Kleisli chapter in Category Theory for Programmers
    -- I thought it was only useful for composing functions that return logs
    -- Wow, now I see, >=> is a lot more general. Should reread that chapter 
    -- am i doing this in right order? 
    get' i j = (get i >=> get j) m

    countNeighbors i j = if m !! i !! j == 0 then 99 else 
      sum . fmap sum $ 
         [ get' (i-1) (j-1)
         , get' (i-1) (j+0)
         , get' (i-1) (j+1)
         , get' (i+0) (j+1)
         , get' (i+1) (j+1)
         , get' (i+1) (j+0)
         , get' (i+1) (j-1)
         , get' (i+0) (j-1)
         ]
      
    -- should instead do some map operation, but how do i zipwithIndex? 
    -- this code is soo slow
    forLoop i j acc 
      | i >= rows = acc  
      | j >= cols = forLoop (i+1) 0 acc 
      | otherwise = forLoop i (j+1) (acc ++ [countNeighbors i j < 4])
 

main :: IO ()
main = do
  content <- readFile "input.txt"
  let parsed = parseInput . words $ content 
  -- what a cool way to filter a list a bools for True (id False == False)
  print (length . filter id $ part1 parsed) 
