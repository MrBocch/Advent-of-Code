Now that i read a little bit of "Category Theory for Programmers"
im applying function composition everywhere I can.

I have very little experience with haskell, but I really like
it for simple problems like these.

should probably rewrite it to use
```
let
 n = read $ tail i :: Integer (i is not defined here)
in 
 f acc i
```

(something like this)
