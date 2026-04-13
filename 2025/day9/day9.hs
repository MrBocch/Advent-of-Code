import Data.Bifunctor
-- split s p :: String -> Char -> (String, String)
split c s = (\(a,b) -> (a, tail b)) . break (== c) $ s

main :: IO ()
main = do
  contents <- readFile "input.txt"
  -- let proc = map (bimap (read :: String -> Int) (read :: String -> Int) . split ',') . lines $ contents
  let proc = map (bimap read read . split ',') . lines $ contents :: [(Int, Int)]
  print proc
