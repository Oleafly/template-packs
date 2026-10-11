// Import default fallback profile
#import "configs/exam_notes_horizontal.typ": print-profile as default-profile

// Manage active profile via document state
#let _current-profile = state("_current-profile", default-profile)

// Resolve optional chapter preview IDs passed as --input chapters=id,...
#let _requested-chapter-ids() = {
  let raw = sys.inputs.at("chapters", default: "")
  raw.split(",").map(id => id.trim()).filter(id => id != "")
}

// Include every declared chapter by default, or only requested preview chapters.
#let include-chapters(chapters) = {
  let selected = _requested-chapter-ids()
  let available = chapters.map(chapter => chapter.id)
  let unknown = selected.filter(id => id != "all" and id not in available)

  if unknown.len() > 0 {
    panic(
      "Unknown chapter preview ID(s): " + unknown.join(", ")
      + ". Available IDs: " + available.join(", ")
    )
  }

  for chapter in chapters {
    if selected.len() == 0 or "all" in selected or chapter.id in selected {
      include chapter.path
    }
  }
}

// Generic container for framed callouts and admonitions
#let framed(
  title: none,
  fill: auto,
  stroke: auto,
  radius: auto,
  above: auto,
  below: auto,
  inset-top: auto,
  inset-bottom: auto,
  inset-left: auto,
  inset-right: auto,
  out-pad-top: auto,
  out-pad-bottom: auto,
  out-pad-left: auto,
  out-pad-right: auto,
  title-size: auto,
  title-weight: auto,
  title-below: auto,
  profile: auto,
  body,
) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let f-fill = if fill != auto { fill } else { prof.at("box-fill", default: white) }
  let f-stroke = if stroke != auto { stroke } else { prof.at("box-stroke", default: 0.25pt + luma(125)) }
  let f-radius = if radius != auto { radius } else { prof.at("box-radius", default: 0.4mm) }
  let f-above = if above != auto { above } else { prof.at("box-above", default: 2.4pt) }
  let f-below = if below != auto { below } else { prof.at("box-below", default: 2.4pt) }
  let f-inset-top = if inset-top != auto { inset-top } else { prof.at("box-inset-top", default: 0.4mm) }
  let f-inset-bottom = if inset-bottom != auto { inset-bottom } else { prof.at("box-inset-bottom", default: 0.45mm) }
  let f-inset-left = if inset-left != auto { inset-left } else { prof.at("box-inset-left", default: 0.3mm) }
  let f-inset-right = if inset-right != auto { inset-right } else { prof.at("box-inset-right", default: 0.3mm) }
  let f-out-pad-top = if out-pad-top != auto { out-pad-top } else { prof.at("box-out-pad-top", default: 0mm) }
  let f-out-pad-bottom = if out-pad-bottom != auto { out-pad-bottom } else { prof.at("box-out-pad-bottom", default: 0mm) }
  let f-out-pad-left = if out-pad-left != auto { out-pad-left } else { prof.at("box-out-pad-left", default: 0mm) }
  let f-out-pad-right = if out-pad-right != auto { out-pad-right } else { prof.at("box-out-pad-right", default: 0mm) }
  let f-title-size = if title-size != auto { title-size } else { prof.at("box-title-size", default: 4.8pt) }
  let f-title-weight = if title-weight != auto { title-weight } else { prof.at("box-title-weight", default: "bold") }
  let f-title-below = if title-below != auto { title-below } else { prof.at("box-title-below", default: 2.8pt) }

  let box-content = block(
    width: 100%,
    fill: f-fill,
    stroke: f-stroke,
    inset: (
      top: f-inset-top,
      bottom: f-inset-bottom,
      left: f-inset-left,
      right: f-inset-right,
    ),
    radius: f-radius,
  )[
    #if title != none {
      block(below: f-title-below, text(size: f-title-size, weight: f-title-weight, title))
    }
    #body
  ]

  block(
    above: f-above,
    below: f-below,
    pad(
      top: f-out-pad-top,
      bottom: f-out-pad-bottom,
      left: f-out-pad-left,
      right: f-out-pad-right,
      box-content,
    ),
  )
}

