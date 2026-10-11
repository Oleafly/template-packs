#import "settings.typ": tex-point, q, font-config

#let _roman-fonts = font-config.roman
#let _mincho-fonts = font-config.mincho
#let _gothic-fonts = font-config.gothic
#let _body-line = 20.5 * q
#let _large-size = 10 * tex-point
#let _large-line = 22 * q

#let _get(item, key, default: "") = {
  if type(item) == dictionary {
    item.at(key, default: default)
  } else {
    default
  }
}

#let _nonempty(value) = value != none and value != ""

#let _validate-title-data(title, en-title, authors, affiliations) = {
  assert(_nonempty(title), message: "IEICEJ template: `title` must not be empty.")
  assert(_nonempty(en-title), message: "IEICEJ template: `en-title` must not be empty.")
  assert(type(authors) == array and authors.len() > 0, message: "IEICEJ template: `authors` must contain at least one author.")
  assert(type(affiliations) == array, message: "IEICEJ template: `affiliations` must be an array.")
  assert(affiliations.len() <= 15, message: "IEICEJ template: at most 15 affiliations are supported by ieicej.cls.")

  let labels = ()
  for (index, affiliation) in affiliations.enumerate() {
    assert(type(affiliation) == dictionary, message: "IEICEJ template: affiliation " + str(index + 1) + " must be a dictionary.")
    let label = _get(affiliation, "label")
    assert(type(label) == str and label.trim() != "", message: "IEICEJ template: affiliation " + str(index + 1) + " needs a non-empty string `label`.")
    assert(not labels.contains(label), message: "IEICEJ template: duplicate affiliation label " + repr(label) + ".")
    labels.push(label)
  }

  for (index, author) in authors.enumerate() {
    let number = str(index + 1)
    assert(type(author) == dictionary, message: "IEICEJ template: author " + number + " must be a dictionary.")
    assert(type(_get(author, "name")) == str and _get(author, "name").trim() != "", message: "IEICEJ template: author " + number + " needs a non-empty string `name`.")
    assert(type(_get(author, "en-name")) == str and _get(author, "en-name").trim() != "", message: "IEICEJ template: author " + number + " needs a non-empty string `en-name`.")

    let author-labels = _get(author, "affiliations", default: ())
    assert(type(author-labels) == array, message: "IEICEJ template: author " + number + " field `affiliations` must be an array of labels.")
    let seen-labels = ()
    for label in author-labels {
      assert(type(label) == str and labels.contains(label), message: "IEICEJ template: author " + number + " refers to unknown affiliation label " + repr(label) + ".")
      assert(not seen-labels.contains(label), message: "IEICEJ template: author " + number + " repeats affiliation label " + repr(label) + ".")
      seen-labels.push(label)
    }

    let email = _get(author, "email")
    if email != "" {
      assert(type(email) == str, message: "IEICEJ template: author " + number + " field `email` must be a string.")
      let parts = email.split("@")
      assert(parts.len() == 2 and parts.first() != "" and parts.last() != "", message: "IEICEJ template: author " + number + " has an invalid email address.")
    }
  }
}

#let _affiliation-mark(index) = {
  let number = index + 1
  if number <= 9 {
    "†" * number
  } else if number <= 15 {
    "*" * (number - 9)
  }
}

#let _mark(item, affiliations: ()) = {
  let explicit = _get(item, "mark")
  if explicit != "" {
    explicit
  } else {
    let own-label = _get(item, "label")
    let labels = if own-label != "" {
      (own-label,)
    } else {
      _get(item, "affiliations", default: ())
    }
    labels
      .map(label => affiliations.position(aff => _get(aff, "label") == label))
      .filter(index => index != none and index < 15)
      .map(_affiliation-mark)
      .join(",")
  }
}

#let _sup(value, offset: -3.73pt) = {
  if value != none and value != "" {
    box(
      width: auto,
      move(
        dy: -0.21em + offset,
        text(size: 0.733em, features: (kern: 0))[#value],
      ),
    )
  }
}

#let _raised-mark(value) = box(move(dy: -2.27pt)[#value])

#let _inline-mark(value, gap: 0.25em) = {
  if value != none and value != "" {
    [#_raised-mark(value)#h(gap)]
  }
}

