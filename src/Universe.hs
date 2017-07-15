module Universe where

import Control.Comonad

data Universe x = Universe [x] x [x]

left :: Universe x -> Universe x
left (Universe (a:as) b c) = Universe as a (b:c)

right :: Universe x -> Universe x
right (Universe a b (c:cs)) = Universe (b:a) c cs

instance Functor Universe where
  fmap f (Universe a b c) = Universe (fmap f a) (f b) (fmap f c)

instance Comonad Universe where
  duplicate a = Universe (tail $ iterate left a) a (tail $ iterate right a)
  extract (Universe _ b _) = b

shift :: Int -> Universe a -> Universe a
shift i u = (iterate (if i<0 then left else right) u) !! abs i

toList :: Int -> Int -> Universe a -> [a]
toList i j u = take (j-i) $ half $ shift i u
  where half (Universe _ b c) = [b] ++ c
