main :: IO()

main = do
    putStrLn "PDA {a^i b^j c^k | i, j, k >= 0 and i = j or j = k}"
    putStrLn "Input tape:"
    x <- getLine
    let input = x ++ "-"

    putStrLn (q0 input)

-- ______ = (STATE STACK INPUT)


q0 input = q1 "$" [head input] (drop 1 input)

q1 stack "a" input = q1 ("x" ++ stack) [head input] (drop 1 input)
q1 stack "b" input =
    if q4 stack [head input] (drop 1 input) /= "Accepted @ q6"
        then
            if [head stack] == "x"
                then q2 (drop 1 stack) [head input] (drop 1 input)
                else "Rejected @ q1"
        else "Accepted @ q6"
q1 stack "-" input = "Rejected @ q1"
q1 stack invalidChar input = "Rejected @ q1"

q2 stack "b" input =
    if[head stack] == "x"
            then q2 (drop 1 stack) [head input] (drop 1 input)
            else "Rejected @ q2"
q2 stack "c" input = q3 stack [head input] (drop 1 input)
q2 stack "-" input = "Rejected @ q2"
q2 stack invalidChar input = "Rejected @ q2"

q3 stack "c" input = q3 stack [head input] (drop 1 input)
q3 stack "-" input = q6 stack

q4 stack "b" input = q4 stack [head input] (drop 1 input)
q4 stack "c" input =
    if[head stack] == "x"
        then q5 (drop 1 stack) [head input] (drop 1 input)
        else "Rejected @ q4"
q4 stack "-" input = "Rejected @ q4"
q4 stack invalidChar input = "Rejected @ q4"

q5 stack "c" input =
    if([head stack] == "x")
        then (q5 (drop 1 stack) [head input] (drop 1 input))
        else "Rejected @ q5"
q5 stack "-" input = (q6 stack)
q5 stack invalidChar input = "Rejected @ q5"

q6 stack =
    if([head stack] == "$")
        then "Accepted @ q6"
        else "Rejected @ q6"