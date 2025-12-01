# The input as one big string
Input ← &rs ∞ &fo "input.txt"

# must split eliminate the '\n', plus the " ", just straight up numbers
# then just take the values.
&p ↯ ∞_5 ▽ ⊸≠@\n Input
&p ▽ ⊸≠@\n Input

# could probably use a combinator here.
▽ ⊸≠@ ▽ ⊸≠@\n

# filter both, and shaped it
&p↯ ∞_5 ▽ ⊸≠@ ▽ ⊸≠@\n Input

