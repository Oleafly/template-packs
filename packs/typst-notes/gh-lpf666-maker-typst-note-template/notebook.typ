#import "@preview/ergo:0.2.0" as ergo
#import "numbering-config.typ": numbering-config

// Counters are deliberately independent: a Definition never advances the
// Theorem counter. `chapter` resets all of them for standalone and book builds.
#let counted-environment-ids = (
  "theorem",
  "lemma",
  "corollary",
  "proposition",
  "problem",
  "exercise",
  "note",
  "definition",
  "remark",
  "notation",
  "example",
  "concept",
  "computational-problem",
  "algorithm",
  "runtime",
)

#let environment-counter(id) = counter("notebook-environment-" + id)

#let numbered-preheader(preheader, id) = {
  let local-counter = environment-counter(id)
  local-counter.step()
  preheader
  [ ]
  context {
    let chapter-number = counter(heading).get().at(0, default: 0)
    let local-number = local-counter.get().at(0, default: 0)
    numbering("1.1", chapter-number, local-number)
  }
}

#let counted-statement(preheader, id, ..argv) = {
  let args = argv.pos()
  let argc = args.len()
  let kwargs = argv.named()
  let should-number = kwargs.remove(
    "numbered",
    default: numbering-config.at(id, default: true),
  )

  if argc < 1 or argc > 2 {
    panic("A counted statement needs [body] or [title][body]")
  }
  if type(should-number) != bool {
    panic("The numbered option must be true or false")
  }

  let title = if argc == 2 { args.at(0) } else { [] }
  let statement-body = if argc == 2 { args.at(1) } else { args.at(0) }
  let displayed-preheader = if should-number {
    numbered-preheader(preheader, id)
  } else {
    preheader
  }

  ergo.ergo-statement(
    displayed-preheader,
    id,
    ..kwargs,
    title,
    statement-body,
  )
}

#let counted-solution(preheader, id, is-proof, ..argv) = {
  let args = argv.pos()
  let argc = args.len()
  let kwargs = argv.named()
  let should-number = kwargs.remove(
    "numbered",
    default: numbering-config.at(id, default: true),
  )

  if argc < 2 or argc > 3 {
    panic("A counted solution needs [statement][solution] or [title][statement][solution]")
  }
  if type(should-number) != bool {
    panic("The numbered option must be true or false")
  }

  let title = if argc == 3 { args.at(0) } else { [] }
  let statement-body = if argc == 3 { args.at(1) } else { args.at(0) }
  let solution-body = if argc == 3 { args.at(2) } else { args.at(1) }
  let displayed-preheader = if should-number {
    numbered-preheader(preheader, id)
  } else {
    preheader
  }

  // Ergo has its own Problem counter. Disable it because this wrapper supplies
  // the chapter-aware Problem number in the preheader.
  if id == "problem" {
    kwargs.insert("prob-nums", false)
  }

  ergo.ergo-solution(
    displayed-preheader,
    id,
    is-proof,
    ..kwargs,
    title,
    statement-body,
    solution-body,
  )
}

#let chapter-equation-numbering(number) = context {
  let chapter-number = counter(heading).get().at(0, default: 0)
  numbering("(1.1)", chapter-number, number)
}

// A reference that remains valid when equation numbering is globally disabled.
#let eqref(target) = if numbering-config.equation {
  ref(target)
} else {
  link(target)[该式]
}

#let reset-chapter-counters() = {
  for id in counted-environment-ids {
    environment-counter(id).update(0)
  }
  counter(math.equation).update(0)
}

