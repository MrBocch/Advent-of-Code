input = words "L68 L30 R48 L5 R60 L55 L1 L99 R14 L82"
-- input = words "L1000"

-- suprised it Prelude does not include a count built 

part1 xs = length . filter (== 0) $ scanl f 50 xs 
  where
    f acc i = if head i == 'R' then
                (acc + (read $ tail i :: Integer)) `mod` 100
              else
                (acc - (read $ tail i :: Integer)) `mod` 100

part2 xs = sum . map (abs . snd) $ scanl f (50, 0) xs 
  where
    f acc i = if head i == 'R' then
                ((fst acc + (read $ tail i :: Integer)) `mod` 100
                ,(fst acc + (read $ tail i :: Integer)) `div` 100)
              else
                ((fst acc - (read $ tail i :: Integer)) `mod` 100
                ,(fst acc - (read $ tail i :: Integer)) `div` 100)

main :: IO ()
main = do
  content <- readFile "input.txt"
  let ans1 = part1 $ words content
  let ans2 = part2 $ words content

  putStrLn "Part 1"
  print ans1
  putStrLn "Part 2"
  print ans2
