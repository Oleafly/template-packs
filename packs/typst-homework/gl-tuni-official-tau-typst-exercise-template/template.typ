//
// template.typ
//
// Contains code that defines the layout of a PDF file.
// This file needs to be placed in the same folder with
// and exercise file.
//
// Please do not modify this file, as it will probably break
// the intended layout of the PDF you are to submit. Modify
// the attached exercise file instead.
//

// Constants.

#let TUNIPURPLE = rgb(78,0,148)

#let imageKind = "Figure"

#let tableKind = "Table"

#let listingKind = "Listing"

#let otherKind = "Other"

// State variables.

#let tableCounter = counter(tableKind)

#let imageCounter = counter(imageKind)

#let listingCounter = counter(listingKind)

#let otherFigureCounter = counter(otherKind)

// Helper function definitions.

#let authorFn(name: none, organization: none, email: none) = (
  name: if name == none {
    panic("authorFn: name argument not given.")
  } else {
    name
  },
  organization: if organization == none {
    panic("authorFn: organization argument not given.")
  } else {
    organization
  },
  email: if email == none {
    panic("authorFn: email argument not given.")
  } else {
    email
  },
)

#let counterFromFigureKindFn(figKind) = {

  if figKind == image {

    imageCounter

  } else if figKind == table {

    tableCounter

  } else if figKind == raw {

    listingCounter

  } else if type(figKind) == str {

    counter(figKind)

  } else {

    otherFigureCounter

  }

}

#let figureCounterStepFn(figKind) = {

  let counterVal = counterFromFigureKindFn(figKind)

  counterVal.step()

}

#let headingCounterFn(location,level) = {

  let counterValue = counter(heading).at( location )

  let endIndex = calc.min(level, counterValue.len())

  return counterValue.slice(0, endIndex)

}

#let figureCounterFn(figKind, location, level) = {

  let headingCounter = headingCounterFn(location, level)

  let figCounter = counterFromFigureKindFn(figKind).at(location)

  let dispCounter = headingCounter

  dispCounter.push(figCounter.last() + 1)

  dispCounter

}

#let figureCounterStrFn(figKind, location, level) = {

  let figCounter = figureCounterFn( figKind, location, level )

  figCounter.map(str).join(".")

}

#let figureCaptionTitleFn(kindStr, dispCounterStr, delimiter: false) = {

  text(fill:TUNIPURPLE,weight:"bold")[#kindStr~#dispCounterStr]

}

#let figureCaptionFn(kindStr, dispCounterStr, captionBody) = {
  let captionTitle = figureCaptionTitleFn(kindStr,dispCounterStr)
  let captionTitleWithPeriod = captionTitle + text(weight: "bold", ".")
  if not (captionBody in ([], "", none)){
		layout( containerSize => {
			let caption = captionTitleWithPeriod + sym.space.nobreak + captionBody
			let captionSize = measure(caption)
			let alignment = if captionSize.width >= containerSize.width {
				left
			} else {
				center
			}
			set align(alignment)
      caption
		} )
  } else {
    captionTitleWithPeriod
  }

}

#let figKindStrFn(figKind) = {
  if figKind == image {
    "Figure"
  } else if figKind == table {
    "Table"
  } else if figKind == raw {
    "Listing"
  } else if type(figKind) == str {
    figKind
  } else {
    "Unknown"
  }
}

#let equationNumberingFn(headingCounter, equationCounter) = {
  "("
  (
    ..headingCounter.map(str),
    str(equationCounter.first())
  ).join(".")
  ")"
}

// A function for showing exercise headings.

