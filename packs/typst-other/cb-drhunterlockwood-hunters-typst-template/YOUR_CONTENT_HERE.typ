/******************
Here's a sample document to illustrate my template.

Just import the template and then let er rip.
******************/
#import "template/hunter-typst-template.typ":*

#let title = "Insert Title Here" // Replace with your title
#let author = "Dr. Hunter Thompson Lockwood"

#show: doc => htl(
  doc, 
  draft: true, // Change to `false` to remove "Do Not Cite"
  title: title,
  author,
)

#abstract(title, author)[
  This is a _minimal_ template for my writing. It is designed to show a relatively
  stripped down version that is easier to just start in on.
]

= Using the `leipzig-glossing` Package

#dropcap[The `leipzig-glossing` package is a little bit brittle, and the comma requirements are exacting. Still, it produces pretty useful output, almost exactly like my pre-existing citation templates I've used elsewhere, as long as I add a few extra lines. Note that `additional-lines` *always* come before the translation line, which is treated as the last line of the gloss no matter what.]

#numbered-example(
  (
    source:([niwelaapinti],),
    transliteration: ([ni-wel+aapinti],),
    morphemes: ([#1-arrange+bow],),
    additional-lines: (
      (['I string a bow' ],),
      ([Largillier (385-40-1)],),
    ),
    translation: [#orth("Ni8erapinti") #orth("j'accomode mon arc, il es prest, je bande mon arc le plie pour y metre la corde") ],
  )
)

```typst

#numbered-example(
  (
    source:([niwelaapinti],),
    transliteration: ([ni-wel+aapinti],),
    morphemes: ([#1-arrange+bow],),
    additional-lines: (
      (['I string a bow' ],),
      ([Largillier (385-40-1)],),
    ),
    translation: [#orth("Ni8erapinti") #orth("j'accomode mon arc, il es prest, je bande mon arc le plie pour y metre la corde") ],
  )
)
```

*There's a `header` field I'm not using, but no `footer` field!*

Note also the addition of some Algonquianist abbreviations:

- #obv
- #dir
- #inv
- #0
- #x
- #anim
- #inan

== Subheading Level 2

#lorem(150)

=== Subheading Level 3

#lorem(125)

// Bibliography
