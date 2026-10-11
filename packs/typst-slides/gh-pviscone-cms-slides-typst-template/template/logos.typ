
#let cern_blue = "/template/assets/CERN_blue.svg"
#let cern_white = "/template/assets/CERN_white.svg"
#let cern_black = "/template/assets/CERN_black.svg"
#let cms = "/template/assets/CMS.svg"
#let cms_white = "/template/assets/CMS_white.svg"
#let ngt_black = "/template/assets/NGT_black.svg"
#let ngt_white = "/template/assets/NGT_white.svg"
#let ngt_compact_black = "/template/assets/NGT_compact_black.svg"
#let ngt_compact_white = "/template/assets/NGT_compact_white.svg"
#let uzh_black = "/template/assets/uzh_black.svg"
#let uzh_white = "/template/assets/uzh_white.svg"
#let uzh_compact_black = "/template/assets/uzh_compact_black.svg"
#let uzh_compact_white = "/template/assets/uzh_compact_white.svg"



#let institute-logo(self) = [
  #block[
    #text(size: 13.5pt, weight: "medium")[#self.store.institute]
    #h(0.1cm)
    #box(inset: 0pt, outset: 0pt)[#square(
      width: 0.3cm,
      height: 0.3cm,
      outset: 0pt,
      inset: 0pt,
      stroke: none,
      fill: self.colors.primary,
    )]
  ]
]


#let logo(logo, size_multiplier: 1.0) = [
  #set align(right)
  #image(logo, width: size_multiplier * 3cm)
]

