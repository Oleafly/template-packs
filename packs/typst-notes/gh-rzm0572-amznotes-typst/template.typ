#import "@preview/zebraw:0.5.5": *

#let main-font = ("STIX Two Text", "Songti SC")
#let math-font = "STIX Two Math"
#let mono-font = "Consolas"

#let chapter-color = rgb("0984E3")
#let dfnbox-color  = rgb("0984E3")
#let thmbox-color  = rgb("6C5CE7")
#let exbox-color   = rgb("FDCB6C")
#let enbox-color   = rgb("E17055")
#let codebox-color = rgb("2D3436")
#let notebox-color = rgb("D63031")
#let code-highlight-color = rgb("0984E3").lighten(90%)

#let dfnbox-counter = counter("dfn-counter")
#let thmbox-counter = counter("thm-counter")
#let exbox-counter  = counter("ex-counter")
#let enbox-counter  = counter("en-counter")
#let codebox-counter = counter("code-counter")
#let notebox-counter = counter("note-counter")

#let ref-table = state("ref-table", ())

#let amznotes-typst(
  title: "",
  subtitle: none,
  author: (""),
  remark: none,
  date: datetime.today().display("[year] 年 [month padding:none] 月 [day padding:none] 日"),
  title-page: true,
  table-of-contents: true,
  body,
) = {
  set document(author: author, title: title)

  set text(font: main-font, size: 12pt)

  show strong: it => {
    set text(weight: "bold")
    show regex("\p{sc=Han}+"): set text(weight: "black")
    it.body
  }

  show math.equation: set text(font: math-font)

  show: zebraw

  show: zebraw-init.with(
    numbering-separator: true,
    lang: false,
    indentation: 4,
    highlight-color: code-highlight-color
  )

  // Title page
  if title-page {
    let author-line-spacing = 0.25em     // line spacing between author names

    v(1fr)
    align(center, text(title, font: main-font, size: 24pt, weight: "extrabold"))
    if subtitle != none {
      v(2em)
      align(center, text(subtitle, font: main-font, size: 18pt, weight: "medium"))
    }
    v(6em)

    // author list
    if type(author) == str {       // single author
      align(center, text(author, font: main-font, size: 12pt))
    } else if type(author) == array {
      for i in author {            // multiple authors
        align(center, text(i, font: main-font, size: 12pt))
        if i != author.last() {
          v(author-line-spacing)   // insert line spacing between author names
        }
      }
    }

    v(3fr)
    if remark != none {
      align(center, text(font: main-font, size: 12pt, weight: "regular", remark))
      v(1em)
    }
    align(center, text(font: main-font, size: 12pt, date))
    v(2em)

  }

  // Set heading style
  set heading(
      numbering: (..args) => {
        let nums = args.pos()
        // if nums.len() == 1 {
        //   return numbering("I  ", ..nums)
        // } else if nums.len() == 2 {
        //   return numbering("1  ", ..nums.slice(1))
        // } else {
        //   return numbering("1.1  ", ..nums.slice(1))
        // }
        return numbering("1.1  ", ..nums)
      },
    )

    show heading: it => block(
      below: 1em,
      it
    )

    show heading.where(level: 1): it => {
      pagebreak()
      layout(size => {
        let available-width = size.width
        let full-width = page.width
        let border-width = (full-width - available-width) / 2
        let vspace = 1.2em

        let number-block-width = 1.5em
        let number-block-height = 1.4em
        let is-content = counter(heading).get().at(0) == 0

        let h1-title = rect(
          fill: chapter-color,
          stroke: none,
          inset: (
            left : border-width, top   : vspace,
            right: border-width, bottom: vspace
          ),
          width: full-width,
        )[
          #align(
            horizon,
            text(it.body, fill: white, size: 1.4em, weight: "extrabold")
          )
        ]

        let h1-number = rect(
          fill: chapter-color,
          stroke: white,
          radius: 5pt,
          height: number-block-height,
          inset: (left: 0.4em, right: 0.4em)
        )[
          #align(
            center + horizon,
            text(counter(heading).display("1"), fill: white, size: 1.4em, weight: "bold")
          )
        ]

        place(
          top + left,
          dx: -border-width,
          h1-title
        )

        if not is-content {
          place(
            top + right,
            dx: number-block-width,
            dy: -number-block-height / 2,
            h1-number
          )
        }

        v(measure(h1-title).height + 2em)
      })

      dfnbox-counter.update(0)
      thmbox-counter.update(0)
      exbox-counter.update(0)
      enbox-counter.update(0)
      codebox-counter.update(0)
      notebox-counter.update(0)
    }

    show heading.where(level: 2): it => block(
      width: 100%,
      above: 2em,
      below: 2em,
      {
        set align(center)
        set text(size: 1.2em)
        it
      },
    )

  
  // Set contents style
  if table-of-contents {
    outline(title: text("Table of Contents"), depth: 3, indent: 1.4em)
  }
  
  // Set page style
  set page(
    numbering: "1 of 1",
    number-align: center,
  )

  // Set link style
  show link: it => underline(text(fill: black, it), stroke: blue, offset: 0.18em)

  // Set list style
  set list(indent: 1em)

  // Set page header and footer
  set page(
    header: context {
      let current-page = here().page()

      let h1 = query(
        heading.where(level: 1).before(here())
      )

      let h2 = query(
        heading.where(level: 2).before(here())
      )

      let h1-text = ""
      let h2-text = ""
      let h1-number = ""
      let h2-number = ""

      if h1 != none and h1.len() > 0 {
        h1-number = counter(heading).get().at(0)
        if h1-number == 0 {
          h1-text = h1.last().body
        } else {
          h1-text = [Chapter #h1-number #h1.last().body]
        }
      }

      if h2 != none and h2.len() > 0 {
        if counter(heading).get().len() > 1 {
          h2-number = counter(heading).get().at(1)
          h2-text = [#h1-number.#h2-number #h2.last().body]
        }
      }

      let h1-all = query(
        heading.where(level: 1)
      )

      let h1-page = ()

      for h1-item in h1-all {
        h1-page.push(h1-item.location().page())
      }

      if current-page not in h1-page {
        set text(8pt)
        stack(
          dir: ttb,
          [
            #smallcaps(h1-text)
            #h(1fr) #h2-text
            #v(0.5em)
          ],
          line(length: 100%, stroke: black + 0.5pt)
        )
      }
    }
  )

  body
}

#let amzbox(it, name: "", refname: "", color: none, counter: none, boxtype: "undef") = {
  let frame-color = color.mix((color, 0.85), (black, 0.15))
  let interior-color = color.mix((color, 0.05), (white, 0.95)).transparentize(75%)
  let segmentation-color = color.mix((color, 0.5), (black, 0.5)).transparentize(75%)
  let shadow-color = color.mix((white, 0.75), (black, 0.25)).transparentize(50%)
  let shadow-width = 3pt

  counter.step()

  if refname == "" {
    refname = name
  }

  layout(size => {
    let header = rect(
      fill: frame-color,
      radius: (top: 3pt),
      height: 2em,
      inset: (left: 1em, right: 1em),
      width: 100%,
      stroke: none,
      align(horizon, text(name, fill: white, size: 1em, weight: "bold"))
    )

    let body = block(
      it,
      width: 100%,
      inset: (top: 0.8em, bottom: 0.8em, left: 1em, right: 1em)
    )

    let amzbox-block = rect(
      fill: interior-color,
      stroke: none,
      radius: 3pt,
      width: size.width - shadow-width,
      inset: 0em,
      stack(
        dir: ttb,
        header,
        body
      )
    )

    let amzbox-height = measure(amzbox-block).height
    let amzbox-width = measure(amzbox-block).width

    let shadow-block = rect(
      fill: shadow-color,
      radius: 3pt,
      width: size.width - shadow-width,
      height: amzbox-height,
    )
    let white-block = rect(
      fill: white,
      radius: 3pt,
      width: size.width - shadow-width,
      height: amzbox-height,
    )

    place(
      top + left,
      dx: shadow-width,
      dy: shadow-width,
      shadow-block
    )

    place(
      top + left,
      white-block
    )

    [#amzbox-block #label(refname)]
  })
}

#let dfnbox(it, name: "", refname: "") = {
  let chapter-number = context str(counter(heading).get().at(0))
  let box-number = context str(dfnbox-counter.get().at(0))
  let numbered-name = "Definition " + chapter-number + "." + box-number
  
  if name != "" {
    numbered-name += " ▶ " + name
  }
  
  if refname == "" {
    refname = name
  }

  refname = "dfn:" + lower(refname.replace(" ", "-"))

  ref-table.update(old-list => old-list + ((refname: refname, id: chapter-number + "." + box-number, name: name),))

  amzbox(it, name: numbered-name, refname: refname, color: dfnbox-color, counter: dfnbox-counter)
}

