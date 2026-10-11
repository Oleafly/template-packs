#import "constants.typ": *
#import "helpers.typ": *

#let default(
  issueDetails: (),
  doc
) = {
set text(
  font: main-font,
  size: main-size,
  weight: "regular",
  fill: fg-color,
  hyphenate: false
)
set underline(offset: 3pt)
set par(
  justify: true,
  leading: line-spacing,
  spacing: paragraph-spacing,
  first-line-indent: 0em
)
show table.cell.where(y: 0): set text(weight: "black")
show table.cell.where(y: 0): upper
show math.equation: set text(font: math-font, size:1.1em)
show math.equation.where(block: true): set align(center)
set heading(outlined: false)
show heading.where(level: 2): it =>[
  #set par(justify: false, leading: heading2-spacing)
  #set text(font: subheading-font, weight: heading-weight, size: heading-2-size)
  #block(it.body)
]
show heading.where(level: 1): it =>[
  #set text(fill: outline-headings-color, font: heading-font, size: heading-size, weight: heading-weight)
  #it.body
]
set figure(supplement: figure-suppl, gap: image-caption-gap)
show figure.caption: c => [
  #align(image-caption-align)[#text(weight: caption-weight)[
    #text(fill: header-bg-color, weight: "black")[
    #c.supplement #context{counter(figure.where(kind: image)).display()}
    ]
    #c.separator#c.body
  ]
  ]
]
set quote(block: true)
show quote: set align(center)
show quote: set par(spacing: 0.8em)
show quote: set text(style: "italic")
show quote: set pad(x: 1.5em)
set page(
  // width: page-dims.at(0),
  // height: page-dims.at(1),
  paper: page-shape,
  fill: bg-color,
  margin: (
    top: margin-1,
    bottom: margin-2,
    x: margin-2,
  ),
)
set page(
  header: rect(
    fill: header-bg-color, 
    inset: 0cm,
    outset: (x: margin-2,), 
    width: 100%, 
    height: 100%
  )[
    #{
      set text(font: header-font, fill: header-bright-color, weight: "semibold")
      [INSCIGHT \##issueDetails.at("number")] + h(5pt) + headerSeparator + h(5pt) + [#issueDetails.at("time")]
    }
    #v(header-raise)
  ]
)
set page(
  footer: context [
  #let elementsAfter = query(selector(heading.where(level:1)).after(here()))
  #let elementsBefore = query(selector(heading.where(level:1)).before(here()))
  #v(footer-raise)
  #line(length: 100%, stroke:footerLineHeight+fg-color)
  #text(weight: "black", fill: footer-text-color, size: 0.8em)[
    #grid(
    columns: (33%, 34%, 33%),
    align: (left + horizon, center + horizon, right + horizon),
    if elementsAfter.len() > 0 {
      if calc.even(counter(page).get().first()) {
        link((page: counter(page).at(elementsAfter.at(0).location()).at(0), x: 0pt, y: 0pt), [SKIP TO NEXT])
      } else {
        link((page: counter(page).at(elementsBefore.at(-2, default: elementsBefore.at(-1)).location()).at(0), x: 0pt, y: 0pt), [BACK TO PREV])
      }
    },
    if calc.even(counter(page).get().first()) {
      if query(<outline>).len() > 0 {
        link(<outline>)[JUMP TO TOC]
      }
    } else {
      upper(website-link)
    },
    [#box(fill: rgb(200, 200, 200), outset: 0em, height: 0.7em, width: 10em * (1 - counter(page).get().first() / counter(page).final().at(0))) #h(-0.2em) #box(fill: header-bg-color, height: 0.7em, outset: 0em, width: 10em * counter(page).get().first() / counter(page).final().at(0)) #h(0.5em) #counter(page).display()]
    )
    ]
  ]
  )
  doc
}

