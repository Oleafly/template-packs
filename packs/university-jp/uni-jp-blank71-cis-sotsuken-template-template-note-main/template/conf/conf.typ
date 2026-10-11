#import "@preview/cetz:0.4.2": *
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/algorithmic:1.0.7": *

// index
#import "@preview/in-dexter:0.7.2": *

// 和文改善パッケージ
#import "@preview/cjk-spacer:0.1.0": cjk-spacer

#let conf(
  main: false,
  title: "",
  subtitle: "",
  authors: (),
  abstract: none,
  abstract-title: "Abstract",
  index-terms: (),
  date: datetime.today().display(),
  fonts: ("IBM Plex Serif", "BIZ UDMincho", "IPAexMincho"),
  rawFont: "UDEV Gothic NFLG",
  fontSize: (
    default: 12pt,
    title: 16pt,
  ),
  columns: 1,
  paper-size: "a4",
  showOutline: false,
  outlineConf: (
    title: "目次",
    indent: auto,
  ),
  body,
) = {
  set text(lang: "ja")
  set text(font: fonts)
  set text(size: fontSize.default)
  show raw: set text(
    font: rawFont,
  )
  set page(
    columns: columns,
    number-align: center,
    numbering: "1",
    margin: if paper-size == "a4" {
      (x: 0.45in, top: 1.3in, bottom: 1.4in)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
  )
  set par(
    first-line-indent: (
      all: true,
      amount: 1em,
    ),
    justify: true, // 両端揃え
    leading: 0.65em, // 行間距離
    spacing: 0.65em, // 段間距離
  )

  set document(
    title: [#title],
    author: authors.map(author => author.name),
    keywords: index-terms,
    date: datetime.today(),
  )

  show: style-algorithm
  show: cjk-spacer.with(lang: "ja")

  set heading(numbering: numbly("{1}  ", default: "1.1  "))
  show heading: it => {
    let size = if it.level == 1 {
      fontSize.default * 1.2
    } else if it.level == 2 {
      fontSize.default * 1.1
    } else {
      fontSize.default
    }
    text(size: size, it)
  }

  // show titles and outline
  let showTitle(main: bool, showOutline: bool) = {
    let showAuthors(authors) = {
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: fontSize.default,
          ..slice.map(author => align(center, {
            set text(size: fontSize.default * 1.2)
            author.name
            if "organization" in author [
              #ref(label(author.organization))
            ]
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    }

    let showOrganization(authors) = {
      let processed-orgs = ()
      for author in authors {
        if "organization" in author {
          if author.organization not in processed-orgs [
            #align(center, [
              #footnote[#author.organization] #label(author.organization) #author.organization
            ])
            #processed-orgs.push(author.organization)
          ]
        }
      }
    }

    place(
      top,
      float: true,
      scope: "parent",
      clearance: 30pt,
      {
        align(center, par(leading: 0.5em, text(size: fontSize.title * 1.5, title)))
        v(1.8em)
        showAuthors(authors)
        showOrganization(authors)
      },
    )
  }
  let showSupervisorFootnote(authors) = {
    for author in authors {
      if "supervisor" in author {
        footnote(numbering: _ => none, author.supervisor)
      }
    }
    v(-1em)
  }
  if main {
    set footnote(numbering: "*")
    showTitle(main: main, showOutline: showOutline)
    showSupervisorFootnote(authors)
    counter(footnote).update(0)
  }

  if main {
    set text(size: fontSize.default)
    if showOutline {
      outline(
        title: outlineConf.title,
        indent: outlineConf.indent,
      )
    }
  }

  // abstract
  let showAbstract(abstract, title: "") = {
    if title != "" [
      #let title = "abstract"
    ]
    if abstract != none [
      #align(left)[
        #set par(
          first-line-indent: (
            amount: 0em,
          ),
        )
        #text(size: fontSize.default * 1.2, weight: "bold")[#title]
      ]
      #abstract
    ]
  }
  showAbstract(abstract, title: abstract-title)

  // bib and ref setting
  show bibliography: set text(lang: "en")
  show cite: set text(lang: "en")
  set ref(supplement: it => {
    let it-func = it.func()
    if it-func == image {
      [Fig. ]
    } else if it-func == heading {
      []
    } else if it-func == page {
      [p. ]
    } else {
      []
    }
  })

  // final
  body
}

// algorithmic
// AST を再帰的に探索して最後の行にL字型マーカーを追加し、インデントを下げる共通関数
#let process-ast(ast, is-last-in-parent: false, depth: 0) = {
  if type(ast) == content {
    // content は単一行
    if is-last-in-parent {
      let l-marker = box(
        stroke: (left: 0.5pt + luma(200), bottom: 0.5pt + luma(200)),
        inset: (left: 0pt, bottom: 0.5em, right: 1.0em, top: 0pt),
        outset: (left: -0.3em, bottom: -0.1em, right: -0.2em, top: 0.7em),
      )[]
      // インデントを下げて縦線を消し、L字マーカーを追加
      (change-indent: -2, body: (l-marker + ast,))
    } else {
      ast
    }
  } else if type(ast) == dictionary {
    // dictionary は change-indent と body を持つ構造
    let new-body = process-ast(ast.body, is-last-in-parent: is-last-in-parent, depth: depth + 1)
    (change-indent: ast.at("change-indent", default: 0), body: new-body)
  } else if type(ast) == array {
    // array は複数の要素
    if ast.len() == 0 {
      ast
    } else {
      let result = ()
      for i in range(ast.len()) {
        let item = ast.at(i)
        let is-last = is-last-in-parent and i == ast.len() - 1
        result.push(process-ast(item, is-last-in-parent: is-last, depth: depth))
      }
      result
    }
  } else {
    ast
  }
}