#let thmbox(it, name: "", refname: "") = {
  let chapter-number = context str(counter(heading).get().at(0))
  let box-number = context str(thmbox-counter.get().at(0))
  let numbered-name = "Theorem " + chapter-number + "." + box-number
  
  if name != "" {
    numbered-name += " ▶ " + name
  }
  
  if refname == "" {
    refname = name
  }

  refname = "thm:" + lower(refname.replace(" ", "-"))

  ref-table.update(old-list => old-list + ((refname: refname, id: chapter-number + "." + box-number, name: name),))

  amzbox(it, name: numbered-name, refname: refname, color: thmbox-color, counter: thmbox-counter)
}

#let exbox(it, name: "", refname: "") = {
  let chapter-number = context str(counter(heading).get().at(0))
  let box-number = context str(exbox-counter.get().at(0))
  let numbered-name = "Example " + chapter-number + "." + box-number
  
  if name != "" {
    numbered-name += " ▶ " + name
  }
  
  if refname == "" {
    refname = name
  }

  refname = "ex:" + lower(refname.replace(" ", "-"))

  ref-table.update(old-list => old-list + ((refname: refname, id: chapter-number + "." + box-number, name: name),))

  amzbox(it, name: numbered-name, refname: refname, color: exbox-color, counter: exbox-counter)
}