#let headingShowRule(
  bundleOutput: none,
  it,
) = {

  assert(
    bundleOutput != none,
    message: "headingShowRule: bundleOutput flag was not given.",
  )

    if it.level == 1 {

      counter(math.equation).update(0)

      tableCounter.update(0)

      imageCounter.update(0)

      listingCounter.update(0)

      otherFigureCounter.update(0)

    }

    if (
      it.level == 1
      and (counter(heading).get().first() > 1)
      and not bundleOutput
    ) {
      pagebreak()
    }

    block(spacing: 1em)[#it.body]

}

// A function for showing figures inside of a context.

#let figureShowRule(fig) = {

  let figLoc = fig.location()

  let kindStr = if fig.supplement != fig.kind {
    fig.supplement
  } else {
    figKindStrFn(fig.kind)
  }

  let figCounterStr = figureCounterStrFn(
    fig.kind,
    figLoc,
    1
  )

  figureCounterStepFn(fig.kind)

  let figCaption = figureCaptionFn(
    kindStr,
    figCounterStr,
    if fig.caption != none {
      fig.caption.body
    } else {
      ""
    }
  )

  let blockCaption = block(
      width: 95%,
      figCaption
    )

  if fig.kind in (raw,table) {
    blockCaption
  }

  fig.body

  if fig.kind in (image,) or type(fig.kind) == str {
    blockCaption
  }

}

// A function for showing references.

#let refShowRule(it) = {
  set text(fill: TUNIPURPLE)
  show link: set text(fill:TUNIPURPLE)
  let eq = math.equation
  let el = it.element
  if el == none { return text(fill:TUNIPURPLE)[#it] }
  let elementLoc = el.location()
  let refStr = if el.func() == eq {
    // Override equation references.
    let headingCounter = headingCounterFn(elementLoc,1)
    let eqCounter = counter(math.equation).at(elementLoc)
    let numstr = if el.numbering == none { "" } else {
      equationNumberingFn(headingCounter,eqCounter)
    }
    math.equation( numstr )
  } else if el.func() == figure {
    let kindStr = if it.supplement != auto {
      it.supplement
    } else {
      figKindStrFn(el.kind)
    }
    let dispCounterStr = figureCounterStrFn(
      el.kind,
      elementLoc,
      1
    )
    figureCaptionTitleFn(kindStr, dispCounterStr)
  } else {
    // Other references as usual.
    text(fill:TUNIPURPLE)[#it]
  }
  link(elementLoc,refStr)
}

#let rawShowRule(codeFont, fontSize, it) = {

	set text(font : codeFont, size: fontSize)

	if it.block {

		let lastLine = it.lines.last()

		let numberColumnWidth = if lastLine.count < 10 {
			0.7em
		} else {
			calc.floor(calc.log(lastLine.count, base:10)) * 1em
		}

		block(width: 100%, inset: 0.5em, fill: luma(252))[
			#set align(left)
			#grid(
				columns: (numberColumnWidth, 1fr),
				align: (right,left),
				row-gutter:0.7em,
				column-gutter: 0.5em,
				.. for line in it.lines {
					if line.number < line.count {
						(text(fill: gray, str(line.number)), line.body)
					} else if line.number == line.count and line.text.trim() != "" {
						(text(fill: gray, str(line.number)), line.body)
					} else {
						none
					}
				}
			)
		]

	} else {

		box(
			inset : (x : 0.2 * fontSize),
			outset : (y : 0.2 * fontSize),
			fill : luma(240),
			radius : 0.25 * fontSize,
			it
		)

	}

}

#let quoteShowRule(it) = if it.block {
  block(
    stroke: (left: TUNIPURPLE + 2pt),
    inset: (
      x : 0.5em,
      y : 0.3em
    ),
  )[
    #it.body

    #if it.attribution != none [
      --#it.attribution
    ]
  ]
} else {
  it
}

#let parentSectionLevelState = state("parentSectionLevelState", 0)

