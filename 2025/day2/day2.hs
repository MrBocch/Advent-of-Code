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

part1 xs = sum $ filter (not . isValidID) xs 

isValid' :: Integer -> Bool
isValid' n = check (show n) (length $ show n)
  where
    isAll c s = all (== c) s
    check :: String -> Int -> Bool 
    check s 1 = True 
    check s 2 = isAll (Prelude.head s) s 
    check s 3 = isAll (Prelude.head s) s 


main :: IO ()
main = do
  content <- readFile "input.txt"
  let intr = ((foldl (++) [] ) . parseRange . toRanges . pack) content
  putStrLn "Part 1"
  print (part1 intr)
  putStrLn "Part 2"
  
