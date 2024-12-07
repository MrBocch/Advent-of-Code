import System.IO
import Data.List (words)
import Data.Char (isDigit)

main :: IO ()
main = do
    -- open file
    content <- readFile "input.txt"
    -- split file "\n" list of strings
    let linesOfFile = lines content
    -- map strings "x: y w z" into (x, [y, w, z])
    let processed = map processString linesOfFile
    -- only valid operators
    let valid = filter solver processed
    -- sum x of valid operators
    let p1_ans = sum (map fst valid)
    putStrLn ("part1: " ++ show p1_ans)

    let valid = filter solver2 processed
    let p2_ans = sum (map fst valid)
    putStrLn ("part2: " ++ show p2_ans)


solver tuple = solver' (fst tuple) (head $ snd tuple) (tail $ snd tuple)

solver' target carry [] = if target == carry then True else False
solver' target carry (x:[]) = (solver' target (carry + x) []) ||
                              (solver' target (carry * x) [])

solver' target carry (x:xs) = if carry > target then False else
                (solver' target (carry + x) xs) ||
                (solver' target (carry * x) xs)

--part2, same function, now you just add the pipe op, with concats to numbers
solver2 tuple = solver2' (fst tuple) (head $ snd tuple) (tail $ snd tuple)

solver2' target carry [] = if target == carry then True else False
solver2' target carry (x:[]) = (solver2' target ((+) carry x) []) ||
                              (solver2' target ((*) carry x) []) ||
                              (solver2' target ((pipeOp) carry x) [])

solver2' target carry (x:xs) = if carry > target then False else
                (solver2' target ((+) carry x) xs) ||
                (solver2' target ((*) carry x) xs) ||
                (solver2' target ((pipeOp) carry x) xs)

pipeOp n1 n2 = read (show n1 ++ show n2) :: Int

processString :: String -> (Int, [Int])
processString input =
    let (firstPart, rest) = span (/= ':') input
        firstNumber = read firstPart :: Int
        numbers = map read (words (drop 2 rest))  -- Drop ": " and split
    in (firstNumber, numbers)
