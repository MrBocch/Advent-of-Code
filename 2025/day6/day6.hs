import Data.List (transpose)

part1 :: Num a => [((a -> a -> a), [a])] -> a
part1 input = sum $ map f1 input

f1 :: ((a -> a -> a), [a]) -> a
f1 inp = foldl1 (fst inp) (snd inp)

main :: IO ()
main = do
    input <- readFile "input.txt"
    let (r1:r2:r3:r4:ops) = map words . lines $ input
    let ops' = map (\s -> if s == "+" then (+) else (*)) .
               concatMap id $ ops
    let r1' = map (read :: String -> Integer) r1
    let r2' = map (read :: String -> Integer) r2
    let r3' = map (read :: String -> Integer) r3
    let r4' = map (read :: String -> Integer) r4

    putStrLn "Part 1:"
    print $ (part1 . zip ops' . transpose) [r1',r2',r3',r4']

    putStrLn "Part 2:"
    print $ sum $ part2 input


part2 inp = solver' (reverse . transpose . lines $ inp) [] []
    where
        solver' :: [String] -> [Integer] -> [Integer] -> [Integer]
        solver' [] _ acc = acc
        solver' (x:rest) carry acc
            | elem '+'     x = solver' rest [] (acc ++ [foldl1 (+) ((parse x):carry)])
            | elem '*'     x = solver' rest [] (acc ++ [foldl1 (*) ((parse x):carry)])
            | all (== ' ') x = solver' rest carry acc
            | otherwise      = solver' rest ((read x :: Integer):carry) acc
            where
                -- how do i combine predicates? mappend?
                parse x = if elem '+' x
                          then read (filter (/= '+') x) :: Integer
                          else read (filter (/= '*') x) :: Integer