//
// Typesets a problem heading and automatically attaches a label
// "problem-number" to it, if number is not none.
//
#let problem(number: none, subtitle: none) = {
  assert(
    number == none or ( type(number) == int and number > 0),
    message: "A problem number needs to be none or an integer > 0. Received " + str(number)
  )
  if number != none { counter(heading).update(number - 1) }
  let supplement = "Problem"
  let head = heading(depth: 1, offset: 0, supplement: supplement)[
    #supplement
    #number
    #if subtitle != none [: #subtitle]
  ]
  [
    #head
    #if number != none {
      label(lower(supplement) + "-" + str(number))
    }
  ]
  parentSectionLevelState.update(1)
}
//
// Typesets a problem heading in Finnish and automatically
// attaches a label "tehtävä-number" to it, if number is not
// none.
//
#let tehtävä(number: none, subtitle: none) = {
  assert(
    number == none or ( type(number) == int and number > 0),
    message: "A problem number needs to be none or an integer > 0. Received " + str(number)
  )
  if number != none { counter(heading).update(number - 1) }
  let supplement = "Tehtävä"
  let head = heading(depth: 1, offset: 0, supplement: supplement)[
    #supplement
    #number
    #if subtitle != none [: #subtitle]
  ]
  [
    #head
    #if number != none {
      label(lower(supplement) + "-" + str(number))
    }
  ]
  parentSectionLevelState.update(1)
}

//
// Typesets a solution heading and automatically attaches a label
// "solution-number" to it, if number is not none.
//
#let solution(number: none, subtitle: none) = {
  assert(
    number == none or ( type(number) == int and number > 0),
    message: "A solution number needs to be none or an integer > 0. Received " + str(number)
  )
  let supplement = "Solution"
  let head = heading(numbering: "1.", depth: 1, offset: 1, supplement: supplement)[
    #supplement
    #if subtitle != none [: #subtitle]
  ]
  [
    #head
    #if number != none {
      label(lower(supplement) + "-" + str(number))
    }
  ]
  parentSectionLevelState.update(2)
}

//
// Typesets a solution heading in Finnish and automatically attaches a label
// "solution-number" to it, if number is not none.
//
#let ratkaisu(number: none, subtitle: none) = {
  assert(
    number == none or ( type(number) == int and number > 0),
    message: "A solution number needs to be none or an integer > 0. Received " + str(number)
  )
  let supplement = "Ratkaisu"
  let head = heading(numbering: "1.", depth: 1, offset: 1, supplement: supplement)[
    #supplement
    #if subtitle != none [: #subtitle]
  ]
  [
    #head
    #if number != none {
      label(lower(supplement) + "-" + str(number))
    }
  ]
  parentSectionLevelState.update(2)
}

//
// Typesets a problem part as a heading.
// The level of the heading depends on the level of the previous heading.
//
#let part(number) = context {
  if type(number) != int {
    panic("problem-part: the given part number must be an integer.")
  }
  let heading-counter = counter(heading).get()
  let problem-number = heading-counter.first()
  let part-heading-level = parentSectionLevelState.get() + 1
  assert(
    part-heading-level > 1,
    message: "part: the heading level of a problem part cannot be <= 1."
  )
  if heading-counter.len() >= part-heading-level {
    heading-counter.at(part-heading-level - 1) = number - 1
    counter(heading).update(heading-counter)
  }
  let supplement = if part-heading-level == 2 {
    if text.lang == "fi" {
      "tehtävä"
    } else {
      "problem"
    }
  } else if part-heading-level == 3 {
    if text.lang == "fi" {
      "ratkaisu"
    } else {
      "solution"
    }
  } else {
    panic("problem-part: invalid part heading level (" + str(part-heading-level) + "). Should be either 2 or 3.")
  }
  let part-heading-numbering = if supplement in ("problem", "tehtävä") {
    "1.a"
  } else if supplement in ("ratkaisu", "solution") {
    "1.1.a"
  }
  let part-text = numbering("(a)", number)
  box[
    #heading(
      numbering: part-heading-numbering,
      level: part-heading-level,
      supplement: supplement,
      part-text
    )
    #label(
      (
        supplement,
        str(problem-number),
        if text.lang == "fi" {
          "osa"
        } else {
          "part"
        },
        str(number),
      )
      .join("-")
    )
  ]
}

#let osa = part

#let textFontPriorityList = (
  "SN Pro",
  "Luciole",
  "Libertinus Serif",
  "New Computer Modern",
)

#let mathFontPriorityList = (
  "Lete Sans Math",
  "Luciole Math",
  "New Computer Modern Math",
)

#let codeFontPriorityList = (
  "Maple Mono",
  "JetBrains Mono",
  "Sono",
  "JuliaMono",
  "Fira Mono",
  "SUSE Mono",
  "Aptos Mono",
  "DejaVu Sans Mono"
)

