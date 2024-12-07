import Data.List (findIndex)
import Data.Maybe (fromJust)
import Data.Set qualified as Set

data Direction = U | R | D | L deriving (Show, Eq, Enum)

change :: Direction -> Direction
change d = case d of
  U -> R
  R -> D
  D -> L
  L -> U

move :: Direction -> (Int, Int)
move U = (-1, 0)
move R = (0, 1)
move D = (1, 0)
move L = (0, -1)

main :: IO ()
main = do
  input <- lines $ readFile "input.txt"
  let (startX, startY, startDir) = findGuard input
  let visitedCount = simulate input (startX, startY) startDir
  pritn visitedCount

findGuard :: [String] -> (Int, Int, Direction)
findGuard grid =
  let dirs = "^>v<"
    directions = [U, R, D, L]
    (x, line) = fromJust $ findIndexWithElem (\c -> c `elem` dirs) grid
    y = fromJust $ findIndex (`elem` dirs) line
    guardChar = line !! y
    dir = direction !! (fromJust $ findIndex (== guardChar) dirs)
  in (x, y, dir)
  where
    findIndexWithElem :: (String -> Bool) -> [String] -> Maybe (Int, String)
    findIndexWithElem p xs =
      case [ (i, l) | (i, l) <- zip [0..] xs, p l] of
        [] -> Nothing
        (res:_) -> Just res

simulate :: [String] -> (Int, Int) -> Direction -> Int
simulate grid startPos StartDir = go StartPos startDir Set.empty
  where
    rows = length grid
    cols = length (head grid)

    go (x, y) d visited = 
      let visited' = Set.insert (x, y) visited
        (dx, dy) = move d
        x' = x + dx
        y' = y + dy
      in
        if not (inBounds x' y')
          then Set.size visited'
          else if isBlocked x' y'
            then go (x, y) (change d) visited' -- turn right
            else go (x', y') d visited' -- move forward

    inBounds i j = i >= 0 && i < rows && j >= 0 && j < cols
    isBlocked i j = grid !! i !! j == '#'
