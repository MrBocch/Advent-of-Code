import Control.Monad ((>=>))
import Data.Maybe (fromJust)

parseLine :: String -> [Int]
parseLine (x : xs)
  | x == '@' = 1 : parseLine xs
  | x == '.' = 0 : parseLine xs
parseLine "" = []

parseInput :: [String] -> [[Int]]
parseInput = map parseLine

get :: Int -> [a] -> Maybe a
get i l
  | i < 0 || i >= length l = Nothing
  | otherwise = Just (l !! i)

part1 :: [[Int]] -> Int
part1 m = forLoop 0 0 0
  where
    -- I was struggeling for ever, until decided to ask chatgpt how to compose the get function
    -- with itself
    -- It hit me like a truck when I saw the type definition for (>=>)
    -- when I read the Kleisli chapter in Category Theory for Programmers
    -- I thought it was only useful for composing functions that return logs
    -- Wow, now I see, >=> is a lot more general. Should reread that chapter
    -- am i doing this in right order?
    get' i j = (get i >=> get j) m

    canBeAccessed :: Int -> Int -> Bool
    canBeAccessed i j =
      if m !! i !! j == 0
        then False
        else
          (< 4) . sum . fmap sum $
            [ get' (i - 1) (j - 1),
              get' (i - 1) (j + 0),
              get' (i - 1) (j + 1),
              get' (i + 0) (j + 1),
              get' (i + 1) (j + 1),
              get' (i + 1) (j + 0),
              get' (i + 1) (j - 1),
              get' (i + 0) (j - 1)
            ]

    -- should instead do some map operation, but how do i zipwithIndex?
    -- this code is soo slow
    rows = length m
    cols = (length . head) m
    forLoop i j acc
      | i >= rows = acc
      | j >= cols = forLoop (i + 1) 0 acc
      | otherwise = forLoop i (j + 1) (acc + fromEnum (canBeAccessed i j))

-- removedAccessed :: [[Int]] -> [Int]
-- rewrite using mutable arrays
removedAccessed m = forLoop 0 0 []
  where
    get' i j = (get i >=> get j) m
    canBeAccessed' :: Int -> Int -> Bool
    canBeAccessed' i j =
      (< 4) . sum . fmap sum $
        [ get' (i - 1) (j - 1),
          get' (i - 1) (j + 0),
          get' (i - 1) (j + 1),
          get' (i + 0) (j + 1),
          get' (i + 1) (j + 1),
          get' (i + 1) (j + 0),
          get' (i + 1) (j - 1),
          get' (i + 0) (j - 1)
        ]

    rows = length m
    cols = (length . head) m
    nextState :: Int -> Int -> Int
    nextState i j
      | nth == 0 = 0
      | canBeAccessed' i j = 0
      | otherwise = nth
      where
        nth = m !! i !! j

    -- had to ask chatgpt for this, don't get why my version doesn't work, its literally the same
    toMatrix :: Int -> [a] -> [[a]]
    toMatrix _ [] = []
    toMatrix n _
      | n <= 0 = error "toMatrix: n must be positive"
    toMatrix n l =
      take n l : toMatrix n (drop n l)

    forLoop i j acc
      | i >= rows = toMatrix i acc
      | j >= cols = forLoop (i + 1) 0 acc
      | otherwise =
          forLoop i (j + 1) (acc ++ [nextState i j])

-- this actually took more then 2 minutes... compiled
-- supper should be embarrassed, skill issue hard
-- I don't know how to write real haskell code yet.
part2 :: [[Int]] -> Int
part2 m = part2' m 0
  where
    part2' m total =
      if calc == 0
        then total
        else part2' (removedAccessed m) (total + calc)
      where
        calc = part1 m

main :: IO ()
main = do
  content <- readFile "input.txt"
  let parsed = parseInput . words $ content
  putStrLn "Part 1"
  print (part1 parsed)
  putStrLn "Part 2"
  print (part2 parsed)
