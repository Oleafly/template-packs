#let _round3(v) = calc.round(v, digits: 3)
#let _cm(v) = _round3(v / 1cm)

#let _normalize-mode(mode) = {
  if mode == "withid" or mode == "anonymous" or mode == "noid" {
    mode
  } else {
    "withid"
  }
}

#let _paper-size-cm(paper) = {
  if paper == "letter" or paper == "LETTER" or paper == "Letter" {
    (w: 21.59, h: 27.94)
  } else if paper == "a4" or paper == "A4" {
    (w: 21.0, h: 29.7)
  } else {
    (w: 21.0, h: 29.7)
  }
}
