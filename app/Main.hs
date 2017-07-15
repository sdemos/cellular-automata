module Main where

import Universe
import Automata

uinit = Universe (repeat (Cell False)) (Cell True) (repeat (Cell False))

getAutomata :: Int -> Automata
getAutomata n = Automata {universe = uinit, rule = getRule n, width = 41, height = 20}

showAutomata  = putStr . show . getAutomata

main = showAutomata 30