// Generic panel connector with automatic inheritance from box-* to type-*
#let panel(
  prefix,
  profile: auto,
  title: none,
  fill: auto,
  stroke: auto,
  radius: auto,
  above: auto,
  below: auto,
  inset-top: auto,
  inset-bottom: auto,
  inset-left: auto,
  inset-right: auto,
  out-pad-top: auto,
  out-pad-bottom: auto,
  out-pad-left: auto,
  out-pad-right: auto,
  title-size: auto,
  title-weight: auto,
  title-below: auto,
  body,
) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let get-val(key, default-val) = {
    prof.at(prefix + "-" + key, default: prof.at("box-" + key, default: default-val))
  }

  framed(
    title: title,
    fill: if fill != auto { fill } else { get-val("fill", white) },
    stroke: if stroke != auto { stroke } else { get-val("stroke", 0.25pt + luma(125)) },
    radius: if radius != auto { radius } else { get-val("radius", 0.4mm) },
    above: if above != auto { above } else { get-val("above", 2.4pt) },
    below: if below != auto { below } else { get-val("below", 2.4pt) },
    inset-top: if inset-top != auto { inset-top } else { get-val("inset-top", 0.4mm) },
    inset-bottom: if inset-bottom != auto { inset-bottom } else {
      get-val("inset-bottom", 0.45mm)
    },
    inset-left: if inset-left != auto { inset-left } else { get-val("inset-left", 0.3mm) },
    inset-right: if inset-right != auto { inset-right } else { get-val("inset-right", 0.3mm) },
    out-pad-top: if out-pad-top != auto { out-pad-top } else { get-val("out-pad-top", 0mm) },
    out-pad-bottom: if out-pad-bottom != auto { out-pad-bottom } else {
      get-val("out-pad-bottom", 0mm)
    },
    out-pad-left: if out-pad-left != auto { out-pad-left } else {
      get-val("out-pad-left", 0mm)
    },
    out-pad-right: if out-pad-right != auto { out-pad-right } else {
      get-val("out-pad-right", 0mm)
    },
    title-size: if title-size != auto { title-size } else { get-val("title-size", 4.8pt) },
    title-weight: if title-weight != auto { title-weight } else {
      get-val("title-weight", "bold")
    },
    title-below: if title-below != auto { title-below } else { get-val("title-below", 2.8pt) },
    profile: prof,
    body,
  )
}

// Preconfigured admonition panels with hierarchical inheritance and parameter control
#let todo-panel(body, profile: auto, ..args) = panel("todo", profile: profile, ..args.named(), body)
#let info-panel(body, profile: auto, ..args) = panel("info", profile: profile, ..args.named(), body)
#let positive-panel(body, profile: auto, ..args) = panel("positive", profile: profile, ..args.named(), body)
#let negative-panel(body, profile: auto, ..args) = panel("negative", profile: profile, ..args.named(), body)
#let important-panel(body, profile: auto, ..args) = panel("important", profile: profile, ..args.named(), body)
#let remember-panel(..args) = important-panel(..args)
#let quote-panel(
  body,
  by: none,
  author: none,
  font: auto,
  size: auto,
  profile: auto,
  ..args,
) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let q-font = if font != auto { font } else { prof.at("quote-font", default: ("Georgia", "PT Serif", "Libertinus Serif", "Times New Roman")) }
  let q-size = if size != auto { size } else { prof.at("quote-size", default: 1.12em) }
  let quote-by = if author != none { author } else { by }
  let formatted-body = text(
    font: q-font,
    style: "italic",
    size: q-size,
  )[
    #body
    #if quote-by != none [
      \ #align(right)[#text(size: 0.82em, style: "normal", weight: "regular", fill: luma(90))[--- #quote-by]]
    ]
  ]
  panel("quote", profile: prof, ..args.named(), formatted-body)
}

