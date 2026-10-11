#let declaration-page(
  ctx,
  candidate_name: none,
  thesis_title: none,
  degree: none,
  word_count: none,
  includes_publications: false,
  percentage_dissertation: none,
  percentage_creative: none,
  ai_usage: none,
  third_party_assistance: none,
) = {
  let labels = ctx.labels
  heading(labels.declaration, numbering: none, outlined: true)
  v(2em)

  par[This is to certify that:]
  v(1em)
  enum[
    [the thesis comprises only my original work towards the #degree;]
    [due acknowledgement has been made in the text to all other material used;]
    (if word_count != none {
    [the thesis is #word_count words in length, exclusive of tables, maps, bibliographies and appendices;]
    })
    (if includes_publications {
    if percentage_dissertation != none and percentage_creative != none {
    [the thesis comprises #percentage_dissertation% dissertation and #percentage_creative% creative outputs as agreed by the advisory committee at confirmation, where the total is 100.]
    } else {
    [the thesis comprises dissertation and creative outputs as agreed by the advisory committee at confirmation, totalling 100%.]
    }
    })
    (if ai_usage != none {
    [Generative or digital assistance used: #ai_usage]
    })
    (if third_party_assistance != none {
    [Third-party human assistance received: #third_party_assistance]
    })
  ]

  v(2em)

  align(right)[
    #candidate_name \
    #labels.submission_date_label: #datetime.today().display("[day] [month repr:long] [year]")
  ]

  pagebreak()
}