#let enbox(it, name: "", refname: "") = {
  let chapter-number = context str(counter(heading).get().at(0))
  let box-number = context str(enbox-counter.get().at(0))
  let numbered-name = "Exercise " + chapter-number + "." + box-number
  
  if name != "" {
    numbered-name += " ▶ " + name
  }
  
  if refname == "" {
    refname = name
  }

  refname = "en:" + lower(refname.replace(" ", "-"))

  ref-table.update(old-list => old-list + ((refname: refname, id: chapter-number + "." + box-number, name: name),))

  amzbox(it, name: numbered-name, refname: refname, color: enbox-color, counter: enbox-counter)
}

#let codebox(it, name: "", refname: "") = {
  let chapter-number = context str(counter(heading).get().at(0))
  let box-number = context str(codebox-counter.get().at(0))
  let numbered-name = "Code Snippet " + chapter-number + "." + box-number
  
  if name != "" {
    numbered-name += " ▶ " + name
  }
  
  if refname == "" {
    refname = name
  }

  refname = "code:" + lower(refname.replace(" ", "-"))

  ref-table.update(old-list => old-list + ((refname: refname, id: chapter-number + "." + box-number, name: name),))

  amzbox(it, name: numbered-name, refname: refname, color: codebox-color, counter: codebox-counter)
}

#let notebox(it, color: notebox-color) = {
  let frame-color = color.mix((color, 0.85), (black, 0.15))
  let interior-color = color.mix((color, 0.05), (white, 0.95)).transparentize(75%)
  let leftbar-width = 4pt

  layout(size => {
    let notebox-width = size.width - leftbar-width

    let notebox-block = rect(
      width: notebox-width,
      fill: interior-color,
      inset: (top: 0.8em, bottom: 0.8em, left: 1em, right: 1em),
      it
    )

    let final-height = measure(notebox-block).height

    block(
      stack(
        dir: ltr,
        rect(
          fill: frame-color,
          width: leftbar-width,
          height: final-height
        ),
        notebox-block
      )
    )
  })
}

#let boxref(refname: str) = {
  let reflabel = label(refname)
  context {
    let item = ref-table.get().find(it => it.refname == refname)
    if item == none {
      text("Error: reference not found.")
    } else {
      link(reflabel, item.id)
    }
  }
}

#let nameref(refname: str) = {
  let reflabel = label(refname)
  context {
    let item = ref-table.get().find(it => it.refname == refname)
    if item == none {
      text("Error: reference not found.")
    } else {
      link(reflabel, item.name)
    }
  }
}

#let dfntxt(it) = text(it, weight: "bold", style: "italic")

#let proof(it, add-divider: false) = {
  let segmentation-color = color.mix((thmbox-color, 0.5), (black, 0.5)).transparentize(75%)
  
  if add-divider {
    line(length: 100%, stroke: segmentation-color)
  }

  block(
    width: 100%,
  )[
    #text("Proof. ", style: "italic")
    #it
    #place(
      bottom + right,
      rect(
        height: 0.75em,
        width: 0.75em,
        radius: 0.2em,
        stroke: black + 0.8pt
      )
    )
  ]
}

#let show-list() = {
  // Get reference table and display it
  context {
    let current-list = ref-table.get()
    if current-list.len() == 0 {
      "列表为空。"
    } else {
      // Display each item in the list
      for item in current-list {
        [ #item ]
      }
    }
  }
}