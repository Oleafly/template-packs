// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: "", authors: (), logo: none, id: none, date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en", size: 12pt)
  show math.equation: set text(weight: 400)

  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  set par(leading: 0.75em)

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  box(
    width: 100%,
    align(center)[
      #text(2em, weight: 900)[
        Operating System
      ]

      #text(3em, weight: 700)[
        #title
      ]

      #v(1em)
      #image("./images/ZJU-Logo.png", width: 50%)
      #v(2em)

      #text(1.35em)[
        Authors: #authors.join(", ")

        Student ID: #id

        Date: #date

        2026-2027 Spring & Summer Semester
      ]

      #v(12em)
    ]
  )

  // Author information.
  // pad(
  //   top: 0.7em,
  //   right: 20%,
  //   grid(
  //     columns: (1fr,) * calc.min(3, authors.len()),
  //     gutter: 1em,
  //     ..authors.map(author => align(start, strong(author))),
  //   ),
  // )

  v(2.4fr)
  pagebreak()


  // Table of contents.
  outline(
    title: text(1.1em, "Table of Contents"),
    depth: 3,
    indent: 1.2em,
  )
  pagebreak()


  // Main body.
  set par(justify: true)
  set heading(numbering: (..args) => {
    let nums = args.pos()
    if nums.len() == 1 {
      return none
    } else {
      return numbering("1.1)", ..nums)
    }
  })
  body
}

#let importCode(file, namespace: none, lang: "cpp") = {
  let source_code = read(file)
  
  if source_code == none {
    return block[
      #text(red, weight: "bold")[Error: Cannot read file #file]
    ]
  }

  let code = ""
  let note = ""
  let in_namespace = false
  let firstlines = true

  for line in source_code.split("\n") {
    // 处理命名空间
    if namespace != none {
      if line == ("namespace " + namespace + " {") {
        in_namespace = true
        continue
      } else if line == ("} // namespace " + namespace) {
        in_namespace = false
        continue
      } else if in_namespace {
        code += line + "\n"
        continue
      }
    } else {
      // 没有命名空间时，直接处理所有行
      if firstlines and line.starts-with("// ") {
        note += line.slice(3) + "\n"
      } else {
        code += line + "\n"
        firstlines = false
      }
    }
  }

  // 清理代码末尾的换行符
  if code.len() > 0 {
    code = code.trim("\n")
  }

  // 使用 content block 来构建结果
  {
    if note.len() > 0 {
      block(
        fill: rgb(255, 253, 231),
        pad: 8pt,
        radius: 4pt,
        note.trim("\n")
      )
      v(0.5em)
    }
    
    if code.len() > 0 {
      block(
        fill: rgb(248, 248, 248),
        stroke: 1pt + rgb(200, 200, 200),
        radius: 6pt,
        pad(x: 16pt, y: 12pt, [
          #set text(size: 13pt, font: "Fira Code")
          #raw(lang: lang, block: true, code)
        ])
      )
    } else {
      block(
        fill: rgb(248, 248, 248),
        stroke: 1pt + rgb(200, 200, 200),
        radius: 6pt,
        pad(x: 16pt, y: 12pt, [
          #text(red)[\// No code found in namespace '#namespace' or file is empty]
        ])
      )
    }
  }
}