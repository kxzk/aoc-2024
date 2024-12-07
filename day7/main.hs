import Control.Mondad (guard)
import Data.Char (isDigit)
import Data.List (foldl')
import System.IO (readFile)

data Op = Add | Mul | Concat deriving (Show, Eq)

applyOp :: Op -> Int -> Int -> Int
applyOp Add x y = x + y
applyOp Mul x y = x * y
applyOp Concat x y = read (show x ++ show y)

ops :: [Op]
ops = [Add, Mul, Concat]

evaluate :: [Int] -> [Op] -> Int
evaluate (x : xs) os = foldl' (\acc (op, n) -> applyOp op acc n) x (zip os xs)
evaluate _ _ = error "no numberes to evaluate"
