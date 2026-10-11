#let delimiter = " | "

  #let array-to-str(items, delimiter: delimiter) = {
    items.join(delimiter)
  }

  #let resume-contacts(contacts) = {
    set align(center)
    array-to-str(contacts)
  }

  #let project(title: "", author: (), contacts: (), body) = {
    set document(author: author.name, title: title)

    set page(
      margin: (left: 1cm, right: 1cm, top: 0.55cm, bottom: 1cm),
    )

    set text(
      font: "Noto Serif CJK SC",
      lang: "zh",
    )

    show heading.where(level: 1): it => block(
      above: 0.35em,
      below: 0.2em,
    )[
      #text(size: 13.5pt, weight: "bold", it.body)
    ]

    let photo-height = 3cm
    let photo-width = photo-height * 1280 / 1790

    block(below: 0.1cm)[
      #grid(
        columns: (photo-width, 1fr, photo-width),
        align: (left + horizon, center + horizon, right + horizon),
        [],
        [
          #block(text(weight: 700, 1.7em, author.name))
          #resume-contacts(contacts)
        ],
        image("photo.png", height: photo-height),
      )
    ]

    v(-0.15cm)

    set par(justify: true)

    body
  }

  #let format-date(date) = {
    if type(date) == datetime {
      date.display()
    } else if type(date) == str and date.len() == 0 {
      "今"
    } else if type(date) == str {
      date
    } else {
      ""
    }
  }

  #let resume-date(start, end: "") = {
    if start == "" and end == "" {
      ""
    } else {
      format-date(start) + " " + $dash.en$ + " " + format-date(end)
    }
  }

  #let resume-item(left: "", right: "", body) = {
    place(end, right)
    left
    linebreak()
    body
    v(6pt)
  }

  #let resume-education(
    university: "",
    degree: "",
    school: "",
    start: "",
    end: "",
    body,
  ) = {
    let left = (
      strong(university),
      school,
      degree,
    )

    let right = resume-date(start, end: end)

    resume-item(
      left: array-to-str(left),
      right: right,
      body,
    )
  }

  #let resume-work(
    company: "",
    duty: "",
    start: "",
    end: "",
    body,
  ) = {
    let left = [
      #strong(text(size: 13.5pt, company))
      #text(size: 12.5pt, "                  " + duty)
    ]

    let right = text(
      size: 11pt,
      resume-date(start, end: end),
    )

    resume-item(
      left: left,
      right: right,
      body,
    )
  }

  #let resume-project(
    title: "",
    duty: "",
    start: "",
    end: "",
    body,
  ) = {
    let left = (
      strong(title),
      duty,
    )

    let right = resume-date(start, end: end)

    resume-item(
      left: array-to-str(left),
      right: right,
      body,
    )
  }
  #let resume-skills(body) = {
    body
    v(6pt)
  }

  #let resume-section(title) = {
    v(-4pt)

    block(below: 2pt, breakable: false)[
      #heading(
        level: 1,
        title,
      )

      #v(2pt)
      #line(length: 100%)
    ]

    v(8pt)
  }