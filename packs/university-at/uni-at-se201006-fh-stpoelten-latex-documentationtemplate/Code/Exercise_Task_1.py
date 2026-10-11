startNumber = int(input("Input the start Number: "))
if startNumber <= 1: 
    print("Value must be greater than 1! I will set it to 2 for you.")
    startNumber = 2
endNumber = int(input("Input the end Number: "))
print("Given inputs: {} {}".format(startNumber, endNumber))

# Berechnen von Primzahlen:
while( startNumber < endNumber ):
    j = 2
    while( j <= ( startNumber / j ) ):
        if not( startNumber % j ): 
                break
        j = j + 1
    if ( j > startNumber / j ):
        print("{} is a prime number".format(startNumber))
    startNumber = startNumber + 1
else:
    print("Ermittlung abgeschlossen!")
