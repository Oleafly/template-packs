#import "@preview/touying:0.7.4": *
#import "@preview/cetz:0.5.2"

#let title-slide-open-projects(..args, image_person: none, area: "Visual Computing") = touying-slide-wrapper(
  self => {
    let info = self.info + args.named()
    let body = {
      set align(center + horizon)
      // v(-1em)
      layout(
        size => block(
          fill: white,
          width: 100%,
          height: 100%,
          cetz.canvas(
            {
              import cetz.draw: circle, content, line, rect
              content(
                (0, 0),
                block(image("assets/16b_tug_building-min.jpg", width: size.width + 0.1em, fit: "cover")),
                name: "background",
              )

              content((to: "background.north-west", rel: (1em, -2em)), anchor: "north-west", block({
                image("assets/ivc-logo.pdf", width: 30mm, fit: "cover")
              }, fill: rgb(255, 255, 255, 192)), name: "ivc-logo")
              content(
                (to: "ivc-logo.south-west", rel: (0em, -4em)),
                anchor: "north-west",
                block(
                  grid(
                    columns: (auto, auto),
                    gutter: 1em,
                    rows: auto,
                    block(
                      {
                        if type(image_person) == content { image_person } else if image_person != none { image(image_person, width: 5em, fit: "cover") }
                      },
                    ),
                    grid(columns: (auto, auto), rows: auto, gutter: 1em, [Advisor:], {
                      set text(fill: self.colors.neutral-darkest, weight: "bold")
                      if info.author != none {
                        block(info.author)
                      } else {
                        [`Set the correct author in the title-slide-open-projects() function!`]
                      }
                    }, [Research Area:], block({
                      set text(fill: self.colors.neutral-darkest, style: "italic")
                      area
                    }, width: 20em), [Contact:], block(info.email, width: 20em)),
                  ),
                  fill: rgb(255, 255, 255, 192),
                ),
                name: "ivc-logo",
              )
              content((to: "background.north-east", rel: (-1em, -2em)), anchor: "north-east", block(
                {
                  set align(right)
                  image("assets/tugraz-logo.pdf", width: 30mm)
                  v(-0.5em)
                  set text(size: 0.7em, fill: self.colors.neutral-darkest, weight: "light", font: "PT Sans Caption")
                  [
                    SCIENCE \
                    PASSION \
                    TECHNOLOGY
                  ]
                },
                // fill: rgb("#f8f7f7bb")
              ), name: "tug-logo")
              rect(
                (to: "background.south-east", rel: (0em, 2em)),
                (to: "background.south-west", rel: (0em, 0em)),
                fill: rgb(255, 255, 255, 192),
                name: "bottom-bar",
                stroke: 0.2pt + black,
              )
              content((to: "bottom-bar.north-west", rel: (2em, -0.7em)), anchor: "south-west", block({
                set text(size: 0.7em, fill: self.colors.neutral-darkest, weight: "light", font: "PT Sans Caption")
                set align(horizon + left)
                if info.institution != none {
                  block(info.institution)
                }
                if info.institute_url != none {
                  block(info.institute_url)
                }
                // [Testassociation of Graz University of Technology]
              }, height: 0em), name: "institution")
              // add an arrow to the institute content i.e. > ivc.tugraz.at but draw it using lines
              circle(
                (to: "institution.west", rel: (-0.5em, 0em)),
                anchor: "east",
                fill: none,
                radius: 0.1em,
                stroke: none,
                name: "institution-dot",
              )
              let inst_arrow_length = 0.3em
              line(
                (to: "institution-dot", rel: (-inst_arrow_length, inst_arrow_length)),
                (to: "institution-dot", rel: (0em, 0em)),
                (to: "institution-dot", rel: (-inst_arrow_length, -inst_arrow_length)),
                stroke: 2pt + self.colors.tug,
              )
            },
          ),
        ),
      )
      // set text(fill: self.colors.neutral-darkest)
      // if info.author != none {
      //   block(info.author)
      // }
      // if info.date != none {
      //   block(utils.display-info-date(self))
      // }
      // if info.contact != none {
      //   block(info.contact)
      // }
    }
    self = utils.merge-dicts(self, config-page(margin: 0em, fill: self.colors.neutral-lightest))
    touying-slide(self: self, body)
  },
)
