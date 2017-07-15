module Automata where

import Comonad
import Universe


-- I think this is what this rule produces
-- ___ = ___
-- __# = __#
-- _#_ = _#_
-- _## = _##
-- #__ = ##_
-- #_# = ###
-- ##_ = #__
-- ### = #_#
--triangle (Universe (a:_) b (c:_)) = not (a && b && not c || (a==b))
triangle a b c = not (a && b && not c || (a==b))

-- in binary order
-- 1 0 0 1 0 0 1 0
scarf False False False = True
scarf False False True = False
scarf False True False = False
scarf False True True = True
scarf True False False = False
scarf True False True = False
scarf True True False = True
scarf True True True = False

toURule :: (a -> a -> a -> a) -> Universe a -> a
toURule rule (Universe (a:_) b (c:_)) = rule a b c

test = let u = Universe (repeat False) True (repeat False)
        in putStr $
           unlines $
           take 20 $
           map (map (\x -> if x then '█' else ' ') . toList (-20) 20) $
           iterate (=>> toURule scarf) u