#let article(
  issueDetails: none,
  title: none,
  authors: none,
  authorAffiliations: none,
  abstract: none,
  coverImage: none,
  authorInfo: none,
  authorImage: none,
  refsFile: none,
  reviewedBy: none,
  received: none,
  authorImageWidth: 100%,
  breakAfter: none,
  addendum: none,
  outlinePrefix: none,
  content
) = {
  if type(authors) == str {
    authors = (authors,)
  }
  if type(authorInfo) == str {
    authorInfo = (authorInfo,)
  }
  if type(authorAffiliations) == str {
    authorAffiliations = (authorAffiliations,)
  }
  if type(reviewedBy) == str {
    reviewedBy = (reviewedBy,)
  }
  if type(authors) == str {
    authors = (authors,)
  }
  let permalinkSuffix = lower(authors.at(0).split().join("-") + "-" + title.split().at(-1))
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  // let locator = "article-" + permalinkSuffix
  assert(received != none, message:"For item \""+title+"\", a \"received date\" must be provided in the call to section()")
  let date = [#datetime(..received).display("[month repr:short] [day], [year]")]
  let authlist = grid(columns:(5fr, 1fr), gutter: 20pt, align: (top + left, top + right), grid(columns: (auto, auto), gutter: 10pt, align: left + top, text(weight: "bold", stack(dir:ttb, spacing: 1em, ..authors)), stack(dir:ttb, spacing: 1em, ..authorAffiliations)), [📅 #date]) + v(0.1em) + if reviewedBy.len() > 0 and reviewedBy.at(0).len() > 0 [*Reviewed By*: #reviewedBy.join(", ")]
  let authInfoForm = ()
  for info in authorInfo {
    authInfoForm.push(eval(info, mode: "markup"))
  }
  [#metadata((
    title: title,
    authors: authors,
    authorAffiliations: authorAffiliations,
    abstract: eval(abstract, mode: "markup"),
    coverImage: coverImage,
    authorInfo: authInfoForm,
    authorImage: authorImage,
    refsFile: refsFile,
    reviewedBy: reviewedBy,
    received: received,
    permalink: permalink,
    outlinePrefix: outlinePrefix,
    type: "article")) #label("vars")]
  [#metadata(content.fields()) #label("content")]
  {
    show raw.where(block: false): it => text(size: 1.3em, eval(it.text, mode: "math"))
    show raw.where(block: true): it => align(center, text(size: 1.5em, eval(it.text, mode: "math")))
    cover(
      title: title,
      coverImage: coverImage,
      locator: permalink,
    )
    nonCoverTitle(
      title: title, 
      intro: authlist,
    )
    counter(figure.where(kind: image)).update(0)
    columns(2,
        block(width: 105%, inset: 10pt, height: auto, fill: author-profile-fill,
        {
          set par(leading: 0.6em)
          set text(size: 1.1em, font: abstract-font)
          show strong: set text(fill:header-bg-color)
          eval(abstract, mode:"markup")
        })
        +
        block(width: 105%, inset: 10pt, height: auto, fill: author-profile-fill,
        auth-profile(authorInfo: authorInfo, authorImage: authorImage, authorImageWidth: authorImageWidth)
        ) +
        {
          show link: set text(fill: header-bg-color)
          show link: it => underline(it)
          content
          if addendum != none {
            block(width: 105%, inset: 10pt, height: auto, fill: author-profile-fill, eval(addendum, mode: "markup"))
          }
        }
      + if refsFile != none {
        if breakAfter != none {
          if type(breakAfter) == int {
            breakAfter = (breakAfter,)
          }
        } else {
          breakAfter = (-1,)
        }
        references(refsFile: refsFile, breakAfter: breakAfter)
      }
    )
  }
}

#let interview(
  issueDetails: (),
  file: none,
  title: none,
  group1: none,
  group2: none,
  interviewees: none,
  interviewers: none,
  interviewerAffiliations: none,
  abstract: "",
  coverImage: "",
  intervieweeImage: none,
  intervieweeImageWidth: 100%,
  intervieweeInfo: none,
  received: none,
  outlinePrefix: none,
  content
) = {
  if type(group1) == str {
    group1 = (group1,)
  }
  if type(group2) == str {
    group2 = (group2,)
  }
  if type(interviewers) == str {
    interviewers = (interviewers,)
  }
  if type(interviewerAffiliations) == str {
    interviewerAffiliations = (interviewerAffiliations,)
  }
  if type(interviewees) == str {
    interviewees = (interviewees,)
  }
  if type(intervieweeInfo) == str {
    intervieweeInfo = (intervieweeInfo,)
  }
  {

  let permalinkSuffix = lower(interviewees.at(0)).replace(" ","-").replace(".","-").replace("--", "-")
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  // let locator = "interview-" + permalinkSuffix

  let intervieweeInfoForm = ()
  for info in intervieweeInfo {
    intervieweeInfoForm.push(eval(info, mode: "markup"))
  }
  [#metadata((
    title: title,
    authors: interviewers,
    authorAffiliations: interviewerAffiliations,
    abstract: eval(abstract, mode: "markup"),
    coverImage: coverImage,
    authorInfo: intervieweeInfoForm,
    authorImage: intervieweeImage,
    received: received,
    permalink: permalink,
    outlinePrefix: outlinePrefix,
    type: "interview")) #label("vars")
  ]
  [#metadata(content.fields()) #label("content")]
  {
    cover(
      title: title,
      coverImage: coverImage,
      locator: permalink,
    )
    assert(received != none, message:"For item \""+title+"\", a \"received date\" must be provided in the call to section()")
    let date = [#datetime(..received).display("[month repr:long] [day], [year]")]

    let authlist = [interview by] + linebreak() + stack(dir: ltr, grid(columns: (auto, auto), gutter:10pt, align:(left + horizon, left + horizon), text(weight: "bold", stack(dir:ttb, spacing: 1em, ..interviewers)), stack(dir:ttb, spacing: 1em, ..interviewerAffiliations)), h(1fr), [📅 #date]) + v(0.1em)
    // let authlist = ()
    // for (auth, aff) in interviewers.zip(interviewerAffiliations) {
    //   authlist.push("*"+auth+"*" + " (" + aff + ")")
    // }
    nonCoverTitle(
      title: title, 
      intro: authlist,
    )
    counter(figure.where(kind: image)).update(0)

    show raw.where(block: false): it => text(size: 1.3em, eval(it.text, mode: "math"))
    show raw.where(block: true): it => align(center, text(size: 1.5em, eval(it.text, mode: "math")))
    columns(2,
      block(width: 105%, inset: 10pt, height: auto, fill: author-profile-fill,
      {
        set par(leading: 0.6em)
        set text(size: 1.1em, font: abstract-font)
        show strong: set text(fill:header-bg-color)
        eval(abstract, mode:"markup")
      }
      + auth-profile(authorInfo: intervieweeInfo, authorImage: intervieweeImage, authorImageWidth: intervieweeImageWidth)
      )
      // block(width: 90%,
      // par(leading: 0.6em, text(font: abstract-font, size:1.2em, weight: "medium", fill:header-bg-color, [#abstract.slice(0, abstract.position(" "))]) + text(font: abstract-font, size:1.2em, weight: "medium", eval(abstract.slice(abstract.position(" ")), mode:"markup")))
      // + v(1fr)
      // + auth-profile(authorInfo: intervieweeInfo, authorImage: intervieweeImage, authorImageWidth: intervieweeImageWidth)
      // )
      // + colbreak()
      + {
        for name in group1 {
          content = { 
            show regex("^" + name + ".*$"): it => text(weight: "bold", size: 1.1em, fill: questionColor, it) + ignore("\n{: .interview-answer }\n")
            content 
          }
        }
        content
        // this convoluted method is necessary because simply applying show rules 
        // in a loop and placing the content outside the loops means the show rules 
        // will activate only within the loop and content will be unaffected
      } 
    )
  }
  }
}

#let quiz(
  issueDetails: (),
  file: none,
) = {
  let data = yaml(file)
  let title = data.title
  let intro = eval(data.intro, mode: "markup")
  let author = eval(data.author, mode: "markup")

  let counter = 1
  let content = while str(counter) in data {
    let question = data.at(str(counter)).at("q")
    let img = none
    if "i" in data.at(str(counter)) {
      img = data.at(str(counter)).i
    }
    let options = data.at(str(counter)).o
    set enum(numbering: "I. ")
    if img != none { 
      if img.split(".").at(0).ends-with("-ttb") {
        stack(
          dir: ttb,
          spacing: 2em,
          align(center, image(img, height: 20em)),
          [*Q#counter\.* ] + [#eval(question, mode: "markup")] + for line in options {
          [+ #eval(line, mode: "markup")]
          },
        )
      } else {
        grid(
          columns: (1.2fr, 1fr),
          gutter: 3em,
          [*Q#counter\.* ] + [#eval(question, mode: "markup")] + for line in options {
          [+ #eval(line, mode: "markup")]
          },
          align(center, image(img, height: 15em))
        )
      }
    } else {
      [*Q#counter\.* ] + [#eval(question, mode: "markup")] + for line in options {
        [+ #eval(line, mode: "markup")]
      }
    }
    linebreak()
    counter += 1
  } + v(2em) + emph[Answers can be found at the end of the issue. For an interactive version of the quiz, check out our #link(createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: "quiz"))[*#underline[website]*]#label("quiz")]

  let counter = 1
  let solution = while str(counter) in data {
    let question = data.at(str(counter)).at("q")
    let options = data.at(str(counter)).o
    let answer = options.at(data.at(str(counter)).at("a") - 1)
    [#counter. #eval(question, mode: "markup"): *#answer*] + v(-0.3em)
    counter += 1
  }

  let permalinkSuffix = "quiz"
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  [#metadata((
    title: title,
    authors: author,
    permalink: permalink,
    file: file,
    type: "quiz",
  ),) #label("vars")
  ]
  [#metadata([].fields()) #label("content")]
  [#metadata((
    type: "quiz",
    title: "Quiz",
    solution: solution,
  ),) #label("solution")
  ]
  nonCoverTitle(
    title: title, 
    intro: intro + v(1em) + author,
    locator: permalink,
  )
  content
}

#let linkedlist(
  issueDetails: none,
  file: none,
) = {
  let data = yaml(file)
  let title = data.title
  let intro = eval(data.intro, mode: "markup")
  let author = eval(data.author, mode: "markup")
  let seed = upper(data.seed)
  let hints = data.hints
  let answers = data.answers
  assert.eq(answers.len(), hints.len())
  let counter = 1
  let content = for (h, a) in hints.zip(answers) {
    let letterCount = 1
    let strokeDef = (thickness: 1.5pt, paint: header-bg-color)
    let boxes = for i in a {
      if counter == 1 and letterCount == 1 {
        box(square(size: 18pt, stroke: strokeDef, align(center + horizon, text(weight: "bold", size: 13pt, seed.last()))), inset: 0pt, outset: 0pt)
      } else if counter == hints.len() and letterCount == a.len() {
        box(square(size: 18pt, stroke: strokeDef, align(center + horizon, text(weight: "bold", size: 13pt, seed.at(0)))), inset: 0pt, outset: 0pt)
      } else {
        // box(square(size: 18pt, stroke: strokeDef), inset: 0pt, outset: 0pt)

        set text(fill: rgb(0, 0, 0, 0%))
        box(square(size: 18pt, stroke: strokeDef, align(center + horizon, text(weight: "bold", size: 13pt, [A]))), inset: 0pt, outset: 0pt)
      }
      letterCount += 1
    }
    [
      #set par(first-line-indent: 0em)
      #enum.item(counter)[
        #h (#strong[#a.len()])

        #linebreak() 
        #v(-2.5em)
        #boxes
        #v(1em)
      ]
    ]
    counter += 1
  }
  let solution = for (h, a) in hints.zip(answers) {
    let letterCount = 1
    let strokeDef = (thickness: 1.5pt, paint: header-bg-color)
    let boxes = for i in a {
      box(square(size: 18pt, stroke: strokeDef, align(center + horizon, text(weight: "bold", size: 13pt, [#i]))), inset: 0pt, outset: 0pt)
    }
    [
      #set par(first-line-indent: 0em)
      #boxes
      #linebreak() 
      #v(-1.2em)
    ]
  } + linebreak()
  let permalinkSuffix = "linkedlist"
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  [#metadata((
    title: title,
    authors: author,
    permalink: permalink,
    file: file,
    type: "linkedlist",
  ),) #label("vars")
  ]
  [#metadata([].fields()) #label("content")]
  [#metadata((
    type: "linkedlist",
    title: "Linked List",
    solution: solution,
  ),) #label("solution")
  ]
  [

    #set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

    #nonCoverTitle(
      title: title, 
      intro: intro + v(1em) + author,
      locator: permalink,
    )

    Linked List is a general science-based word game. The rules are straightforward:
    + The goal is to guess eleven words that have been drawn from science.
    + The first word (the seed) will be provided to you, and hints and number of letters will be provided for the remaining words.
    + You are also informed that the first letter of any word is the last letter of the previous word. So the first letter of the second word will be the last letter of the seed word, the first letter of the third word is the last letter of the second word, and so on.
    + This property goes all the way, so that the last letter of the last (eleventh) word is also the first letter of the seed word.

    Find all the words!
    #linebreak()
    #linebreak()
    Today's seed: *#seed*

    #content

    #emph[Solution can be found at the end of the issue. For an interactive version of this game, check out our #link(createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: "linkedlist"))[*#underline[website]*]]#label("linkedlist").
  ]
}

#let crossword(
  issueDetails: none,
  file: none,
) = {
  let data = toml(file)
  let title = data.title
  let author = eval(data.author, mode: "markup")
  let intro = eval(data.intro, mode: "markup")
  let locations = ()
  for (k,v) in data.at("down") {
    locations.push(v.at(0))
  }
  for (k,v) in data.at("across") {
    locations.push(v.at(0))
  }
  locations = locations.dedup().sorted()

  let down = [
    == Down
    #for (k, v) in data.down.pairs().sorted(key: p=>p.at(1).at(0)) [
      #enum.item(locations.position(i => i == v.at(0)) + 1)[#v.at(1) (#k.len())]
    ]
  ]

  let across = [
    == Across
    #for (k, v) in data.across.pairs().sorted(key: p=>p.at(1).at(0)) [
      #enum.item(locations.position(i => i == v.at(0)) + 1)[#v.at(1) (#k.len())]
    ]
  ]
  let genData = generateCrossword(file)
  let crossword = genData.crossword
  let solution = genData.solution
  let hints = grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: center,
    box(align(left, across)),
    box(align(left, down)),
  )
  let permalinkSuffix = "crossword"
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  [#metadata((
    title: title,
    authors: author,
    permalink: permalink,
    file: file,
    type: "crossword",
  ),) #label("vars")
  ]
  [#metadata((
    type: "crossword",
    title: "Crossword",
    solution: solution,
  ),) #label("solution")
  ]
  [#metadata([].fields()) #label("content")]
  [
    #let links = createLinks(url: permalink)
    #set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

    #nonCoverTitle(
      title: title, 
      intro: intro + v(1em) + author,
      locator: permalink,
    )
    #align(center, crossword)

    #v(1fr)
    #hints
    #v(1fr)

    #emph[Solution can be found at the end of the issue. For an interactive version of the crossword, check out our #link(createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: "crossword"))[*#underline[website]*]]#label("crossword").

  ]
}

