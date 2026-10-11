#import "scripts/maybe-image.typ": maybe-image
#import "scripts/maybe-include.typ": maybe-include

#let appendix-listing(data) = {
  for (category, items) in data {
    for (id, year, name, award) in items {
      align(horizon+center)[
        #set text(24pt)
        #let id = id.replace("*", "")
        #box(height: 80%)[
          #if id.contains("#") {
            box(stroke: black, inset: 1em)[
              #align(left)[
                #set text(14pt)
                #maybe-include("/notes/"+id.replace("#", "")+".typ")
              ]
            ]
          } else {
            maybe-image("/certs/"+id+".jpg", height: auto, width: auto)
          }
        ]
        #label(id.replace("#", "")) \
        #year#name \
        #award \
      ]
      pagebreak(weak: true)
    }
  }
}