
lineToList :: String -> [Int]
lineToList s = f s []
  where
    f :: String -> [Int] -> [Int]
    f "" carr = carr
    f (x:xs) carr = f xs (carr ++ [read [x] :: Int])

-- pattern matching is so hot 
findDigit :: [Int] -> (Int, Int, Int)
findDigit = foldl maxWindx (0, 0, 0)
  where
    maxWindx (m, idx, currIdx) i = if i > m 
                                   then (i, currIdx, currIdx+1)
                                   else (m, idx, currIdx+1)

findJoltage :: [Int] -> Int
findJoltage powers = 
  -- hot 
  let (dig1, idx1, _) = (findDigit . init) powers
      (dig2, _, _)    = (findDigit . drop (idx1+1)) powers
  in
    (dig1 *10) + dig2 

main :: IO ()
main = do
  content <- readFile "input.txt"
  putStrLn "Part 1"
  print (sum . map (findJoltage . lineToList) $ words content)
  putStrLn "Part 2"