#let rules(
  mainTitle: none,
  topic: none,
  applyPageSettings: none,
  authors: (),
  bundleOutput: none,
  codeFont: codeFontPriorityList,
  codeFontSize: 11pt,
  mathFont: mathFontPriorityList,
  mathFontSize: 12pt,
  textFont: textFontPriorityList,
  textFontSize: 12pt,
  language: "en",
  headingNumbering: "1.1",
  doc
) = {

  assert(
    mainTitle != none,
    message: "rules: did not receive mainTitle."
  )

  assert(
    topic != none,
    message: "rules: did not receive topic."
  )

  assert(
    authors.len() > 0,
    message: "The list of authors must have a length > 0."
  )

  assert(
    type(applyPageSettings) == bool,
    message: "Argument applyPageSettings was not a boolean value or was not provided."
  )

  assert(
    type(bundleOutput) == bool,
    message: "Argument bundleOutput was not a boolean value or was not provided."
  )

  set text(
    font: textFont,
    size: textFontSize,
    lang: language,
  )

  show math.equation: set text( font: mathFont, size: mathFontSize )

  let pageSettings = (
    height: auto,
    width: 210mm,
    margin: (
      top: if authors.len() > 1 { 4cm } else { 3cm },
      left: 1cm,
      right: 1cm,
      bottom: 2cm,
    ),
    header-ascent: 0cm,
    header: context {
      set align(horizon)
      let pageCounterValue = counter(page).get().first()
      if bundleOutput or pageCounterValue > 1 {
        let row-gutter = 0.7em
        grid(
          columns: 3,
          align: (left, center, right),
          grid(
            row-gutter: 1.5 * row-gutter,
            columns: 1,
            topic,
            mainTitle,
          ),
          h(1fr),
          if authors.len() == 0 {
            grid(
              columns: 1,
              row-gutter: row-gutter,
              datetime.today().display("[day].[month].[year]")
            )
          } else if authors.len() == 1 {
            grid(
              columns: 1,
              row-gutter: row-gutter,
              authors.first().name,
              "("
              +
              link("mailto://" + authors.first().email)[#authors.first().email]
              +
              ")",
              datetime.today().display("[day].[month].[year]")
            )
          } else {
            grid(
              columns: 1,
              row-gutter: row-gutter,
              authors.first().name,
              "("
              +
              link("mailto://" + authors.first().email)[#authors.first().email]
              +
              ")",
              "and buddies",
              datetime.today().display("[day].[month].[year]")
            )
          }
        )
        line(length: 100%, stroke: 2pt + TUNIPURPLE)
        v(weak: true, 2em)
      }
    },
    footer: context {
      line(length: 100%, stroke: 2pt + TUNIPURPLE)
      h(1fr)
      counter(page).display()
      h(1fr)
    },
    numbering: "1",
  )

  set page(..pageSettings) if applyPageSettings

  show link: set text(fill:blue)

  show raw: it => rawShowRule(codeFont, codeFontSize, it)

  show ref: refShowRule

  set math.vec(delim:"[")

  set math.mat(delim:"[")

  set figure(numbering: "1.1")

  show heading: headingShowRule.with(
    bundleOutput: bundleOutput
  )

  show figure: figureShowRule

  show quote: quoteShowRule

  // Prevent page breaks in the middle of bibliography items.

  show bibliography: it => {
    show par: it => {
      set par(justify: false)
      block(
        breakable: false,
        it
      )
    }
    it
  }

  show emph: set text(fill:TUNIPURPLE)

  set math.lr(size: 110%)

  show math.equation: set block(breakable: true)

  show math.equation.where(block: false): box

  set enum(numbering: "(a.i.*)", full: false)

  set par(leading: 0.55em, justify: true)

  show par: set math.frac(style: "horizontal")

  set par(spacing: 1.2em)

  set heading(numbering: headingNumbering)

  show heading: set block(above: 1.4em, below: 1em)

  set math.equation(
    numbering : nn => context {
      let headingCounter = headingCounterFn(here(),1)
      let eqCounter = counter(math.equation).get()
      equationNumberingFn( headingCounter, eqCounter )
    },
    supplement: none
  )

  doc

}

#let docsettings(
  authors : (
    authorFn(
      name: "Name",
      organization: "Organization",
      email: "name@domain"
    ),
  ),
  topic: "Topic",
  mainTitle: "Title",
  keywords : (),
  figureCounterDepth: 1,
  textFont: textFontPriorityList,
  mathFont: mathFontPriorityList,
  codeFont: codeFontPriorityList,
  textFontSize: 12pt,
  mathFontSize: 12pt,
  codeFontSize: 11pt,
  headingNumbering: "1.1",
  anonymousDocument : false,
  language: "en",
  problemFiles: (),
  solutionFiles: (),
  bundleExport: false,
  mainDocumentName: none,
  doc,
) = context {

  let bundleOutput = target() == "bundle" and bundleExport

  let authors = if type(authors) == array {
    authors
  } else if type(authors) == dictionary {
    (authors,)
  } else {
    panic("Authors need to be given as an array of authors, or a single dictionary, if there is only 1 author.")
  }

  let authorString = if not anonymousDocument {
    authors
    .map(it => it.name + " @ " + it.organization + " (" + it.email + ")")
    .join(", ")
  } else {
    ""
  }

  set document(
    author : authorString,
    title : topic + " " + mainTitle,
    date: datetime.today(),
    keywords : keywords,
  ) if not bundleOutput

  let mainDocumentWrapper = if target() == "bundle" and not bundleExport {
    assert(
      mainDocumentName != none,
      message: "docsettings: the argument mainDocumentName was not provided with bundle export set to false."
    )
    std.document.with(
      mainDocumentName,
      author: authorString,
      keywords: keywords,
    )
  } else {
    (..x) => x.pos().join()
  }

  mainDocumentWrapper({

    show: rules.with(
      mainTitle: mainTitle,
      topic: topic,
      authors: authors,
      bundleOutput: bundleOutput,
      applyPageSettings: not bundleOutput,
      codeFont: codeFont,
      codeFontSize: codeFontSize,
      mathFont: mathFont,
      mathFontSize: mathFontSize,
      textFont: textFont,
      textFontSize: textFontSize,
    )

    if not bundleOutput [

      #set align(center + horizon)

      #if authors.len() > 1 {
        v(-2cm)
      } else {
        v(-1cm)
      }

      #let titleFunction = if sys.version >= version(0,14,0) {
        std.title
      } else {
        (..x) => x.pos().join()
      }

      #titleFunction[

        #set text(size: 18pt)

        #topic

        #set text(size:21pt)

        #mainTitle

      ]

      #set text(size:15pt)

      #if not anonymousDocument {
        let authorN = authors.len()

        if authorN == 0 {
          "No authors"
        } else {
          let maxAuthorColN = 2
          let authorChunks = authors.chunks(maxAuthorColN)
          grid(
            columns: 1,
            align: center + horizon,
            row-gutter: 1.5em,
            .. authorChunks.map(
              chunk => grid(
                columns: chunk.len(),
                column-gutter: 2cm,
                align: center + horizon,
                .. chunk.map(
                  author => grid(
                    columns: 1,
                    row-gutter: 0.7em,
                    align: center + horizon,
                  )[
                    #author.name
                  ][
                    (#link("mailto://" + author.email)[#author.email])
                  ]
                )
              )
            )
          )
        }
      }

      #set text(size:13pt)

      #datetime.today().display("[day].[month].[year]")

      #line(length: 100%, stroke: 2pt + TUNIPURPLE)

    ]

    let attachFn = if sys.version >= version(0,14,0) {
      pdf.attach
    } else if sys.version >= version(0,13,0) {
      pdf.embed
    } else {
      (..x) => none
    }

    let (problemFn, solutionFn) = if language == "fi" {
      (tehtävä, ratkaisu)
    } else {
      (problem,solution)
    }

    // Include problems and solutions.

    for (index,(problemFile,solutionFile)) in problemFiles.zip(solutionFiles).enumerate() {

      let problemNumber = index + 1

      let problemNumberString = str(problemNumber)

      let problemAndSolution = {

          problemFn(number:index+1)

          include problemFile

          solutionFn(number:index+1)

          include solutionFile

      }

      let problemDocumentWrapper = if bundleOutput {
        std.document.with(
          problemFile + ".pdf",
          author: authorString,
          title: (topic + " " + mainTitle, "Problem " + problemNumberString)
            .join(": "),
        )
      } else {
        (..x) => x.pos().join()
      }

      problemDocumentWrapper(
        {

          show: rules.with(
            mainTitle: mainTitle,
            topic: topic,
            authors: authors,
            bundleOutput: bundleOutput,
            applyPageSettings: bundleOutput,
            codeFont: codeFont,
            codeFontSize: codeFontSize,
            mathFont: mathFont,
            mathFontSize: mathFontSize,
            textFont: textFont,
            textFontSize: textFontSize,
          )

          problemAndSolution

          if bundleOutput {
            attachFn(
              "template.typ",
              relationship: "source",
              mime-type: "text/x-typst",
              description: "Template file that defines document appearance.",
            )

            attachFn(
              "authors.typ",
              relationship: "source",
              mime-type: "text/x-typst",
              description: "A file that contains author information.",
            )

          }

          attachFn(
            problemFile,
            relationship: "source",
            mime-type: "text/x-typst",
            description: "Source code for problem number " + str(index+1) + ".",
          )

          attachFn(
            solutionFile,
            relationship: "source",
            mime-type: "text/x-typst",
            description: "Source code for solution number " + str(index+1) + ".",
          )

        }
      )
    }

    if not bundleExport {
      attachFn(
        "template.typ",
        relationship: "source",
        mime-type: "text/x-typst",
        description: "Template file that defines document appearance.",
      )

      attachFn(
        "authors.typ",
        relationship: "source",
        mime-type: "text/x-typst",
        description: "A file that contains author information.",
      )
    }

  })

  doc

}