// Aliases and shorthand imports
#let info(..args) = info-panel(..args)
#let positive(..args) = positive-panel(..args)
#let negative(..args) = negative-panel(..args)
#let important(..args) = important-panel(..args)
#let remember(..args) = remember-panel(..args)
#let quote-box(..args) = quote-panel(..args)
#let blockquote(..args) = quote-panel(..args)

#let content-to-string(c) = {
  if type(c) == str {
    c
  } else if c == [ ] {
    " "
  } else if c.has("text") {
    c.text
  } else if c.has("child") {
    content-to-string(c.child)
  } else if c.has("children") {
    c.children.map(content-to-string).join()
  } else if c.has("body") {
    content-to-string(c.body)
  } else if c.func() == parbreak or c.func() == linebreak {
    "\n"
  } else {
    ""
  }
}

#let clean-code-string(s) = {
  let lines = s.split("\n")
  while lines.len() > 0 and lines.first().trim() == "" {
    lines = lines.slice(1)
  }
  while lines.len() > 0 and lines.last().trim() == "" {
    lines = lines.slice(0, -1)
  }
  if lines.len() == 0 { return "" }

  let min-indent = 999
  for line in lines {
    if line.trim() != "" {
      let indent = 0
      for char in line.clusters() {
        if char == " " {
          indent += 1
        } else {
          break
        }
      }
      if indent < min-indent {
        min-indent = indent
      }
    }
  }

  if min-indent > 0 and min-indent < 999 {
    lines = lines.map(line => {
      if line.len() >= min-indent {
        line.slice(min-indent)
      } else {
        line
      }
    })
  }

  lines.join("\n")
}

// Custom line-by-line syntax highlighter for Turtle and SPARQL
#let highlight-code-line(line-text, lang) = {
  if lang == none or lang not in ("turtle", "ttl", "sparql", "rq") {
    return line-text
  }

  let token-regex = regex(
    "(#.*$)|(\"[^\"]*\"(?:@[a-zA-Z]+|\^\^[^\s;,.]+)?)|\b(@prefix|@base|PREFIX|BASE|SELECT|DISTINCT|WHERE|FILTER|OPTIONAL|UNION|ORDER|BY|LIMIT|ASK|CONSTRUCT|DESCRIBE|select|distinct|where|filter|optional|union|order|by|limit|ask|construct|describe)\b|(<[^>]+>)|(\?[a-zA-Z0-9_]+)|(\b[a-zA-Z0-9_-]+:[a-zA-Z0-9_-]*)|(\ba\b)",
  )

  let matches = line-text.matches(token-regex)
  if matches.len() == 0 {
    return line-text
  }

  let elems = ()
  let last-idx = 0

  for m in matches {
    if m.start > last-idx {
      elems.push(line-text.slice(last-idx, m.start))
    }
    let val = m.text
    if val.starts-with("#") {
      elems.push(text(fill: rgb("#64748b"), style: "italic", val))
    } else if val.starts-with("\"") {
      elems.push(text(fill: rgb("#16a34a"), val))
    } else if val.starts-with("<") and val.ends-with(">") {
      elems.push(text(fill: rgb("#0d9488"), val))
    } else if lower(val) in ("@prefix", "@base", "prefix", "base") {
      elems.push(text(fill: rgb("#0284c7"), val))
    } else if (
      lower(val)
        in (
          "select",
          "distinct",
          "where",
          "filter",
          "optional",
          "union",
          "order",
          "by",
          "limit",
          "ask",
          "construct",
          "describe",
        )
    ) {
      elems.push(text(fill: rgb("#7c3aed"), val))
    } else if val.starts-with("?") {
      elems.push(text(fill: rgb("#d97706"), val))
    } else if val == "a" {
      elems.push(text(fill: rgb("#e11d48"), val))
    } else if val.contains(":") {
      let parts = val.split(":")
      let pfx = parts.at(0)
      let local = parts.slice(1).join(":")
      elems.push(text(fill: rgb("#4f46e5"), pfx + ":") + text(fill: rgb("#0f172a"), local))
    } else {
      elems.push(val)
    }
    last-idx = m.end
  }

  if last-idx < line-text.len() {
    elems.push(line-text.slice(last-idx))
  }

  elems.join()
}

