#import "tufte.typ": *

#show: tufte.with(
    title: [An Example using Tufte],
    authors: (
        (
            name: "Name Lastname",
            organization: "Institute",
            email: "name.lastname@institute.com",
        ),
        (
            name: "Name Lastname",
            organization: "Institute",
            email: "name.lastname@institute.com",
        ),
        (
            name: "Name Lastname",
            organization: "Institute",
            email: "name.lastname@institute.com",
        ),
    ),
    font: "Palatino",
    mono-font: "FiraCode Nerd Font",
    abstract: lorem(60),
    date: none,
    // abstract: "",
)

= Introduction

#lorem(90)

$ cal(A) := { x , delta , epsilon in RR | x "is natural" } $

$
    sum_(k=0)^n k & = 1 + ... + n \
                  & = (n(n+1)) / 2
$



#lorem(30)
#note[ #lorem(20) `Dictionary<type> https://www.google.com` ]
jklkjf

#lorem(50)@Kitchenham2004

== Another

#lorem(80)
#note[ #lorem(14) `Dictionary<another_type> https://www.google.com` ]
#lorem(100)

=== #lorem(10)

#wideblock[#lorem(200)]

`Dictionary<Type>(WHAAAT)=>{ return; }`

=== Third level

#lorem(50)

= #lorem(5)

#lorem(50)#inline-review(color: green, [This is an inline-review])

+ #lorem(10)#side-review(color: red, [This is a side review])
    + #lorem(10)
+ #lorem(10)

- #lorem(10)
    - #lorem(10)
- #lorem(10)


#bibliography("bibliography.bib")
