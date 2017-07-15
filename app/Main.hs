module Main where

import Automata

showAutomata n w h = putStr (show (getAutomata n w h))

main = showAutomata 30 41 20