#let insightDigest(
  issueDetails: none,
  digest: (),
  heights: (50%,),
  widths: (100%,),
  title: none,
  abstract: none,
  intro: none,
  coverHeight: 60%,
  coverImage: none,
  coverCaption: none,
) = {
  let count = 0
  let coverData = ()
  let content = ()
  for item in digest {
    content.push([
      #box(height: heights.at(count), clip: false)[
      #par(leading: rs-spacing)[
      #text(size: rs-title-size, fill: rs-title-color, weight: "medium", eval(item.Title, mode: "markup")) #label("digest-" + item.Author.split().at(0))
      #linebreak()
      #text(size: rs-size)[
        #link(item.Url)[#underline[#item.Reference)]]
        #linebreak()
        Contributed by #text(weight: "bold")[#item.Author (#item.Affiliation)]
        #linebreak()
        *Subjects*: #text(size:0.9em, lower(item.Keywords.join(", ")))
      ]
      ]
      #columns(2, item.Writing)
      ]

      #rect(
        align(center, image("/images/"+item.Image, fit: "cover", width: widths.at(count))) +
        align(center, text(weight: "semibold", item.Caption)),
        stroke: 0.2em + header-bg-color,
        inset: 1em
      )
    ])
    count = count + 1
    coverData.push((item.at("Title"), item.at("Author")))
  }

  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: "digest")
  let links = createLinks(url: permalink)

  [#metadata((
    title: title,
    permalink: permalink,
    coverImage: coverImage,
    digest: digest,
    content: content,
    type: "digest",
  ),) #label("vars")
  ]
  [#metadata([].fields()) #label("content")]
  set page(
    header: createTitleHeader(title: title, shortLink: links.at("short"), issueDetails: issueDetails)
  )
  halfCover(
    title: title, 
    intro: "Fresh highlights from the frontiers of science",
    coverImage: coverImage,
    coverCaption: coverCaption,
    coverData: coverData,
    coverHeight: coverHeight,
    ending: emph(text(weight: "bold", links.at("long")))
  )

  for c in content {
    c
    pagebreak()
  }
}

