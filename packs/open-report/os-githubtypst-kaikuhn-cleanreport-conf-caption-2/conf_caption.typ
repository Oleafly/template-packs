
// apply caption config

#let conf_caption(body) = {
  
  // caption line
  show figure.caption: set text(size: 10pt, fill: luma(100))
  
  // 2. Den Bezeichner (z.B. "Abbildung 1") fett und blau machen
  show figure.caption: it => {
    // Wir trennen den Bezeichner vom Text
    strong(text(fill: blue.darken(30%), it.supplement))
    [ ]
    context it.counter.display(it.numbering)
    [: ]
    it.body
  }

  // spacing between figure and caption
  set figure(gap: 15pt)

  body
}