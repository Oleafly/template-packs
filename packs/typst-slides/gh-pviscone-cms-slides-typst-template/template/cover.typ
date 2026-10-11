#import "@preview/touying:0.6.1": *
#import "logos.typ": *


/// -> content
#let title-slide(
  background: "assets/cms_cover.png",
  title_multiplier: 1.0,
  subtitle_multiplier: 1.0,
  author_multiplier: 1.0,
  extra_multiplier: 1.0,
  //logos_multiplier: 1.0,
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = context {
    set block(below: 0pt, above: 0pt)

    let page_height = context page.height
    let sum_h = 0pt

    //LOGOS SECTION
    // Top-right icon + text
    /*
    place(top + right, dy: -1.5cm, dx: 0.78cm, [
      #for logo_path in self.store.logo {
        let logo_height = measure(logo(logo_path, size_multiplier: logos_multiplier)).height
        sum_h = sum_h + logo_height
      }
      #for logo_path in self.store.logo [
        #logo(logo_path, size_multiplier: logos_multiplier)
        #h(0.4cm)
        #context{
          let diff = (page.height - sum_h + 10pt)/self.store.logo.len()
          v(diff)
        }
      ]
    ])
    */
    set page(background: context [

      #image(background, height: page.height + 10pt)
    ])


    v(-0.5cm)

    block(width: 70%)[
      #let title = text(size: title_multiplier * 38pt, weight: "bold", fill: self.colors.primary)[
        #set par(leading: 0.3em)
        #info.at(
          "title",
          default: "",
        )]

      #move(dx: 0.0em)[
        #title
      ]
    ]

    v(0.6cm)

    block(width: 70%)[
      #text(
        size: subtitle_multiplier * 24pt,
        fill: self.colors.secondary,
        weight: "bold",
      )[#info.subtitle]
    ]

    v(1.48cm)
    let institutes = ()
    let institute_numbers = ()
    let temp_idx = 1
    for (person, insts) in info.authors {
      let person_institute_numbers = ()
      for instit in insts {
        if not institutes.contains(instit) {
          institutes.push(instit)
          person_institute_numbers.push(temp_idx)
          temp_idx = temp_idx + 1
        } else {
          let index = institutes.position(it => (it == instit)) + 1
          person_institute_numbers.push(index)
        }
      }
      institute_numbers.push(person_institute_numbers)
    }


    block(width: 70%)[
      #set text(size: author_multiplier * 20pt)
      #let idx = 0
      #for (author, _) in info.authors {
        if (idx != info.authors.len() - 1) [
          #eval(author, mode: "markup")#for (i, num) in institute_numbers.at(idx).enumerate() {
            $attach("", t: #str(num))$
            if (i != institute_numbers.at(idx).len() - 1) { super(",") }
          },#h(0.1em)
        ] else [
          #eval(author, mode: "markup")#for (i, num) in institute_numbers.at(-1).enumerate() {
            $attach("", t: #str(num))$
            if (i != institute_numbers.at(idx).len() - 1) {
              super(",")
            }
          }
        ]
        idx = idx + 1
      }
    ]

    v(1cm)

    // print institutes
    block(width: 70%)[
      #let idx = 0
      #for (_, instit) in institutes.enumerate() {
        text(size: author_multiplier * 20pt)[
          $attach("", t: #str(idx + 1))$#instit#if (idx != institutes.len() - 1) { "," }
        ]
        idx = idx + 1
      }
    ]

    place(bottom)[
      #block(width: 70%)[
        #set text(size: extra_multiplier * 20pt)
        *#info.conference*\
        #info.location\
        #info.date

      ]
    ]

    if (
      self.info.at("download-qr", default: none) != none and self.info.at("download-qr", default: none) != ""
    ) {
      place(bottom + right)[
        #align(center + horizon)[
          #let s = 4.9cm
          #tiaoma.qrcode(self.info.download-qr, width: s, height: s)
        ]
      ]
    }
  }

  touying-slide(self: self, body)
})
