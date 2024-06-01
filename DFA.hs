main :: IO()

main = do
    putStrLn "DFA {w | w  contains at least two 0's and at most one 1}"
    putStrLn "Input tape:"
    x <- getLine
    let input = x ++ "-"

    putStrLn (q0 [head input] (drop 1 input))

q0 "0" input = q3 [head input] (drop 1 input)
q0 "1" input = q1 [head input] (drop 1 input)
q0 "-" input = "Rejected @ q0"

q1 "0" input = q4 [head input] (drop 1 input)
q1 "1" input = q2 [head input] (drop 1 input)
q1 "-" input = "Rejected @ q1"

q2 "0" input = q2 [head input] (drop 1 input)
q2 "1" input = q2 [head input] (drop 1 input)
q2 "-" input = "Rejected @ q2"

q3 "0" input = q5 [head input] (drop 1 input)
q3 "1" input = q4 [head input] (drop 1 input)
q3 "-" input = "Rejected @ q3"

q4 "0" input = q6 [head input] (drop 1 input)
q4 "1" input = q2 [head input] (drop 1 input)
q4 "-" input = "Rejected @ q4"

q5 "0" input = q5 [head input] (drop 1 input)
q5 "1" input = q6 [head input] (drop 1 input)
q5 "-" input = "Accepted @ q5"

q6 "0" input = q6 [head input] (drop 1 input)
q6 "1" input = q2 [head input] (drop 1 input)
q6 "-" input = "Accepted @ q6"