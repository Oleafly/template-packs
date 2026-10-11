# Some sample R code

# To make vectors "x" "y" "year" and "names"
x <- c(2,1,7,9)
y <- c(9,7,6,2)
year <- 1990:1993
names <- c("Mark", "Chris", "Ryan", "Jacob")
# Accessing the 1st and last elements of y --
y[1]
y[length(y)]

# To make a list "person" --
person <- list(name="Bob", x=2, y=9, year=1999)
person
# Accessing things inside a list --
person$name
person$x