#let _ja-name(name) = context {
  let target-width = measure(box(width: 5em)).width
  if name.contains(" ") {
    let parts = name.split(" ").filter(part => part != "")
    let natural = parts.join("")
    if measure([#natural]).width > target-width {
      natural
    } else {
      box(width: 5em)[
        #grid(
          columns: (auto, 1fr, auto),
          parts.first(),
          [],
          parts.slice(1).join(" "),
        )
      ]
    }
  } else if measure([#name]).width > target-width {
    name
  } else {
    box(width: 5em, align: center)[#name]
  }
}

#let _author-line(authors, lang: "ja", affiliations: (), separator: h(7.5mm)) = {
  for (i, author) in authors.enumerate() {
    if i > 0 {
      if lang == "en" {
        if i == authors.len() - 1 {
          if authors.len() == 2 { [ and ] } else { [, and ] }
        } else {
          [, ]
        }
      } else {
        separator
      }
    }
    let name = if lang == "en" {
      _get(author, "en-name", default: _get(author, "name"))
    } else {
      _get(author, "name")
    }
    let mark = _mark(author, affiliations: affiliations)
    if lang == "ja" {
      [#_ja-name(name)#box(width: 0pt)[#align(left)[#_sup(mark, offset: -6.13pt)]]]
    } else {
      [#name#_sup(mark)]
    }
  }
}

#let _email-line(authors, affiliations: ()) = {
  let groups = ()
  for author in authors {
    let email = _get(author, "email")
    if email != "" and email.contains("@") {
      let parts = email.split("@")
      let local = parts.first()
      let domain = parts.slice(1).join("@")
      let mark = _mark(author, affiliations: affiliations)
      let index = groups.position(group => group.domain == domain and group.mark == mark)
      if index == none {
        groups.push((domain: domain, mark: mark, locals: (local,)))
      } else {
        let group = groups.at(index)
        group.locals.push(local)
        groups.at(index) = group
      }
    }
  }

  if groups.len() > 0 {
    [E-mail: ]
    for (i, group) in groups.enumerate() {
      if i > 0 { [, ] }
      _raised-mark(group.mark)
      if group.locals.len() == 1 {
        [#(group.locals.first())@#(group.domain)]
      } else {
        [\{#(group.locals.join(","))\}@#(group.domain)]
      }
    }
  }
}

#let _affiliation-content(affiliation, lang: "ja") = {
  let name = if lang == "en" {
    _get(affiliation, "en-name", default: _get(affiliation, "name"))
  } else {
    _get(affiliation, "name")
  }
  let address = if lang == "en" {
    _get(affiliation, "en-address")
  } else {
    _get(affiliation, "address")
  }

  if name != "" and address != "" {
    [#name#h(1em)#address]
  } else if name != "" {
    name
  } else {
    address
  }
}

#let _contact-lines(authors, affiliations, lang: "ja") = {
  let entries = ()
  for aff in affiliations {
    let mark = _mark(aff, affiliations: affiliations)
    let content = _affiliation-content(aff, lang: lang)
    if content != "" {
      entries.push([#_inline-mark(mark)#content])
    }
  }
  let emails = _email-line(authors, affiliations: affiliations)
  if emails != none {
    entries.push(emails)
  }
  for (i, entry) in entries.enumerate() {
    entry
    if i < entries.len() - 1 { linebreak() }
  }
}

#let _labeled(label, body, size: _large-size, above: 0pt, lang: "ja") = {
  if body != none and body != "" {
    block(
      width: 100%,
      above: above,
      below: 0pt,
      align(left)[
        #set par(
          first-line-indent: 0pt,
          justify: true,
          leading: _large-line - size,
        )
        #set text(
          font: _mincho-fonts,
          lang: lang,
          size: size,
          weight: "regular",
          top-edge: 0.8em,
          bottom-edge: -0.2em,
        )
        #if label == "あらまし" or label == "キーワード" { text(font: _gothic-fonts, weight: 500)[#label] } else { text(font: _roman-fonts, weight: "bold")[#label] }#h(1em)#body
      ],
    )
  }
}

#let _center-line(
  body,
  size: 9pt,
  leading: 9pt,
  fonts: _mincho-fonts,
  tracking: 0pt,
  features: (:),
  lang: "ja",
) = {
  block(width: 100%, align(center)[
    #set par(first-line-indent: 0pt, justify: false, leading: leading - size)
    #set text(
      font: fonts,
      lang: lang,
      size: size,
      tracking: tracking,
      features: features,
      weight: "regular",
      top-edge: 0.8em,
      bottom-edge: -0.2em,
    )
    #body
  ])
}