// State variables for code block styling and titles
#let _in-titled-codebox = state("_in-titled-codebox", false)
#let _codebox-title = state("_codebox-title", none)
#let _has-code-label = state("_has-code-label", false)
#let _in-raw-block = state("_in-raw-block", false)

// Code box helper (supports content [...], verbatim strings, raw blocks, titles, and language badges)
// Overridable outer margins: above, below, pad-left, pad-right
#let code-box(
  code,
  lang: none,
  title: none,
  above: none,
  below: none,
  pad-left: none,
  pad-right: none,
  profile: auto,
) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let text-str = if type(code) == str {
    clean-code-string(code)
  } else if type(code) == content and code.func() == raw {
    clean-code-string(code.text)
  } else {
    clean-code-string(content-to-string(code))
  }
  let detected-lang = if lang != none {
    lang
  } else if type(code) == content and code.func() == raw and code.lang != none {
    code.lang
  } else {
    none
  }
  let raw-elem = raw(text-str, block: true, lang: detected-lang)
  let eff-above = if above != none { above } else { prof.at("code-above", default: 1.6pt) }
  let eff-below = if below != none { below } else { prof.at("code-below", default: 1.6pt) }

  let inner = if title != none {
    _codebox-title.update(title) + raw-elem + _codebox-title.update(none)
  } else {
    raw-elem
  }

  let result = block(above: eff-above, below: eff-below, inner)
  if pad-left != none or pad-right != none {
    pad(
      left: if pad-left != none { pad-left } else { 0pt },
      right: if pad-right != none { pad-right } else { 0pt },
      result,
    )
  } else {
    result
  }
}
#let code-block(..args) = {
  let pos = args.pos()
  let named = args.named()
  let code = if pos.len() > 0 { pos.first() } else { "" }
  let lang = named.at("lang", default: none)
  let title = named.at("title", default: none)
  let above = named.at("above", default: none)
  let below = named.at("below", default: none)
  let pad-left = named.at("pad-left", default: none)
  let pad-right = named.at("pad-right", default: none)
  let profile = named.at("profile", default: auto)
  code-box(
    code,
    lang: lang,
    title: title,
    above: above,
    below: below,
    pad-left: pad-left,
    pad-right: pad-right,
    profile: profile,
  )
}

#let turtle(..args) = {
  let pos = args.pos()
  let named = args.named()
  let code = if pos.len() > 0 { pos.first() } else { "" }
  let title = named.at("title", default: none)
  let above = named.at("above", default: none)
  let below = named.at("below", default: none)
  let pad-left = named.at("pad-left", default: none)
  let pad-right = named.at("pad-right", default: none)
  let profile = named.at("profile", default: auto)
  code-box(
    code,
    lang: "turtle",
    title: title,
    above: above,
    below: below,
    pad-left: pad-left,
    pad-right: pad-right,
    profile: profile,
  )
}

#let sparql(..args) = {
  let pos = args.pos()
  let named = args.named()
  let code = if pos.len() > 0 { pos.first() } else { "" }
  let title = named.at("title", default: none)
  let above = named.at("above", default: none)
  let below = named.at("below", default: none)
  let pad-left = named.at("pad-left", default: none)
  let pad-right = named.at("pad-right", default: none)
  let profile = named.at("profile", default: auto)
  code-box(
    code,
    lang: "sparql",
    title: title,
    above: above,
    below: below,
    pad-left: pad-left,
    pad-right: pad-right,
    profile: profile,
  )
}

