def euclids_algorithm(a, b):  #  required b > a
        r = n % m
        while r != 0: 
            a = b 
            b = r 
            r = a % b 
        return b 
    # Example: print(euclids_algorithm(8,12))