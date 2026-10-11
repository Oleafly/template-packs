#let config = yaml("../config.yaml")

#align(center, [
    #image("../util/assets/MQlogo.svg", width: 50%)
])

#v(24pt)

#align(center, text(24pt)[
    *#config.title*
])

#v(2em)

#align(center, text(14pt)[
        by
])

#align(center, text(18pt)[
    #config.author
])

#v(32pt)

#align(center, text(16pt)[
    _ A thesis submitted to Macquarie University for the degree of \ #config.degrees_candidate _
])

#v(32pt)

#align(center, text(16pt)[
    _ #config.faculty _
])

#align(center, text(16pt)[
    _ #config.department _
])

#v(32pt)

#align(center, text(16pt)[
    _ #config.month #config.year _
])

#pagebreak()

#v(50em)

#align(center)[
#sym.copyright #datetime.today().year() #config.author. All rights reserved.

Typeset in Typst #sys.version.
]

