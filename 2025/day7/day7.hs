{-# LANGUAGE PartialTypeSignatures #-}
import Data.Function
import Data.Array

import qualified Data.Set as Set
import Data.Set (Set)

import qualified Data.Map as Map
import Data.Map (Map)

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
        legalNode (i, j) = j >= 0 && j <= cols &&
                           i >= 0 && i <= rows

        iter :: Set (Int, Int) -> [(Int, Int)] -> Int -> Int
        iter _     []           splits = splits
        iter seen ((i,j):nodes) splits
            | Set.member (i,j) seen    = iter seen nodes splits
            | not $ legalNode (i+1, j) = iter seen nodes splits
            | look (i+1) j == '.'      = iter seen' ((i+1,j):nodes) splits
            | otherwise                = iter seen' nodes' (splits+1)
                where
                    seen' :: Set (Int, Int)
                    seen' = Set.insert (i, j) seen

                    n = [(i+1, j-1), (i+1, j+1)]
                    nodes' = filter legalNode n ++ nodes

timeLines :: Maze -> Int
timeLines m = bfs 1 [initNode] 
            & filter legalNode  -- I dont like filtering here because it means were are doing extra work on nodes that aren't legal.
            & map snd
            & sum               -- having BigInt has saved me without me knowing so many times
    where
        initNode :: ((Int, Int), Int)
        initNode = (initialRain m, 1)

        (_, rows) = bounds m
        (_, cols) = bounds (m ! 0)

        look :: Int -> Int -> Char 
        look i j = m ! i ! j

        legal :: Int -> Int -> Bool
        legal i j = j >= 0 && j <= cols && i >= 0 && i <= rows

        legalNode ((i, j), _) = legal i j

        bfs :: Int -> [((Int,Int), Int)] -> [((Int, Int), Int)]
        bfs lvl nodes  
            | lvl == rows = nodes 
            | otherwise   = iter Map.empty nodes 
                where
                    iter :: Map (Int, Int) Int -> [((Int, Int), Int)] -> [((Int, Int), Int)]
                    iter mp [] = bfs (lvl+1) (Map.toList mp)

                    iter mp (((i,j), v):nodes)
                        | not $ legal (i+1) j = iter mp nodes 
                        | look (i+1) j == '.' = iter unsplitMP nodes 
                        | otherwise           = iter splitMP nodes 
                            where
                                unsplitMP = Map.insertWith (+) (i+1, j) v mp

                                left = (i+1, j-1)
                                right = (i+1, j+1)

                                splitMP = Map.insertWith (+) left v mp
                                        & Map.insertWith (+) right v 


main :: IO ()
main = do
    input <- readFile "input.txt"
    let maze = mazeToArray . lines $ input
    print $ countSplits maze
    print $ timeLines maze

