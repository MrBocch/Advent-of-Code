import Data.Text

input :: Text
input = pack "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

toRanges :: Text -> [Text]
toRanges = splitOn (pack ",") 

parseRange :: [Text] -> [[Integer]]
parseRange = Prelude.map (range . (splitOn $ pack "-"))
  where
    range :: [Text] -> [Integer]
    range r = [(read . unpack $ Prelude.head r) .. (read . unpack $ Prelude.last r)]

splitInTwo :: String -> (String, String)
splitInTwo s = (Prelude.take at s, Prelude.drop at s)
  where
    at = Prelude.length s `div` 2 :: Int 

isValidID :: Integer -> Bool
isValidID n
  | (odd . Prelude.length . show) n = Prelude.True
  | otherwise = (check . splitInTwo . show) n 
  where
    check :: (String, String) -> Bool
    check p = fst p /= snd p 

part1 xs = sum $ Prelude.filter (not . isValidID) xs 

main :: IO ()
main = do
  content <- readFile "input.txt"
  let intr = ((Prelude.foldl (++) [] ) . parseRange . toRanges . pack) content
  putStrLn "Part 1"
  print (part1 intr)
  putStrLn "Part 2"
  
