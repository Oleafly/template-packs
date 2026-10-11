// A useful function for my usecase. Have not tested for all cases, but it seems to be correct so far
//This function extracts the first page (defined by an explicit pagebreak)
#let extract_one_page(body) = {
  let body_split = body.children.split(pagebreak())
  let first_page = body_split.remove(0)
  return (first_page.join(), body_split.intersperse(pagebreak()).flatten().join())
}

// This function is something I use often to make tables slightly easily
#let split_content(delim, c)= {
  assert(type(delim) == str, message: "Delimiter should be a string!")
  assert(type(c) == content, message: "Cannot find valid content!")
  let (children, ..fields) = c.fields();
  return children.map(child=>{
    if child.has("text") {
      child.text.split(delim).map(text=>[] + text.trim()).intersperse(delim)
    } else {
      child
    }
  }).flatten().split(delim).map(v => c.func()(v, ..fields)) //Generating new content from the old content
}

// Usage:
// Set title to the short form of project title if applicable, and full_title for the whole thing.
// Set name to your name
// Set roll number to your roll no
// Set guide_name to the Name of your guide
// Set guide_designation to the Designation of your guide
// Presently, there is one change I have made, that that you cannot include the name of your company mentor in the certificate on page 3, because eh
// If you want a dedication page, set dedication_text as true, and make this your first page in the document. END THE PAGE WITH AN explicit pagebreak()
// The next important page is the acknowledgments page. Write howmuchever you want, but to indicate that it is over, use an explicit pagebreak
// The next important page is the abstact. Write howmuchever you want, but to indicate that it is over, use an explicit pagebreak
// The Table of Content should be filled automatically
// If you have content for the list of symbols, set list_of_symbols as true.
// Every section will be considered a new chapter. You may name them as you wish
#let template(
  title: [#text(fill: red)[TITLE OF PROJECT REPORT]],
  full_title: "",
  name: [#text(fill: red)[Name of Student]],
  rollno: [#text(fill: red)[Roll Number]],
  guide_name: [#text(fill: red)[XXXXX]],
  guide_designation: [#text(fill: red)[Designation]],
  dedication_text: true,
  list_of_symbols: true,
  body,
)={
  if full_title.len() == 0 {
    full_title = title
  }
  set page(paper: "a4", numbering: "1")
  set par(leading: 1.15em)
  set text(font: "Times New Roman")
  {
    set align(center)
    text(size: 18pt)[ #title \ ]
    v(1em)

    text(size: 12pt)[ _PROJECT REPORT_ \ #v(1em) _Submitted by_ \ ]

    text(size: 14pt)[ #name\ (#rollno)\ ]

    v(1fr)

    text(size: 12pt)[ Under the Guidance of: \ ]

    text(size: 14pt)[\
      Dr #guide_name\
      #guide_designation, Department of Mechanical Engineering \
    ]
    v(1em)
    image("images/iitm_logo.png")
    v(1em)
    text(size: 14pt)[
      *DEPARTMENT OF MECHANICAL ENGINEERING*\
      *INDIAN INSTITUTE OF TECHNOLOGY*\
      *CHENNAI - 600030*
    ]
    v(1fr)
    text(size: 14pt)[
      *May 2026*
    ]
    pagebreak()
  }

  let remaining = body
  if dedication_text {
    let (dedication_text, rem) = extract_one_page(body)
    remaining = rem
    {
      set align(center + horizon)
      set text(size: 18pt)
      box(stroke: black, width: 70%, inset: 3em)[
        _Dedication_: #dedication_text
      ]
    }
    pagebreak()
  }
  {
    align(center)[#text(size: 15pt)[*CERTIFICATE*]]
    set par(leading: 2em)

    v(2em)

    [
      This is to certify that the project entitled #full_title submitted by #name to the Indian Institute of Technology, Madras is a bonafide record of project work carried out by him under my supervision. The contents of this thesis, in full or in parts, have not been submitted to any other Institute or University for the award of any degree or diploma.

    ]
  }
  {
    set par(leading: 1em)

    [

      #v(1fr)

      Dr #guide_name \
      Project Guide \
      Department of Mechanical Engineering \
      IIT Madras, Chennai 600036

      #v(1fr)

      Dr #guide_name \
      Company Mentor \
      Name and address of company

      #v(1fr)
      Place: Chennai - 36\
      Date: XXXXX
    ]
  }
  set page(numbering: "i")
  counter(page).update(1)
  set par(spacing: 1.5em, leading: 1.5em)
  pagebreak()
  {
    let (ack, rem) = extract_one_page(remaining)
    remaining = rem
    [

      #align(center)[*ACKNOWLEDGMENTS*]

      #ack

    ]
    pagebreak()
  }
  {
    let (abstract, rem) = extract_one_page(remaining)
    remaining = rem
    [

      #align(center)[*ABSTRACT*]

      #abstract

    ]
    pagebreak()
  }
  {
    set align(center)
    set text(size: 15pt)
    [
      *TABLE OF CONTENT*

    ]
  }

  context {
    {
      set text(size: 10pt)
      let lists = query(outline)
      for list in lists {
        let loc = list.location()
        let nr = numbering(loc.page-numbering(), ..counter(page).at(loc))
        [#h(1em)#upper(list.title) #box(width: 1fr, repeat[.]) #nr\ ]
      }
    }
    let heads = query(heading.where(level: 1, outlined: true).or(heading.where(level: 2)))
    for head in heads {
      let loc = head.location()
      let nr = numbering(loc.page-numbering(), ..counter(page).at(loc))
      if head.level == 2 {
        set text(size: 11pt)
        h(1em)
        [*#numbering("1.1.", ..counter(heading).at(loc)) #head.body* #box(width: 1fr, repeat[.]) *#nr*\ ]
      } else {
        if (head.numbering == none) {
          set text(size: 10pt)
          [#h(1em)#upper(head.body) #box(width: 1fr, repeat[.]) #nr\ ]
        } else {
          set text(size: 12pt)

          [*#numbering("1.1.", ..counter(heading).at(loc)) #head.body* #box(width: 1fr, repeat[.]) *#nr*\ ]
        }
      }
    }
  }

  show heading.where(level: 1): it=>{
    set align(center)
    set text(size: 16pt)

    if (not lower(it.body.text).starts-with("list of")) {
      pagebreak()
    }

    if (
      lower(it.body.text) != "references" and lower(it.body.text) != "appendix" and not lower(it.body.text).starts-with("list of")
    ) {
      [
        Chapter #counter(heading).get().at(0)

      ]
    }
    upper(it.body)
    v(1em)
  }
  show heading.where(level: 2): it=>{
    it
    v(5pt)
  }
  outline(title: [List of Figures], target: figure.where(kind: image))
  pagebreak()
  outline(title: [List of Tables], target: figure.where(kind: table))
  if list_of_symbols {
    pagebreak()
    let (los, rem) = extract_one_page(remaining)
    remaining = rem
    los
  }

  set page(numbering: "1")
  counter(page).update(1)
  // counter(heading).update(1)

  set heading(numbering: "1.1.")
  // <start>

  remaining
  // body
}