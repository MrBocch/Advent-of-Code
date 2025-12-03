import Data.Text (Text, splitOn, pack, unpack)

input :: Text
input = pack "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

toRanges :: Text -> [Text]
toRanges = splitOn (pack ",") 

parseRange :: [Text] -> [[Integer]]
parseRange = map (range . (splitOn $ pack "-"))
  where
    range :: [Text] -> [Integer]
    range r = [(read . unpack $ head r) .. (read . unpack $ last r)]

splitInTwo :: String -> (String, String)
splitInTwo s = (take at s, drop at s)
  where
    at = length s `div` 2 :: Int 

isValidID :: Integer -> Bool
isValidID n
  | (odd . length . show) n = True
  | otherwise = (check . splitInTwo . show) n 
  where
    check :: (String, String) -> Bool
    check p = fst p /= snd p 

part1 = sum . filter (not . isValidID)  

-- kids look away.
isValid' :: Integer -> Bool
isValid' n = check (show n) (length $ show n)
  where
    -- why did i decide to write this????
    -- my code is so bad, i dont want to rewrite it.
    isAll c s = all (== c) s

    groupBy [] n = []
    groupBy  s n = [take n s] ++ groupBy (drop n s) n

    check :: String -> Int -> Bool 
    check s 1 = False
    check s 2 = isAll (Prelude.head s) s 
    check s 3 = isAll (Prelude.head s) s 
    -- should probably abstract this 
    check s 4 =  (isAll (Prelude.head s) s)
              || (isAll (head $ groupBy s 2) (groupBy s 2))

    check s 5 =  (isAll (Prelude.head s) s)

    check s 6 =  (isAll (Prelude.head s) s)
              || (isAll (head $ groupBy s 2) (groupBy s 2))
              || (isAll (head $ groupBy s 3) (groupBy s 3))
              
    check s 7 =  (isAll (Prelude.head s) s)

    check s 8 =  (isAll (Prelude.head s) s)
              || (isAll (head $ groupBy s 4) (groupBy s 4))
              || (isAll (head $ groupBy s 2) (groupBy s 2))

    check s 9 =  (isAll (Prelude.head s) s)
              || (isAll (head $ groupBy s 3) (groupBy s 3))

    check s 10 =  (isAll (Prelude.head s) s)
               || (isAll (head $ groupBy s 5) (groupBy s 5))
               || (isAll (head $ groupBy s 2) (groupBy s 2))

    check s 11 =  (isAll (Prelude.head s) s)

    check s 12 =  (isAll (Prelude.head s) s)
               || (isAll (head $ groupBy s 6) (groupBy s 6))
               || (isAll (head $ groupBy s 4) (groupBy s 4))
               || (isAll (head $ groupBy s 3) (groupBy s 3))
               || (isAll (head $ groupBy s 2) (groupBy s 2))

part2 = sum . filter isValid'  

main :: IO ()
main = do
  content <- readFile "input.txt"
  let intr = ((foldl (++) [] ) . parseRange . toRanges . pack) content
  putStrLn "Part 1"
  print (part1 intr)
  putStrLn "Part 2"
  print (part2 intr)
  