// List with custom arrow marker (e.g. for step-by-step derivations)
#let arrow-list(marker: [→], body) = {
  set list(marker: (marker,))
  body
}

// Spacing helpers
#let custom-pad(top: 0pt, bottom: 0pt, left: 0pt, right: 0pt, body) = pad(
  top: top,
  bottom: bottom,
  left: left,
  right: right,
  body,
)
#let spacer(y) = v(y)

// Automated TODO tracking and introspection system
#let todo-counter = counter("todo-counter")
#let todo(body, profile: auto) = {
  todo-counter.step()
  context {
    let prof = if profile != auto { profile } else { _current-profile.get() }
    let num = todo-counter.get().first()
    let lbl = label("todo-" + str(num))
    let show-in-text = prof.at("show-todos-in-text", default: prof.at("show-todos", default: true))
    [#metadata((num: num, desc: body)) #lbl]
    if show-in-text {
      todo-panel(profile: prof)[
        #set text(fill: prof.at("todo-text-fill", default: rgb("b30000")), weight: prof.at("todo-text-weight", default: "bold"))
        TODO #num: #body
      ]
    }
  }
}

#let render-todo-list(profile: auto) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let todos = query(metadata)
    .filter(m => {
      let v = m.value
      type(v) == dictionary and "num" in v and "desc" in v
    })
    .sorted(key: m => m.value.num)

  if todos.len() == 0 {
    text(style: "italic", fill: luma(120))[No open TODO items found.]
  } else {
    let previous-chapter-loc = none
    let first-chapter = true
    for m in todos {
      let num = m.value.num
      let desc = m.value.desc
      let loc = m.location()
      let headings = query(selector(heading.where(level: 1)).before(loc))
      let chapter = if headings.len() > 0 { headings.last() } else { none }
      let chapter-num = if headings.len() > 0 {
        counter(heading).at(chapter.location()).first()
      } else {
        0
      }
      let chapter-loc = if chapter != none { chapter.location() } else { none }
      if first-chapter or chapter-loc != previous-chapter-loc {
        let chapter-title = if chapter != none {
          link(chapter.location(), chapter.body)
        } else {
          [Without chapter]
        }
        block(
          width: 100%,
          above: if first-chapter { 0pt } else { 6pt },
          below: 2pt,
          text(weight: "bold", chapter-title),
        )
        previous-chapter-loc = chapter-loc
        first-chapter = false
      }
      let lbl = label("todo-" + str(num))
      grid(
        columns: (auto, 1fr, auto),
        align: (left + top, left + bottom, right + bottom),
        gutter: 0pt,
        pad(right: prof.at("todo-list-gap", default: 3.0pt))[#link(lbl)[*TODO #num*]],
        [#desc #box(width: 1fr, repeat[ . ])],
        pad(left: 4pt)[#link(lbl)[#chapter-num]],
      )
    }
  }
}

// Renders headings with optional decorative underline rules
#let render-heading(
  it,
  size: auto,
  above: 0pt,
  below: 0pt,
  rule-width: none,
  profile: auto,
) = context {
  let prof = if profile != auto { profile } else { _current-profile.get() }
  let h-size = if size != auto { size } else { prof.at("heading-3-size", default: 5.1pt) }
  block(
    width: 100%,
    above: above,
    below: below,
    sticky: true,
  )[
    #if rule-width != none {
      place(top, dy: -(above / 2), line(
        length: 100%,
        stroke: rule-width + prof.at("heading-rule-color", default: luma(55)),
      ))
    }
    #set text(size: h-size, weight: prof.at("heading-weight", default: "bold"))
    #if it.level <= 2 and it.numbering != none {
      counter(heading).display(prof.at("heading-numbering", default: none))
      h(prof.at("heading-number-gap", default: 0.8mm))
    }
    #it.body
  ]
}

