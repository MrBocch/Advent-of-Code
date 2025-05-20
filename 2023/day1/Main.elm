module Main exposing (..)

toLines : String -> List String
toLines str = str |> String.split "\n"

concatChars : Char -> Char -> String
concatChars c1 c2 =
    String.fromChar c1 ++ String.fromChar c2

-- List.head & List.tail, should not return a Maybe(a) This is so dumb
unwrap : Maybe Char -> Char
unwrap n =
    case n of
        Just c -> c
        _ -> '_' -- how do i do this properly?

last2 : List Char -> Int
last2 chars =
    let
        n1 = (List.head chars) |> unwrap -- we know it there always be atleast 1
        n2 =
            if List.length chars == 1 then
                (List.head chars) |> unwrap
            else
                -- how does elm not have a List.last .... really
                (List.reverse chars |> List.head ) |> unwrap

        sn = concatChars n1 n2
        n = String.toInt sn
    in
    case n of
        Just num -> num
        _ -> -1

solver1 str = str
    |> toLines
    |> List.map (\s -> String.toList s)
    |> List.map (\l -> l |> List.filter Char.isDigit)
    |> List.map last2
    |> List.sum

solver2 str = str
    |> toLines
    -- should probably be refactored
    -- i dont remember that case where oneight -> 18
    --                                 eightwo -> 82
    |> List.map (\s -> String.replace "one"   "o1e" s)
    |> List.map (\s -> String.replace "two"   "t2o" s)
    |> List.map (\s -> String.replace "three" "t3e" s)
    |> List.map (\s -> String.replace "four"  "f4r" s)
    |> List.map (\s -> String.replace "five"  "f5e" s)
    |> List.map (\s -> String.replace "six"   "s6x" s)
    |> List.map (\s -> String.replace "seven" "s7n" s)
    |> List.map (\s -> String.replace "eight" "e8t" s)
    |> List.map (\s -> String.replace "nine"  "n9e" s)
    |> List.map (\s -> String.toList s)
    |> List.map (\l -> l |> List.filter Char.isDigit)
    |> List.map last2
    |> List.sum

part1 =
    "Part 1: " ++ String.fromInt (solver1 input)

part2 =
    "Part 2: " ++ String.fromInt (solver2 input)

-- dont think you can import directly from a file
-- how you can with other FP languages
-- input : String
-- input = """3fiveone ..........

-- I wont track the entire input
-- inside the elm file, it will appear as if
-- the entire repo was written in Elm because
-- github is counting the LOC, and not the amount of files
