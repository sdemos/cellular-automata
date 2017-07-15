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
