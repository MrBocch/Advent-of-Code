import Control.Monad ((>=>))

parseLine :: String -> [Int]
parseLine (x:xs) 
  | x == '@' = 1 : parseLine xs
  | x == '.' = 0 : parseLine xs
parseLine "" = []

parseInput :: [String] -> [[Int]]
parseInput = map parseLine 

get :: Int -> [a] -> Maybe a 
get i l 
  | i < 0 || i >= length l = Nothing
  | otherwise              = Just (l !! i)

part1 :: [[Int]]  -> Int 
part1 m = forLoop 0 0 0 
  where
    rows = head m
    cols = head . head $ m 
    -- I was struggeling for ever, until decided to ask chatgpt how to compose the get function
    -- with itself
    -- It hit me like a truck when I saw the type definition for (>=>)
    -- when I read the Kleisli chapter in Category Theory for Programmers
    -- I thought it was only useful for composing functions that return logs
    -- Wow, now I see, >=> is a lot more general. Should reread that chapter 
    get' i j = (get i >=> get j) m

    -- i want to map this function over
    -- the matrix but idk how, some variation of zipWithIndex
    countNeighbors i j = sum . fmap sum $ 
                         [ get' (i-1) (j-1)
                         , get' (i-1) (j+0)
                         , get' (i-1) (j+1)
                         , get' (i+0) (j+1)
                         , get' (i+1) (j+1)
                         , get' (i+1) (j+0)
                         , get' (i+1) (j-1)
                         , get' (i+0) (j-1)
                         ]
    - 
    forLoop :: Int -> Int -> Int 
    forLoop i j acc 
      | i >= rows = acc   
      | j >= cols = forLoop (i+1) 0 acc 
      | otherwise = forLoop i (j+1) acc 
    
main :: IO ()
main = do
  content <- readFile "t.txt"
  let parsed = parseInput . words $ content 
  print (part1 parsed) 
