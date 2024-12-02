parseLine :: String -> [Int]
parseLine = map read . words

validDiffs :: [Int] -> Bool
validDiffs xs =
  let diffs = zipWith (-) (tail xs) xs
   in all (\d -> abs d >= 1 && abs d <= 3) diffs

isMonotonic :: [Int] -> Bool
isMonotonic xs =
  let diffs = zipWith (-) (tail xs) xs
   in all (> 0) diffs || all (< 0) diffs

isValidSeq :: [Int] -> Bool
isValidSeq xs = validDiffs xs && isMonotonic xs

removeOneNumber :: [Int] -> [[Int]]
removeOneNumber xs = [take i xs ++ drop (i + 1) xs | i <- [0 .. length xs - 1]]

canBeMadeValid :: [Int] -> Bool
canBeMadeValid
  xs =
    isValidSeq
      xs
      || any isValidSeq (removeOneNumber xs)

boolToInt :: Bool -> Int
boolToInt True = 1
boolToInt False = 0

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let sequences = map parseLine $ lines contents
      part1 = sum $ map (boolToInt . isValidSeq) sequences
      part2 = sum $ map (boolToInt . canBeMadeValid) sequences
  putStrLn $ "result -> " ++ show part1
  putStrLn $ "result 2 -> " ++ show part2
