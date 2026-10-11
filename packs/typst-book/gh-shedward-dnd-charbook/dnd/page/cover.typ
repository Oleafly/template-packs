#import "../core/core.typ": *

// Outter padding used in cover
#let coverPaddings = paddings(1.5)

// Renders cover page
// Parameters:
// - name: Name of the character, shown in the middle of cover
// - author: Name of the author, shown in top-right corner
// - title: Flavor title, shown above character name
// - subtitle: Flavor subtitle, shown below character name
// - caption: Additional text for flavor or another info,
//   shown at bottom-left corner
#let cover(
  name,
  author: none,
  title: none,
  subtitle: none,
  caption: none,
  image: none
) = page(
  framed(
    stroke: strokes.normal,
    insets: coverPaddings,
    fitting: expand,
    radius: coverPaddings
  )[
    #framed(
      insets: 2.0 * coverPaddings,
      fitting: expand,
      radius: coverPaddings
    )[
      #box(width: 100%, height: 100%)[
        #if author != none [
          #place(top + right)[
            #author
          ]
        ]
        #place(bottom + left)[
          #caption
        ]
        #place(center + horizon)[
          #if image != none {
            image
          }
          #bookSubtitle[
            #title
          ] \
          #bookTitle[
            "#name"
          ] \
          #v(8mm)
          #bookSubtitle[
            #set text(18pt)
            #subtitle
          ] \
        ]
      ]
    ]
  ]
)
