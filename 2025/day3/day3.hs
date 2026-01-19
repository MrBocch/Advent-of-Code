lineToList :: String -> [Integer]
lineToList s = f s []
  where
    f :: String -> [Integer] -> [Integer]
    f "" carr = carr
    f (x:xs) carr = f xs (carr ++ [read [x] :: Integer])

-- pattern matching is so hot
findDigit :: [Integer] -> (Integer, Int, Int)
findDigit = foldl maxWindx (0, 0, 0)
  where
    maxWindx (m, idx, currIdx) i = if i > m
                                   then (i, currIdx, currIdx+1)
                                   else (m, idx, currIdx+1)

findJoltage :: [Integer] -> Integer
findJoltage powers =
  -- hot
  let (dig1, idx1, _) = (findDigit . init) powers
      (dig2, _, _)    = (findDigit . drop (idx1+1)) powers
  in
    (dig1 *10) + dig2


selfCompose f 1 = f
selfCompose f n = f . selfCompose f (n-1)

-- this is hilariously bad
-- should i abstract over (findDigit . (selfCompose f x) . drop (x1 + list))
-- but that would just be some indirection bs imho
findJoltage' :: [Integer] -> Integer
findJoltage' powers =
  let (dig1, idx1, _)   = (findDigit . (selfCompose init 11)) powers
      (dig2, idx2, _)   = (findDigit . (selfCompose init 10) . (drop (1 + idx1))) powers
      (dig3, idx3, _)   = (findDigit . (selfCompose init 9)  . (drop (2 + idx1+idx2))) powers
      (dig4, idx4, _)   = (findDigit . (selfCompose init 8)  . (drop (3 + idx1+idx2+idx3))) powers
      (dig5, idx5, _)   = (findDigit . (selfCompose init 7)  . (drop (4 + idx1+idx2+idx3+idx4))) powers
      (dig6, idx6, _)   = (findDigit . (selfCompose init 6)  . (drop (5 + idx1+idx2+idx3+idx4+idx5))) powers
      (dig7, idx7, _)   = (findDigit . (selfCompose init 5)  . (drop (6 + idx1+idx2+idx3+idx4+idx5+idx6))) powers
      (dig8, idx8, _)   = (findDigit . (selfCompose init 4)  . (drop (7 + idx1+idx2+idx3+idx4+idx5+idx6+idx7))) powers
      (dig9, idx9, _)   = (findDigit . (selfCompose init 3)  . (drop (8 + idx1+idx2+idx3+idx4+idx5+idx6+idx7+idx8))) powers
      (dig10, idx10, _) = (findDigit . (selfCompose init 2)  . (drop (9 + idx1+idx2+idx3+idx4+idx5+idx6+idx7+idx8+idx9))) powers
      (dig11, idx11, _) = (findDigit . (selfCompose init 1)  . (drop (10 + idx1+idx2+idx3+idx4+idx5+idx6+idx7+idx8+idx9+idx10))) powers
      (dig12, _, _)     = (findDigit .                         (drop (11 + idx1+idx2+idx3+idx4+idx5+idx6+idx7+idx8+idx9+idx10+idx11))) powers
  in
  ((read :: String -> Integer) . foldl1 (++) . map show) [dig1, dig2, dig3, dig4, dig5, dig6, dig7, dig8, dig9, dig10, dig11, dig12]


main :: IO ()
main = do
  content <- readFile "input.txt"
  putStrLn "Part 1"
  print (sum . map (findJoltage . lineToList) $ words content)
  putStrLn "Part 2"
  print (sum . map (findJoltage' . lineToList) $ words content)




{- Did not fully think this through before realizing this
   idea was incorrect.
   print (map (tally M.empty . take 12 . reverse . sort . lineToList) $ words content)
tally :: M.Map Int Int -> [Int] -> M.Map Int Int
tally m [] = m
tally m (x:xs) = if M.member x m
                 then tally (M.adjust (+1) x m) xs
                 else tally (M.insert x 1 m) xs
-}