// Front matter is deliberately not a heading, so chapter numbers and the outline
// contain only the actual document chapters.
#let front-matter-title(title, profile) = block(
  width: 100%,
  above: profile.heading-1-above,
  below: profile.heading-1-below,
  text(size: profile.heading-1-size, weight: profile.heading-weight, title),
)

#let cover-page(profile) = {
  let authors = profile.at("cover-authors", default: ("Author Name",))
  let author-line = if type(authors) == array { authors.join(", ") } else { authors }
  page(
    paper: profile.paper,
    flipped: profile.at("page-flipped", default: false),
    columns: 1,
    margin: 20mm,
    background: none,
    foreground: none,
  )[
    #align(center + horizon)[
      #block(width: 85%)[
        #align(center)[
          #text(size: 30pt, weight: "bold")[#profile.at("cover-title", default: "Document Title")]
          #v(8mm)
          #text(size: 16pt)[#profile.at("cover-subtitle", default: "Document Subtitle")]
          #v(25mm)
          #text(size: 12pt)[#author-line]
          #v(4mm)
          #text(size: 11pt)[#profile.at("cover-organization", default: "Organization")]
          #v(12mm)
          #text(size: 10pt)[#profile.at("cover-date", default: datetime.today().display("[year]-[month padding:zero]-[day padding:zero]"))]
        ]
      ]
    ]
  ]
}