#let _technical-report-title(
  title: "",
  subtitle: "",
  en-title: "",
  en-subtitle: "",
  authors: (),
  affiliations: (),
  abstract: none,
  keywords: none,
  eabstract: none,
  ekeywords: none,
  title-size: 16 * tex-point,
) = {
  _validate-title-data(title, en-title, authors, affiliations)
  set document(
    title: title,
    author: authors.map(author => _get(author, "en-name")),
  )

  let subtitle-size = 14.4 * tex-point
  let author-size = 12 * tex-point
  let contact-size = 10.5 * tex-point
  let header-size = 7 * tex-point
  let title-leading = 23 * tex-point
  let subtitle-leading = 25 * tex-point
  let author-leading = 33 * q
  let contact-leading = 15 * tex-point

  let title-body = block(width: 100%)[
    // The body uses par spacing 0, but the title vbox was calibrated against
    // Typst's default 1.2em block spacing to match TeX's title construction.
    #set par(first-line-indent: 0pt, justify: false, spacing: 1.2em)
    #set text(font: _mincho-fonts, weight: "regular")

    #pad(x: 8mm)[
      #grid(
        columns: (1fr, 1fr),
        align(left + top)[
          #set text(
            font: _mincho-fonts,
            size: header-size,
            top-edge: 0.8em,
            bottom-edge: -0.2em,
          )
          #set par(first-line-indent: 0pt, leading: 3mm - header-size)
          一般社団法人#h(1em)電子情報通信学会\
          THE INSTITUTE OF ELECTRONICS,\
          INFORMATION AND COMMUNICATION ENGINEERS
        ],
        align(right + top)[
          #set text(
            font: _mincho-fonts,
            size: header-size,
            top-edge: 0.8em,
            bottom-edge: -0.2em,
          )
          #set par(first-line-indent: 0pt, leading: 3mm - header-size)
          信学技報\
          IEICE Technical Report
        ],
      )
    ]

    // A literal \vskip\baselineskip in TeX includes less visible whitespace
    // than a Typst block followed by the same absolute skip.
    #v(5.63pt)
    #_center-line(
      move(dy: 0.16pt, title),
      size: title-size,
      leading: title-leading,
      features: (kern: 0),
    )
    #v(0.25 * _body-line)
    #if subtitle != "" {
      _center-line(
        move(dy: -0.36pt, subtitle),
        size: subtitle-size,
        leading: subtitle-leading,
        features: (kern: 0),
      )
      v(0.25 * _body-line)
    }
    #_center-line(
      move(dy: -0.16pt)[#_author-line(authors, affiliations: affiliations)],
      size: author-size,
      leading: author-leading,
    )
    #v(-1.1pt)
    #_center-line(
      move(dy: -0.13pt)[#_contact-lines(authors, affiliations)],
      size: contact-size,
      leading: contact-leading,
    )
    #v(13pt)

    #_labeled("あらまし", abstract)
    #_labeled("キーワード", keywords, above: 5.7pt)

    // Both reference PDFs place the English title 40.99pt below the Japanese
    // keyword baseline. The previous value retained one extra xkanjiskip.
    #v(29.10pt)
    #_center-line(move(dy: 0.86pt, en-title), size: title-size, leading: title-leading, fonts: _roman-fonts, lang: "en")
    #v(0.25 * _body-line)
    #if en-subtitle != "" {
      _center-line(move(dy: 0.35pt, en-subtitle), size: subtitle-size, leading: subtitle-leading, fonts: _roman-fonts, lang: "en")
      v(0.25 * _body-line)
    }
    #_center-line(
      move(dy: 0.54pt)[#_author-line(authors, lang: "en", affiliations: affiliations)],
      size: author-size,
      leading: author-leading,
      fonts: _roman-fonts,
      lang: "en",
    )
    #v(0.67pt)
    #_center-line(
      move(dy: 0.56pt)[#_contact-lines(authors, affiliations, lang: "en")],
      size: contact-size,
      leading: contact-leading,
      fonts: _roman-fonts,
      lang: "en",
    )
    // Without an English abstract, ieicej.cls still reserves enough space for
    // the English keyword block to round the title vbox up by one body line.
    #v(
      if eabstract == none or eabstract == "" {
        21.48pt
      } else {
        13.57pt
      }
    )

    #_labeled("Abstract", eabstract, lang: "en")
    #_labeled("Key words", ekeywords, above: 4.8pt, lang: "en")
    #v(_body-line)
  ]

  place(top + center, scope: "parent", float: true)[
    #layout(size => {
      let measured = measure(title-body, width: size.width)
      let line-count = calc.ceil(measured.height / _body-line)
      // Typst's measured block bottom includes more invisible font boundary
      // than the TeX vbox. Compensate after preserving the class's line-grid
      // rounding so the first body baseline matches the reference output.
      block(width: size.width, height: line-count * _body-line - 13.15pt)[#title-body]
    })
  ]
}

#let title(
  title: "",
  subtitle: "",
  en-title: "",
  en-subtitle: "",
  authors: (),
  affiliations: (),
  abstract: none,
  keywords: none,
  eabstract: none,
  ekeywords: none,
) = _technical-report-title(
  title: title,
  subtitle: subtitle,
  en-title: en-title,
  en-subtitle: en-subtitle,
  authors: authors,
  affiliations: affiliations,
  abstract: abstract,
  keywords: keywords,
  eabstract: eabstract,
  ekeywords: ekeywords,
)
