// tubs-typst is a template (theme) that wraps `polylux` typst package. Please
// look at `polylux` documentation to learn more: https://polylux.dev/book/

// One way to install `tubs-typst` is to use it as a submodule.
// #import "tubs-typst/beamer/lib.typ": * (adjust according to the location)
#import "./lib.typ": *

// Setup the template
#show: setup.with(title: "Example Slides", subtitle: lorem(5), author: "Max Mustermann")

#section("Erster Teil")

#frame("Test")[
  Hello, world!
]

#section("Zweiter Teil")

#frame([Test 2])[
  #only("1")[
    - Animations can be done using `only` and `uncover`
  ]
  #only("2-")[
    - The page number does not increase during animation steps
  ]
  #uncover("3")[
    #sym.arrow.r.double #lorem(6)
  ]
]

#frame([Backup slide], active: false)[
  - Notice, that when the `active` flag is set to `false`, the page number is not incremented
]
