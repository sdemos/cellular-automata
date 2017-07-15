module Main where

import Universe
import Automata

rule30 True True True = False
rule30 True True False = False
rule30 True False True = False
rule30 True False False = True
rule30 False True True = True
rule30 False True False = True
rule30 False False True = True
rule30 False False False = False

boolToCellRule :: (Bool -> Bool -> Bool -> Bool) -> Rule
boolToCellRule f = Rule (\(Cell a) (Cell b) (Cell c) -> Cell (f a b c))

uinit = Universe (repeat (Cell False)) (Cell True) (repeat (Cell False))

main = (putStr . show) (Automata {universe = uinit, rule = boolToCellRule rule30, width = 41, height = 20})
