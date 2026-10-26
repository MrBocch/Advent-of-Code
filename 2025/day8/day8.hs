import Data.Function 

splitWhere :: (a -> Bool) -> [a] -> ([a], [a])
splitWhere p xs = iter [] xs 
  where
    -- iter :: [a] -> [a] -> ([a], [a]) wont work unless comment type dec
    iter curr [] = (reverse curr, []) 

    iter curr (x:xs)
      | p x       = iter (x:curr) xs 
      | otherwise = (reverse curr, xs)

type Point = (Int, Int, Int)

parseInput :: String -> [Point]
parseInput = map process . lines 
  where
    splitComma = splitWhere (/=',')
    process line = (read a, read b, read c)
      where
        (a, rest)  = splitComma line
        (b, rest') = splitComma rest
        (c, _)     = splitComma rest'




        
main :: IO()
main = do
  input <- readFile "input.txt"
  let points = parseInput input 
  print points  