#let backCover(
  images: (),
  titles: (),
  captions: (),
  footerLeft: none,
  footerRight: none,
) = {
align(center, text(size: 1.6em, weight: "bold", fill: backpage-color, [You made it to the end! While we cook up the next issue, here's a random photo dump.]),)
  let capt(title, caption) = {
    return align(left, text(fill: header-bg-color, size: backCover-caption-size + 0.2em, weight: "semibold", title) + linebreak() + text(size: backCover-caption-size, weight: "semibold", fill: backpage-color, caption))
  }
  stack(
    dir: ttb,
    spacing: 3em,
    grid(
      columns: (40%, 5%, 55%),
      // gutter: 0em,
      align: right + horizon,
      capt(titles.at(0), captions.at(0)),
      h(1fr),
      image(images.at(0), width: 100%),
    ),
    grid(
      columns: (55%, 5%, 40%),
      // gutter: 1em,
      align: left + horizon,
      image(images.at(1), width: 100%),
      h(1fr),
      capt(titles.at(1), captions.at(1))
    ),
    grid(
      columns: (40%, 5%, 55%),
      // gutter: 0em,
      align: right + horizon,
      capt(titles.at(2), captions.at(2)),
      h(1fr),
      image(images.at(2), width: 100%),
    ),
  )
}

#let whoami(
  issueDetails: (),
  file: none,
  heights: (),
) = {
  let data = toml(file)
  let title = data.title
  let author = eval(data.author, mode: "markup")
  let intro = eval(data.intro, mode: "markup")
  let items = ()
  data = data.questions
  for (i, item) in data.enumerate() {
    let gd = none
    let ht = 18%
    if heights.len() >= i + 1 {
      ht = heights.at(i)
    }
    if calc.rem(i, 2) == 1 {
      gd = grid(
          columns: (0.8fr, 0.5fr),
          align: left + top,
          gutter: 4em,
          [
          == #item.question

          #list(
            tight:false,
            ..item.hints
          )
        ],
         image("../images/" + item.image, height: ht, width: 100%, fit: "cover"),
      )
    } else {
      gd = grid(
          columns: (0.5fr, 0.8fr),
          align: left + top,
          gutter: 4em,
          image("../images/" + item.image, height: ht, width: 100%, fit: "cover"),
          [
          == #item.question

          #list(
            tight:false,
            ..item.hints
          )
          ],
      )
    }
    items.push(gd)
    if i < data.len() - 1 {
      items.push(align(center, line(length: 40%)))
    }
  }

  let content = intro + v(2em) + stack(
    dir: ttb,
    spacing: 2em,
    ..items
  )

  let permalinkSuffix = "whoami"
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)

  [#metadata((
    title: title,
    authors: author,
    permalink: permalink,
    file: file,
    type: "whoami",
  ),) #label("vars")
  ]
  [#metadata([].fields()) #label("content")]
  let links = createLinks(url: permalink)
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  nonCoverTitle(
    title: title, 
    locator: permalink,
    intro: intro + v(0.5em) + author,
  )
  content
}