// A keyboard or other button can be typeset with this.

#let button(someText) = [
  #h(0.3em, weak:true)
  #box(
    stroke: black,
    fill: luma(230),
    inset: (x:0em,y:0em),
    outset: (x:0.1em,y:0.3em),
    radius: 0.2em
  )[#someText]
  #h(0.3em, weak:true)
]

#let longDivisionTable(dividend: none, divisor: none,..args) = std.figure(
  caption: {
    assert(
      dividend != none,
      message: "longDivisionTable: the named argument dividend must not be none."
    )
    assert(
      divisor != none,
      message: "longDivisionTable: the named argument divisor must not be none."
    )
    [Long division of #dividend by #divisor.]
  },
  kind: std.table,
  std.table(
    columns: 6,
    inset: 0.7em,
    align: center + horizon,
    std.table.header(
      "Iteration",
      "Dividend",
      "Divisor",
      "Leading Quotient",
      "Divisor\n" + sym.times + "\nLeading Quotient",
      "Remainder",
    ),
    .. {
      let argChunks = args.pos().chunks(3)
      for (iter,argChunk) in argChunks.enumerate() {
        (str(iter + 1),)
        if iter == 0 {
          (dividend,)
          (
            table.cell(
              rowspan: argChunks.len(),
              divisor,
            ),
          )
        } else {
          (argChunks.at(iter - 1).last(),)
        }
        argChunk
      }
    }
  )
)

#let binaryOperationTable(
  operator: none,
  setElements: none,
  ..args,
) = std.figure(
  caption: {
    assert(
      operator != none,
      message: "binaryOperationTable: the operator argument must not be none.",
    )
    assert(
      setElements != none,
      message: "binaryOperationTable: the setElements argument must not be none.",
    )
    [Binary operation table for the set ${setElements.join(",")}$ and the operator #operator.]
  },
  std.table(
    inset: 0.7em,
    columns: setElements.len() + 1,
    operator,
    ..setElements,
    .. for (setElement, resultRow) in setElements.zip(args.pos().chunks(setElements.len())) {
      (setElement, ..resultRow)
    }
  )
)