// Shared page, typography and Ergo setup for the whole notebook and each chapter.
#let notebook(
  title: "Learning Notes",
  author: "",
  short-title: title,
  colors: ergo.ergo-colors.bootstrap,
  styles: ergo.ergo-styles.sidebar1,
  body,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 22mm, bottom: 22mm, x: 21mm),
    numbering: "1",
    number-align: center,
    header: align(
      right,
      text(size: 8.5pt, fill: luma(45%), short-title),
    ),
  )
  set text(
    font: ("New Computer Modern", "Songti SC"),
    fallback: true,
    lang: "zh",
    region: "CN",
    size: 10.5pt,
  )
  set par(justify: true, leading: 0.72em)
  set heading(numbering: "1.1")
  set math.equation(
    numbering: if numbering-config.equation {
      chapter-equation-numbering
    } else {
      none
    },
    supplement: [式],
  )
  show raw: set text(font: "DejaVu Sans Mono", size: 8.3pt)
  show heading.where(level: 1): set text(size: 21pt)
  show heading.where(level: 2): set text(size: 15pt)
  show link: set text(fill: rgb("#0b63ce"))

  // Initialize Ergo before rendering body content.
  show: ergo.ergo-init.with(
    colors: colors,
    styles: styles,
    breakable: true,
    inline-qed: true,
    prob-nums: true,
  )

  body
}

#let title-page(title: none, subtitle: none, author: none, date: none) = {
  set page(header: none, numbering: none)
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    #text(size: 28pt, weight: "bold")[#title]
    #v(10pt)
    #text(size: 15pt, fill: luma(38%))[#subtitle]
    #v(28pt)
    #line(length: 62%, stroke: 0.8pt + luma(65%))
    #v(22pt)
    #text(size: 12pt)[#author]
    #if date != none {
      v(8pt)
      text(size: 10pt, fill: luma(45%), date)
    }
  ]
  v(1fr)
  pagebreak()
}

#let chapter(title, subtitle: none, key: none) = {
  reset-chapter-counters()
  pagebreak(weak: true)
  if key == none {
    heading(level: 1, title)
  } else {
    [#heading(level: 1, title)#label(key)]
  }
  if subtitle != none {
    block(
      below: 1.2em,
      text(size: 11pt, style: "italic", fill: luma(42%), subtitle),
    )
  }
}

// Numbered Ergo-compatible environments. Import notebook.typ as a namespace
// and call `#nb.definition`, `#nb.theorem`, and so on to avoid collisions with
// Ergo's original unnumbered preset names.
#let theorem     = counted-solution.with([Theorem], "theorem", true)
#let lemma       = counted-solution.with([Lemma], "lemma", true)
#let corollary   = counted-solution.with([Corollary], "corollary", true)
#let proposition = counted-solution.with([Proposition], "proposition", true)
#let problem     = counted-solution.with([Problem], "problem", false)
#let exercise    = counted-solution.with([Exercise], "exercise", true)

#let note                  = counted-statement.with([Note], "note")
#let definition            = counted-statement.with([Definition], "definition")
#let remark                = counted-statement.with([Remark], "remark")
#let notation              = counted-statement.with([Notation], "notation")
#let example               = counted-statement.with([Example], "example")
#let concept               = counted-statement.with([Concept], "concept")
#let computational-problem = counted-statement.with(
  [Computational Problem],
  "computational-problem",
)
#let algorithm = counted-statement.with([Algorithm], "algorithm")
#let runtime   = counted-statement.with([Runtime Analysis], "runtime")

// Bilingual wrappers share counters with their English equivalents.
#let zh-note       = counted-statement.with([提示], "note")
#let zh-definition = counted-statement.with([定义], "definition")
#let zh-example    = counted-statement.with([例], "example")
#let zh-theorem    = counted-solution.with([定理], "theorem", true)
#let zh-problem    = counted-solution.with([问题], "problem", false)

// Familiar Ergo aliases, now backed by the chapter-aware counters above.
#let thm       = theorem
#let lem       = lemma
#let cor       = corollary
#let prop      = proposition
#let prob      = problem
#let excs      = exercise
#let defn      = definition
#let rem       = remark
#let rmk       = remark
#let notn      = notation
#let ex        = example
#let conc      = concept
#let comp-prob = computational-problem
#let algo      = algorithm
