#let note(
  author: "",
  course: "",
  date: datetime.today(),
  body,
) = {
  set page(
    paper: "us-letter",
    header: [
      #grid(
        align: (left, center, right),
        columns: (1fr, 1fr, 1fr),
        [#author], [#course], [#date.display()],
      )
    ],
    numbering: "1 of 1",
  )

  body
}
/// Create a theorem instance.
/// Optionally, can be numbered.
/// -> content
#let theorem(
  /// the label of the theorem.
  /// -> str | content | none
  label,
  /// body content
  /// -> str | content | none
  body,
) = {
  strong[Theorem #label. ]
  body
}

/// create a proof instance.
#let proof(
  label,
  body,
) = {
  strong[Proof of theorem #label. ]
  body
  align(right)[#square(size: 8pt, stroke: 0.5pt)]
}

/// create a lemma for display later
#let lemma(
  /// name of the lemma
  /// -> str | content | none
  name,
  /// results of the lemma
  /// -> str | content | none
  results,
  /// proof of the lemma
  /// -> str | content | none
  proof,
) = {
  strong[#name.]
  results
  linebreak()
  strong[Proof. ]
  proof
  [$square.filled$]
}

/// Create a problem
#let problem(
  /// problem name/number
  /// -> str | content | none
  label,
  /// body of the problem
  /// -> str | content | none
  body,
) = {
  // We want 1 problem per page.
  // Skip page break if the page is otherwise blank.
  pagebreak(weak: true)

  // Display the problem
  strong[#label ]
  text[#body]
  line(length: 100%, stroke: 0.5pt)
}

#let solution(body) = {
  strong[Solution. ]
  body
  [$square.filled$]
}

// abbreviations of functions
#let soln = solution
#let thm = theorem
#let pf = proof
