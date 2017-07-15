# Cellular Automata

You can do some cool stuff with automata. Right now, this library implements
one-dimensional cellular automata in a general way, allowing you to provide your
own starting universe and any of the 255 possible rules. 

There are only 255 possible rules when you have a one dimensional cellular
automata where the rule can only look at it's nearest neighbors. You can get any
of the rules by using `getRule n` where `n` is the rule number in decimal. You
can use that to construct your automata. The width and height refer to the
output. The show instance will automatically apply these constraint and return a
string with newlines.

If you are in ghci, you can refer to the `showAutomata` function in the main
module, and then just specify a rule for that automata to use. 
