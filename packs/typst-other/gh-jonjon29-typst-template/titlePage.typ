#import "variables.typ": *

#align(center + top)[
    Hochschule Fulda \
    University of Applied Science
    #image("./assets/images/hs-fulda_logo_rund_gruen-schwarz_keinhintergrund_keineschutzzone_300ppi.png", height: 5cm)
]

#align(center + horizon)[
    #set text(1.5em)
    #text(24pt, weight: "bold")[
        #{ shortTitle }
    ] \
    \
    #par(leading: 1em)[
    #text(weight: "bold")[
        #{ longTitle }
        ]
    ]
    \
    \
    Autor: \
    #{ author } \
    \
    #text(18pt)[ Praxisorientierte Fallstudie ] \
    im Studiengang: Angewandte Informatik
]

#align(center + bottom)[
    Einreichng: #{ datum }
]
