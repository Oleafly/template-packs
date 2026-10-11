#let appendix = state("appendix", false)

#show heading: it => {
  if appendix.get() {
    block[
      #it
      <appendix>
    ]
  } else {
    it
  }
}

#pagebreak()
#heading(numbering: none)[Appendix]
#appendix.update(true)