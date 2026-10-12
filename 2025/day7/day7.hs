{-# LANGUAGE PartialTypeSignatures #-}
import Data.Array 

import qualified Data.Set as Set
import Data.Set (Set)

type Maze = Array Int (Array Int Char)

mazeToArray :: [String] -> Maze
mazeToArray maze = listArray (0, length maze - 1) rows
    where
        rows = map toRow maze
        toRow s = listArray (0, length s - 1) s

initialRain :: Maze -> (Int, Int)
initialRain maze = iter 0
    where
        len = snd $ bounds maze 
        iter :: Int -> (Int, Int)
        iter j 
            | j == len              = undefined 
            | (maze ! 0) ! j == 'S' = (1, j)
            | otherwise             = iter (j+1) 

countSplits :: Maze -> Int
countSplits m = iter Set.empty [initialRain m] 0 
    where
        (_, rows) = bounds m 
        (_, cols) = bounds (m ! 0)
        look i j = m ! i ! j 

        legalNode :: (Int, Int) -> Bool
        legalNode (i, j) = j >= 0 && j+1 <= cols &&
                           i >= 0 && i+1 <= rows

        iter :: Set (Int, Int) -> [(Int, Int)] -> Int -> Int  
        iter _     []           splits = splits
        iter seen ((i,j):nodes) splits
            | Set.member (i,j) seen = iter seen nodes splits
            | not $ legalNode (i, j)= iter seen nodes splits 
            | look (i+1) j == '.'   = iter seen' ((i+1,j):nodes) splits
            | otherwise             = iter seen' nodes' (splits+1)
                where
                    seen' :: Set (Int, Int)
                    seen' = Set.insert (i, j) seen

                    n = [(i+1, j-1), (i+1, j+1)]
                    nodes' = filter legalNode n ++ nodes 


-- this is likely too slow.
-- timeLines :: Maze -> Int  
timeLines m = iter [] [initialRain m] 
    where
        (_, rows) = bounds m 
        (_, cols) = bounds (m ! 0)
        look i j = m ! i ! j 

        legalNode :: (Int, Int) -> Bool
        legalNode (i, j) = j >= 0 && j+1 <= cols &&
                           i >= 0 && i+1 <= rows

        iter :: [(Int, Int)] -> [(Int, Int)] -> _
        iter assoc [] 
            -- the culprit 
            -- would it be fast enough to only keep the latest nodes right? 
            -- haven't fully thought it out tbh.
            | any legalNode assoc = iter [] assoc
            | otherwise           = assoc 

        iter assoc ((i,j):nodes)
            | not $ legalNode (i,j) = iter ((i,j):assoc) nodes
            | look (i+1) j == '.'   = iter ((i+1,j):assoc) nodes 
            | look (i+1) j == '^'   = iter assoc' nodes
            -- | otherwise             = iter assoc' nodes 
                where
                    assoc' = (i+1,j-1):(i+1,j+1):assoc

                       

main :: IO ()
main = do
    input <- readFile "input.txt"
    let maze = mazeToArray . lines $ input 
    print $ countSplits maze 
    print $ length $ timeLines maze 

