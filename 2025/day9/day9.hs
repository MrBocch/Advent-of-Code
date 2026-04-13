{-
splitOn :: String -> Char -> (String, String)
splitOn s c = splitOn' s ""
    where
        splitOn' :: String -> String -> (String, String)
        splitOn' (x:xs) acc
          | x == c    = (reverse acc, xs)
          | otherwise = splitOn' xs (x:acc)

Idk why chatgpt now decides to tell me about break (== c) or span
One would think, if you ask for the equivalent of ruby's s.split(c)
but no.
-}

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let proc = map ((\(a,b) -> (read a :: Int, read (tail b) :: Int)) . break (== ','))
             . lines $ contents
  print proc