// Document configuration and layout engine
#let conf(
  profile: default-profile,
  doc,
) = {
  let is-flipped = profile.at("page-flipped", default: true)
  let page-w = if is-flipped {
    if profile.page-width > profile.page-height { profile.page-width } else { profile.page-height }
  } else {
    if profile.page-width < profile.page-height { profile.page-width } else { profile.page-height }
  }
  let page-h = if is-flipped {
    if profile.page-width < profile.page-height { profile.page-width } else { profile.page-height }
  } else {
    if profile.page-width > profile.page-height { profile.page-width } else { profile.page-height }
  }

  let usable-width = page-w - 2 * profile.page-margin
  let column-width = (
    (usable-width - (profile.column-count - 1) * profile.column-gap) / profile.column-count
  )

  set page(
    paper: profile.paper,
    flipped: is-flipped,
    columns: profile.column-count,
    margin: profile.page-margin,
    background: {
      if profile.column-count > 1 {
        for index in range(1, profile.column-count) {
          let x = (profile.page-margin + index * column-width + (index - 0.5) * profile.column-gap)
          place(
            top + left,
            dx: x,
            dy: profile.page-margin,
            line(
              start: (0pt, 0pt),
              end: (0pt, page-h - 2 * profile.page-margin),
              stroke: profile.column-rule-width + profile.column-rule-color,
            ),
          )
        }
      }
    },
    foreground: context {
      if profile.show-page-number {
        place(
          top + right,
          dx: -profile.page-number-offset.x,
          dy: profile.page-number-offset.y,
          text(
            size: profile.page-number-size,
            fill: profile.page-number-color,
            counter(page).display(),
          ),
        )
      }
    },
  )
  set columns(gutter: profile.column-gap)

  set text(
    font: profile.body-font,
    size: profile.body-size,
    lang: profile.body-lang,
    hyphenate: profile.body-hyphenate,
  )
  set par(
    justify: profile.body-justify,
    leading: profile.body-leading,
    spacing: profile.paragraph-spacing,
  )
  set list(
    marker: (
      profile.list-marker-level-1,
      profile.list-marker-level-2,
      profile.list-marker-level-3,
      profile.list-marker-level-4,
    ),
    indent: profile.list-marker-indent,
    body-indent: profile.list-body-indent,
    spacing: profile.list-spacing,
  )
  set enum(
    indent: profile.list-marker-indent,
    body-indent: profile.list-body-indent,
    spacing: profile.list-spacing,
  )
  show list: set block(above: profile.list-above, below: profile.list-below)
  show enum: set block(above: profile.list-above, below: profile.list-below)
  set heading(numbering: profile.heading-numbering)

  show strong: set text(weight: profile.strong-weight)

  let get-heading-rule(level) = {
    let show-rule = profile.at("heading-" + str(level) + "-show-rule", default: level <= 3)
    let w = profile.at("heading-" + str(level) + "-rule-width", default: none)
    if show-rule and w != none { w } else { none }
  }

  show heading.where(level: 1): it => {
    if profile.at("chapters-new-page", default: false) { pagebreak(weak: true) }
    render-heading(
      it,
      size: profile.heading-1-size,
      above: profile.heading-1-above,
      below: profile.heading-1-below,
      rule-width: get-heading-rule(1),
      profile: profile,
    )
  }
  show heading.where(level: 2): it => render-heading(
    it,
    size: profile.heading-2-size,
    above: profile.heading-2-above,
    below: profile.heading-2-below,
    rule-width: get-heading-rule(2),
    profile: profile,
  )
  show heading.where(level: 3): it => render-heading(
    it,
    size: profile.heading-3-size,
    above: profile.heading-3-above,
    below: profile.heading-3-below,
    rule-width: get-heading-rule(3),
    profile: profile,
  )
  show heading.where(level: 4): it => render-heading(
    it,
    size: profile.heading-4-size,
    above: profile.heading-4-above,
    below: profile.heading-4-below,
    rule-width: get-heading-rule(4),
    profile: profile,
  )

  show raw.where(block: true): it => context {
    let is-true-block = (it.lines.len() > 1) or (it.lang != none) or it.text.contains("\n")
    if not is-true-block {
      // Single-line code without language: render as compact inline box
      let inline-bg = profile.at("code-line-even-bg", default: luma(235))
      let inline-stroke = profile.at("code-inline-stroke", default: 0.35pt + luma(195))
      let inline-inset = profile.at("code-inline-inset", default: (x: 1.8pt, y: 1.5pt))
      let inline-outset = profile.at("code-inline-outset", default: (x: 0pt, y: 0.5pt))
      let inline-radius = profile.at("code-inline-radius", default: 2pt)
      box(
        fill: inline-bg,
        stroke: inline-stroke,
        inset: inline-inset,
        outset: inline-outset,
        radius: inline-radius,
        text(size: profile.code-inline-size, font: profile.code-font, it.text),
      )
    } else {
      let show-nums = profile.at("code-show-line-numbers", default: true)
      let do-indent = profile.at("code-line-indent", default: true)
      let odd-bg = profile.at("code-line-odd-bg", default: luma(240))
      let even-bg = profile.at("code-line-even-bg", default: luma(227))
      let label-text = if it.lang == none {
        none
      } else {
        profile.code-labels.at(it.lang, default: it.lang)
      }
      let title-text = _codebox-title.get()
      let has-title = title-text != none

      let h-pad = if do-indent { profile.code-inset.at("x", default: 1.05mm) } else { 0pt }
      let code-leading = profile.at("code-leading", default: 5.25pt)
      let v-pad = code-leading / 2
      let num-w = 2em

      // 2-Column grid: Column 1 = line numbers (num-w), Column 2 = source code (1fr)
      let col1-w = if show-nums { num-w } else { 0pt }
      let grid-cols = (col1-w, 1fr)

      // Title bar spanning both columns across row 1
      let title-row = if has-title {
        (
          grid.cell(
            colspan: 2,
            fill: odd-bg,
            stroke: (bottom: profile.code-stroke),
            inset: (x: h-pad + if show-nums { 3pt } else { 0pt }, top: v-pad + 1.5pt, bottom: v-pad + 1.5pt),
          )[
            #set text(
              font: profile.at("body-font", default: "Libertinus Serif"),
              size: profile.box-title-size,
              weight: profile.box-title-weight,
              fill: luma(30),
            )
            #title-text
          ],
        )
      } else {
        ()
      }

      // Line mapping over it.lines (2 cells per line for gutter and source)
      let rows = it
        .lines
        .map(line => {
          // When a title bar is present, line 1 alternates background to maintain contrast
          let bg = if has-title {
            if calc.odd(line.number) { even-bg } else { odd-bg }
          } else {
            if calc.odd(line.number) { odd-bg } else { even-bg }
          }
          let badge-clearance = if (line.number == 1 and label-text != none and not has-title) { 45pt } else { 0pt }
          let right-pad = h-pad + badge-clearance

          (
            // Column 1: Line number
            grid.cell(
              fill: bg,
              align: right + top,
              inset: (top: v-pad, bottom: v-pad, left: 0pt, right: 3pt),
            )[
              #if show-nums [
                #text(fill: luma(150), size: 0.78em)[#line.number]
              ]
            ],
            // Column 2: Source code
            grid.cell(
              fill: bg,
              align: left + top,
              inset: (top: v-pad, bottom: v-pad, left: if show-nums { 2pt } else { h-pad }, right: right-pad),
            )[
              #set par(leading: code-leading, spacing: 0pt)
              #highlight-code-line(line.text, it.lang)
            ],
          )
        })
        .flatten()

      let all-rows = title-row + rows

      let grid-elem = grid(
        columns: grid-cols,
        gutter: 0pt,
        ..all-rows
      )

      block(
        width: 100%,
        fill: profile.code-fill,
        stroke: profile.code-stroke,
        inset: 0pt,
        radius: profile.code-radius,
        above: profile.code-above,
        below: profile.code-below,
        clip: true,
      )[
        #set text(size: profile.code-size, font: profile.code-font)
        #grid-elem
        #if label-text != none {
          let badge-dy = if has-title { 2.5pt } else { 2pt }
          place(
            top + right,
            dx: profile.code-label-offset.x,
            dy: badge-dy,
            box(
              fill: profile.code-label-fill,
              stroke: profile.code-label-stroke,
              inset: profile.code-label-inset,
              radius: profile.code-label-radius,
            )[
              #set text(
                size: profile.code-label-size,
                font: profile.code-font,
                weight: profile.code-label-weight,
                fill: profile.at("code-label-color", default: rgb("#581c87")),
              )
              #label-text
            ],
          )
        }
      ]
    }
  }

  show raw.where(block: false): it => context {
    let inline-bg = profile.at("code-line-even-bg", default: luma(235))
    let inline-stroke = profile.at("code-inline-stroke", default: 0.35pt + luma(195))
    let inline-inset = profile.at("code-inline-inset", default: (x: 1.8pt, y: 1.5pt))
    let inline-outset = profile.at("code-inline-outset", default: (x: 0pt, y: 0.5pt))
    let inline-radius = profile.at("code-inline-radius", default: 2pt)
    let eff-lang = if it.lang != none { it.lang } else { "turtle" }

    box(
      fill: inline-bg,
      stroke: inline-stroke,
      inset: inline-inset,
      outset: inline-outset,
      radius: inline-radius,
      text(size: profile.code-inline-size, font: profile.code-font, highlight-code-line(it.text, eff-lang)),
    )
  }

  if profile.at("show-cover", default: false) { cover-page(profile) }

  [
    #_current-profile.update(profile)
    #if profile.at("show-contents", default: false) {
      let title = profile.at("contents-title", default: auto)
      if title == auto {
        title = if profile.body-lang == "de" { [Inhaltsverzeichnis] } else { [Contents] }
      }
      front-matter-title(title, profile)
      outline(title: none, depth: profile.at("contents-depth", default: 2))
    }
    #if profile.at("show-todos-summary", default: false) {
      let title = if profile.body-lang == "de" { [TODO-Übersicht] } else { [TODO Overview] }
      front-matter-title(title, profile)
      render-todo-list(profile: profile)
    }
    #doc
  ]
}
