#!/usr/bin/env stack
-- stack script --resolver lts-20.23 --package heap --package containers

import Data.Heap (Heap)
import Data.Heap qualified as H
import Data.Map.Strict qualified as Map
import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)

data TwoHeap = TwoHeap
  { heap1 :: !(H.MinHeap Int),
    heap2 :: !(H.MinHeap Int)
  }
  deriving (Show)

parseLine :: String -> Maybe (Int, Int)
parseLine line =
  case words line of
    [n1, n2] -> do
      num1 <- readMaybe n1
      num2 <- readMaybe n2
      return (num1, num2)
    _ -> Nothing

addToHeaps :: (Int, Int) -> TwoHeap -> TwoHeap
addToHeaps (x, y) heaps =
  TwoHeap {heap1 = H.insert x (heap1 heaps), heap2 = H.insert y (heap2 heaps)}

processHeaps :: TwoHeap -> IO ()
processHeaps heaps = loop 0 (heap1 heaps) (heap2 heaps)
  where
    loop acc h1 h2 = case (H.view h1, H.view h2) of
      (Just (min1, rest1), Just (min2, rest2)) -> do
        let diff = abs (min1 - min2)
        let newAcc = acc + diff
        loop newAcc rest1 rest2
      _ -> putStrLn $ "result -> " ++ show acc

similarityScore :: (Ord a, Num a) => [a] -> [a] -> a
similarityScore listA listB =
  let freqMap = Map.fromListWith (+) [(x, 1) | x <- listB]
      getCount x = Map.findWithDefault 0 x freqMap
      products = [x * getCount x | x <- listA]
   in sum products

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let records = mapMaybe parseLine (lines contents)
  let initHeaps = TwoHeap H.empty H.empty
  let finalHeaps = foldr addToHeaps initHeaps records
  processHeaps finalHeaps

  let heap1Lst = H.toList (heap1 finalHeaps)
  let heap2Lst = H.toList (heap2 finalHeaps)

  let simScore = similarityScore heap1Lst heap2Lst
  putStrLn $ "result -> " ++ show simScore