// L字終端を使う iflike（end を出力しない）
#let iflike-l-terminated(kw1: "", kw2: "", cond, ..body) = {
  let modified-body = process-ast(body.pos(), is-last-in-parent: true)
  (
    (strong(kw1) + " " + cond + " " + strong(kw2)),
    (change-indent: 2, body: modified-body),
  )
}

// Function
#let Function = {
  let call(
    name,
    kw: "function",
    inline: false,
    style: smallcaps,
    args,
    ..body,
  ) = (
    if inline {
      [#style(name)\(#arraify(args).join(", ")\):]
    } else {
      // end を出力せず、最後の行にL字型マーカーを追加
      let modified-body = process-ast(body.pos(), is-last-in-parent: true)
      (
        (strong(kw) + " " + style(name) + $(#arraify(args).join(", "))$ + ":"),
        (change-indent: 2, body: modified-body),
      )
    }
  )
  call.with(kw: "function", inline: false)
}

#let For = iflike-l-terminated.with(kw1: "for", kw2: "do")
#let If = iflike-l-terminated.with(kw1: "if", kw2: "then")
#let While = iflike-l-terminated.with(kw1: "while", kw2: "do")
#let Else = iflike-l-terminated.with(kw1: "else", kw2: "", "")
#let ElseIf = iflike-l-terminated.with(kw1: "else if", kw2: "then")

#let IfElseChain(..conditions-and-bodies) = {
  let result = ()
  let conditions-and-bodies = conditions-and-bodies.pos()
  let len = conditions-and-bodies.len()
  let i = 0

  while i < len {
    if i == len - 1 and calc.odd(len) {
      result.push(Else(..arraify(conditions-and-bodies.at(i))))
    } else if calc.even(i) {
      // Condition
      let cond = conditions-and-bodies.at(i)
      let body = arraify(conditions-and-bodies.at(i + 1))
      if i == 0 {
        result.push(iflike-unterminated(kw1: "if", kw2: "then", cond, ..body))
      } else if i + 2 >= len {
        result.push(ElseIf(cond, ..body))
      } else {
        result.push(iflike-unterminated(kw1: "else if", kw2: "then", cond, ..body))
      }
    }
    i = i + 1
  }
  result
}
#let Assign(var, val) = (var + " " + $=$ + " " + arraify(val).join(", "),)
#let fbox(body) = {
  box(
    stroke: 0.5pt,
    inset: 0.2em,
    baseline: 0.2em,
    [#body],
  )
}

/// block quote function
#let bq(body) = {
  grid(
    fill: (x, y) => (
      if calc.even(x + y) { gray } else {}
    ),
    columns: (3pt, 1fr),
    gutter: 6pt,
    grid.cell(rect(fill: gray, height: 1.8em)),
    grid.cell(
      align: horizon,
      body,
    ),
  )
}

/// both show body and index the string with lower case
#let index-text(
  body,
  ind: auto,
) = {
  body
  if ind == auto {
    index(lower(body))
  } else {
    index(display: lower(body), lower(ind))
  }
}

/// load bib
#let load-bib(path, main: false, title: auto) = {
  counter("bibs").step()

  context if main {
    [#bibliography(path, title: title) <main-bib>]
  } else if query(<main-bib>) == () and counter("bibs").get().first() == 1 {
    // This is the first bibliography, and there is no main bibliography
    bibliography(path, title: title)
  }
}
