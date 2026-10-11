-- / Euler's totient function (for positive integers)

totient :: Int -> Integer
totient n = toInteger $ length $ filter (\ k -> gcd n k == 1) [1 .. n]

-- / sequential sum of totients

sum_totient :: [Int] -> Integer
sum_totient = sum . map totient

