module Automata where

import Comonad
import Universe

-- So, it's difficult to display an infinite field of cells
-- and you don't really need to to get the gist of the automata anyway
-- so instead, we should have a datatype which describes the
-- height and width of the output, the universe to act on, and the rule
-- For one dimensional automata, width is what we pass to toList
-- and height is the number of iterations

newtype Cell = Cell Bool

instance Show Cell where
  show (Cell True)  = "█"
  show (Cell False) = " "

newtype Rule = Rule (Cell -> Cell -> Cell -> Cell)

toURule :: Rule -> Universe Cell -> Cell
toURule (Rule f) (Universe (a:_) b (c:_)) = f a b c

data Automata = Automata
  { universe :: Universe Cell
  , rule     :: Rule
  , width    :: Int
  , height   :: Int
  }

instance Show Automata where
  show a = (unlines . map (>>= show) . field) (universe a)
    where l = (width a) `div` 2
          r = (width a) - l
          field :: Universe Cell -> [[Cell]]
          field = map (toList (-l) r) . take (height a) . iterate (=>> toURule (rule a))

-- so it turns out one dimensional automata are a little limited
-- there are only 255 possible rules if you can only look at the nearest
-- neighbors
-- lets allow you to choose any of those rules and have them auto generated
-- instead of having to define them yourself
-- then we can consider more complex automata

getRule :: Int -> Rule
getRule n = Rule (\(Cell a) (Cell b) (Cell c) -> Cell (norm8 (toBin n) !! fromBin [a,b,c]))

norm8 :: [Bool] -> [Bool]
norm8 n = if l < 0 then drop (abs l) n else take l (repeat False) ++ n
  where l = 8 - length n

fromBin :: [Bool] -> Int
fromBin = foldl (\acc x -> acc * 2 + if x then 0 else 1) 0

toBin :: Int -> [Bool]
toBin = reverse . helper
  where helper 0 = []
        helper n | n `mod` 2 == 1 = True  : helper (n `div` 2)
        helper n | n `mod` 2 == 0 = False : helper (n `div` 2)

-- functions to help viewing of automata

uinit = Universe (repeat (Cell False)) (Cell True) (repeat (Cell False))

getAutomata :: Int -> Int -> Int -> Automata
getAutomata n w h = Automata {universe = uinit, rule = getRule n, width = w, height = h}