#let foreword(
  keys: (),
  // images: (),
  // captions: (),
  imgWidths: (),
  fraction: 1fr,
  issueDetails: none,
  title: none,
  author: none,
  affiliation: none,
  content
) = {
  let type = "foreword"
  if title == none {
    type = "editor"
  }
  let outlineDesc = "Foreword by " + author
  if type == "editor" {
    title = "A Word from the Editors"
  }
    
  let intro = none
  if type == "foreword" { 
    intro = [Foreword by *#author*\ #affiliation] 
  } else {
    intro = [*#author*\ #affiliation] 
  }
  let images = ()
  let abstracts = ()
  for key in keys {
    let info = extract(key)
    if info.at(0) == none {
      abstracts.push(info.at(2))
    } else {
      abstracts.push(info.at(0))
    }
    images.push(info.at(1))
  }
  let captions = ()
  for (abstract, key) in abstracts.zip(keys) {
    captions.push([#eval(truncate(abstract, 300) + "...  ", mode: "markup") #pageLink(key, [Read the rest here.])])
    // captions.push([#eval(abstract.slice(0, 200) + "...", mode: "markup") #pageLink(key, [\ Read the rest here.])])
  }
  if imgWidths.len() < images.len() {
    imgWidths = ()
    for (i, _) in images.enumerate() {
      imgWidths.push(100%)
    }
  }

  let permalinkSuffix = type

  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  [#metadata((
    title: title,
    authors: author,
    authorAffiliations: affiliation,
    permalink: permalink,
    type: type,
    abstract: intro,
    images: images,
    captions: captions)
  ) #label("vars")]
  [#metadata(content.fields()) #label("content")]
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  nonCoverTitle(
    title: title, 
    intro: intro,
    locator: permalink,
  )
  grid(
    columns: (fraction, 1fr),
    gutter: 3em,
    align: left,
    content,
    for (i, img) in images.enumerate() {
      if i == 0 {
        align(center, image(images.at(i), width: imgWidths.at(i))) + captions.at(i)
      } else {
        v(1fr) + align(center, image(images.at(i), width: imgWidths.at(i))) + captions.at(i)
      }
    }
  )
}

#let comic(
  title: none,
  coverImage: none,
  authors: none,
  authorAffiliations: none,
  authorInfo: none,
  authorImage: none,
  locator: none,
  comic_images: (),
) = {

  let permalink = ("comic-" + authors.join("-") + "/").replace(" ", "-")
  [#metadata((
    title: title,
    authors: authors,
    authorAffiliations: authorAffiliations,
    authorInfo: authorInfo,
    coverImage: coverImage,
    authorImage: authorImage,
    pages: comic_images,
    permalink: permalink,
    type: "comic")) #label("vars")]
  [#metadata([].fields()) #label("content")]
  cover(
    title: title,
    coverImage: coverImage,
    locator: permalink,
  )

  pagebreak()
  for img in comic_images [
    #set page(
        background: image("/images/" + img, width: 95%),
        header: none,
        footer: none,
    )
    #pagebreak()
  ]

  set page(background: none)
  show: default.with(
    issueDetails: yaml("/dataFiles/issueData.yml"),
  )
  align(center,
  block(width: 50%,
  auth-profile(authorInfo: authorInfo, authorImage: authorImage)
  + v(1fr)
  ))
}

#let lastpage(
  issueDetails: none,
) = {
  let issueDetails = yaml(issueDetails)
  let title = "Solutions"
  let permalinkSuffix = "solutions"
  let permalink = createPermalink(issueNum: issueDetails.at("number"), permalinkSuffix: permalinkSuffix)
  let links = createLinks(url: permalink)
  set page(header: createTitleHeader(title: title, issueDetails: issueDetails, shortLink: links.at("short")))

  nonCoverTitle(
        title: title, 
        locator: permalinkSuffix,
    )

  set par(justify: false)

  context {
      let col = category-colors.at("rest")
      let locResult = none
      for result in query(<solution>) [
        #block(breakable: false)[
          == #result.value.title
          #result.value.solution
        ]
      ]
    }
}
