
-- / sequential Fibonacci 

fib :: Int -> Integer
fib n | n <= 1    = 1
      | otherwise = fib (n-1) + fib (n-2)


-- / parallel Fibonacci; shared memory

par_fib :: Int -> Int -> Par Integer
par_fib seqThreshold n
  | n <= k    = force $ fib n
  | otherwise = do v <- new
                   let job = par_fib seqThreshold (n - 1) >>=
                             force >>=
                             put v
                   fork job
                   y <- par_fib seqThreshold (n - 2)
                   x <- get v
                   force $ x + y
  where k = max 1 seqThreshold

