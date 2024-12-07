import Data.Maybe (fromJust, listToMaybe)

findGuard :: [[String]] -> Maybe (Int, Int)
findGuard grid =
  listToMaybe
    [ (rowIndex, colIndex)
      | (rowIndex, row) <- zip [0 ..] grid,
        (colIndex, cell) <- zip [0 ..] row,
        cell /= "." && cell /= "#"
    ]

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let linesOfFile = lines contents
  let charCells = map (map (: [])) linesOfFile
  let (guardX, guardY) = fromJust $ findGuard charCells

  print (guardX, guardY)
