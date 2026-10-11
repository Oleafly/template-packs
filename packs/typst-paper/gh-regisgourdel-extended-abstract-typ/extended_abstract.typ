// extended_abstract.typ: a template for good-looking conference submissions
// that require an extended abstract of a few pages.
// The template is based on the stellar-springer-nature template, and on the
// wordometer package, to display word numbers, as a limit is often imposed by
// submission guidelines.


#let dictionary-sum(a, b) = {
  let c = (:)
  for k in (a.keys() + b.keys()).dedup() {
    c.insert(k, a.at(k, default: 0) + b.at(k, default: 0))
  }
  c
}

/// Get a basic word count from a string.
///
/// Returns a dictionary with keys:
/// - `characters`: Number of non-whitespace characters.
/// - `words`: Number of words, defined by `regex("\b[\w'’]+\b")`.
/// - `sentences`: Number of sentences, defined by `regex("\w+\s*[.?!]")`.
///
/// - string (string):
/// -> dictionary | int
#let string-word-count(string) = (
  string.matches(regex("[\p{Han}]|\b[[\w--\p{Han}]'’.,\-]+\b")).len()
)

/// Simplify an array of content by concatenating adjacent text elements.
///
/// Doesn't preserve content exactly; `smartquote`s are replaced with `'` or
/// `"`. This is used on `sequence` elements because it improves word counts for
/// cases like "Digby's", which should count as one word.
///
/// For example, the content #rect[Qu'est-ce *que* c'est !?] is structured as:
///
/// #[Qu'est-ce *que* c'est !?].children
///
/// - children (array): Array of content to simplify.
#let concat-adjacent-text(children) = {
  if children.len() == 0 { return () }
  let squashed = (children.at(0),)

  let as-text(el) = {
    let fn = repr(el.func())
    if fn == "text" { el.text }
    else if fn == "space" { " " }
    else if fn in "linebreak" { "\n" }
    else if fn in "parbreak" { "\n\n" }
    else if fn in "pagebreak" { "\n\n\n\n" }
    else if fn == "smartquote" {
      if el.double { "\"" } else { "'" }
    }
  }

  let last-text = as-text(squashed.at(-1))
  for child in children.slice(1) {
    // don't squash labelled sequences. the label should be
    // preserved because it might be used to exclude elements
    let has-label = child.at("label", default: none) != none
    if has-label {
      squashed.push(child)
      last-text = none
      continue
    }
    let this-text = as-text(child)
    let merge-with-last = last-text != none and this-text != none

    if merge-with-last {
      // squash into last element
      last-text = last-text + this-text
      squashed.at(-1) = text(last-text)
    } else {
      // add new element
      last-text = this-text
      squashed.push(child)
    }
  }
  squashed
}

#let IGNORED_ELEMENTS = (
  "bibliography", "cite", "display", "equation", "h", "hide", "image",
  "line", "linebreak", "locate", "metadata", "pagebreak", "parbreak",
  "path", "polygon", "ref", "repeat", "smartquote", "space", "style",
  "update", "v",
)

#let parse-basic-where-selector(selector) = {
  let match = repr(selector).match(regex("^([\w]+)\.where(.*)$"))
  if match == none {
    panic("Only `element.where(key: value, ..)` selectors are supported.")
  }
  let (element-fn, fields) = match.captures
  (element-fn: element-fn, fields: eval(fields))
}

#let interpret-exclude-patterns(exclude) = {
  exclude.map(element-fn => {
    if type(element-fn) in (str, label, dictionary) { element-fn }
    else if type(element-fn) == function { repr(element-fn) }
    else if type(element-fn) == selector {
      parse-basic-where-selector(element-fn)
    } else {
      panic("Exclude patterns must be element functions, strings, or labels; got:", element-fn)
    }
  })
}


/// Traverse a content tree and apply a function to textual leaf nodes.
///
/// Descends into elements until reaching a textual element (`text` or `raw`)
/// and calls `f` on the contained text, returning a (nested) array of all the
/// return values.
///
/// - f (function): Unary function to pass text to.
/// - content (content): Content element to traverse.
/// - exclude (array): Content to skip while traversing the tree, specified by:
///   - name, e.g., `"heading"`
///   - function, e.g., `heading`
///   - selector, e.g., `heading.where(level: 1)` (only basic `where` selectors
///     are supported)
///   - label, e.g., `<no-wc>`
///  Default value includes equations and elements without child content or
///  text.
///
///  To exclude figures, but include figure captions, pass the name
///  `"figure-body"` (which is not a real element). To include figure bodies,
///  but exclude their captions, pass the name `"caption"`.
#let map-tree(f, content, exclude: IGNORED_ELEMENTS) = {
  if content == none { return none }
  let exclude = interpret-exclude-patterns(exclude)
  let map-subtree = map-tree.with(f, exclude: exclude)

  let fn = repr(content.func())
  let fields = content.fields().keys()

  let exclude-selectors = exclude.filter(e => type(e) == dictionary and "element-fn" in e)
  for (element-fn, fields) in exclude-selectors {
    // panic(exclude-selectors, content)
    if fn == element-fn {
      if not fields.pairs().any(((key, value)) => content.at(key, default: value) != value) {
        return none
      }
    }
  }

  if fn in exclude {
    none

  // check if element has a label that is excluded
  } else if content.at("label", default: none) in exclude {
    none
  } else if fn in ("text", "raw") {
    f(content.text)
  } else if "children" in fields {
    let children = content.children

    if fn == "sequence" {
      // don't do this for, e.g., grid or stack elements
      children = concat-adjacent-text(children)
    }
    children
      .map(map-subtree)
      .filter(x => x != none)
  } else if fn == "figure" {
    (
      if "figure-body" not in exclude { map-subtree(content.body) },
      if "caption" in content.fields() { map-subtree(content.caption) },
    ).filter(x => x != none)
  } else if fn == "styled" {
    map-subtree(content.child)
  } else if "body" in fields {
    map-subtree(content.body)
  } else {
    none
  }
}

/// Extract plain text from content
///
/// This is a quick-and-dirty conversion which does not preserve styling or
/// layout and which may introduces superfluous spaces.
/// - content (content): Content to extract plain text from.
/// - ..options ( ): Additional named arguments:
///   - `exclude`: Content to exclude (see `map-tree()`). Can be an array of
///     element functions, element function names, or labels.
#let extract-text(content, ..options) = {
  if type(content) == str { return content }
  let out = (map-tree(x => x, content, ..options),).flatten().join(" ")
  out + "" // ensures none becomes empty string
}

/// Get word count statistics of a content element.
///
/// Returns the total number of words in the content.
///
/// - content (content):
/// -> int
/// - exclude (array): Content to exclude from word count (see `map-tree()`).
///  Can be an array of element functions, element function names, or labels.
/// - counter (fn): A function that accepts a string and returns a dictionary of
///  counts.
///
///  For example, to count vowels, you might do:
///
///  ```typ
///  #word-count-of([ABCDEFG], counter: s => (
///      vowels: lower(s).matches(regex("[aeiou]")).len(),
///  ))
///  ```
#let word-count-of(content,exclude: (), counter: string-word-count) = {
  let exclude = IGNORED_ELEMENTS + (exclude,).flatten()
  counter(extract-text(content, exclude: exclude))
}

// These are a couple of shortcuts I use for citations. The first looks like
// the LaTeX citet, and the second like citep. Feel free to import or not.
#let tcite = cite.with(style: "chicago-author-date", form: "prose")
#let pcite = cite.with(style: "chicago-author-date")

/// The main article template function. Apply via a show rule:
/// ```typ
/// #show: article.with(title: [...], authors: (...), ...)
/// ```
///
/// - title (content): The article title.
/// - short-title (content): Short title for running page headers (optional).
/// - authors (array): Array of author dictionaries with keys:
///   `name` (str), `affiliations` (array of int), `email` (str, optional),
///   `corresponding` (bool, optional), `equal-contrib` (str, optional),
///   `orcid` (str, optional).
/// - affiliations (array): Array of affiliation dictionaries with keys:
///   `id` (int), `department` (str, optional), `institution` (str),
///   `address` (str, optional).
/// - abstract (content): The article abstract.
/// - keywords (array): Array of keyword strings.
/// - pacs (content): PACS classification codes (optional).
/// - msc (content): MSC classification codes (optional).
/// - body (content): The document body.
/// -> content
#let article(
  title: none,
  header: none,
  subtitle: none,
  short-title: none,
  authors: (),
  affiliations: (),
  summary: none,
  keywords: (),
  disclaimer: none,
  pacs: none,
  msc: none,
  jel: none,
  show_counts: false,
  mainfont: "Crimson Pro",
  monofont: "Consolas",
  body,
) = {

  // --- PDF metadata ---
  set document(
    title: if title != none { title } else { [] },
    author: authors.map(a => a.name),
    keywords: keywords,
  )

  // --- Page setup (single-column, matching sn-jnl class) ---
  set page(
    paper: "a4",
    margin: (
      top: 25mm,
      bottom: 25mm,
      left: 25mm,
      right: 25mm,
    ),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        set text(size: 10pt, fill: rgb("#303030"))
        emph(if short-title != none { short-title } else { title })
        h(1fr)
        str(page-num)
      }
    },
    // The disclaimer is displayed only in the footer of the first page
    footer: context {
      if counter(page).get().first() == 1 and disclaimer != none {
        block(width: auto, height: auto, stroke: (top: gray), inset: 4pt,
              text(size: 10pt, fill: navy, disclaimer))
      }
    },
  )

  // --- Base typography ---
  set text(
    font: mainfont,
    size: 11pt,
    lang: "en",
  )
  set par(justify: true, leading: 0.75em, first-line-indent: 1.5em)

  // --- Heading styles (standard numbered: 1, 1.1, 1.1.1) ---
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    set text(size: 12pt, weight: "bold")
    set par(first-line-indent: 0pt)
    v(1.2em)
    block[#counter(heading).display("1") #it.body]
    v(0.6em)
  }

  // Unnumbered headings (for Declarations, etc.)
  show heading.where(numbering: none, level: 1): it => {
    set text(size: 12pt, weight: "bold")
    set par(first-line-indent: 0pt)
    v(1.2em)
    block[#it.body]
    v(0.6em)
  }

  // --- Figure/table captions ---
  show figure.where(kind: image): set figure(supplement: [Figure])
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure.caption: it => {
    set text(size: 10pt, style: "italic")
    set par(first-line-indent: 0pt)
    [*#it.supplement #it.counter.display()*: #h(0.3em) #it.body]
  }

  // --- Table styling (booktabs-style: top/bottom rules, no vertical) ---
  set table(
    stroke: none,
    inset: (x: 6pt, y: 4pt),
  )

  // --- Equations ---
  set math.equation(numbering: "(1)")

  // ========================================
  // TITLE BLOCK
  // ========================================
  {
    set par(first-line-indent: 0pt)

    if header != none {
        text(size: 11pt, weight: "medium", style: "oblique", fill: rgb("#484848ff"), header)
        v(12pt)
      }

    // Title
    align(center, {
      text(size: 17pt, weight: "bold", fill: rgb("#1763b5ff"), title)
      if subtitle != none {
        v(4pt)
        text(size: 14pt, weight: "semibold", subtitle)
      }
    })
    v(16pt)

    // Authors
    if authors.len() > 0 {
      set text(size: 11pt)
      let author-parts = authors.map(a => {
        let name = text(weight: "medium", a.name)
        let sups = a.affiliations.map(n => str(n)).join(",")
        let result = [#name#super(sups)]
        if a.at("corresponding", default: false) {
          result = [#result#super("†")]
        }
        result
      })
      align(center, author-parts.join[ #h(0.3em) #sym.dot.c #h(0.3em) ])
    }
    v(12pt)

    // Equal contribution note
    {
      let equal = authors.filter(a => a.at("equal-contrib", default: none) != none)
      if equal.len() > 0 {
        set text(size: 9pt, style: "italic")
        align(center, equal.first().at("equal-contrib"))
        v(6pt)
      }
    }

    // Affiliations
    if affiliations.len() > 0 {
      set text(size: 9pt)
      for aff in affiliations {
        let parts = ()
        if aff.at("department", default: none) != none { parts.push(aff.department) }
        parts.push(aff.institution)
        if aff.at("address", default: none) != none { parts.push(aff.address) }
        align(center)[
          #super(str(aff.id))#parts.join(", ")
        ]
      }
    }
    v(8pt)

    // Corresponding author email
    {
      let corresponding = authors.filter(a =>
        a.at("corresponding", default: false) and a.at("email", default: none) != none
      )
      if corresponding.len() > 0 {
        set text(size: 9pt)
        let c = corresponding.first()
        align(center)[
          #super("*")Corresponding author: #link("mailto:" + c.email, text(
            font: monofont, size: 8pt, fill: rgb("#555599"), c.email)
            )
        ]
      }
    }
    v(16pt)

    // Summary
    if summary != none {
      set text(size: 10pt)
      pad(left: 15pt, right: 15pt, {
        text(weight: "bold")[Summary: ]
        summary
      })
      v(8pt)
    }

    // Keywords
    if keywords.len() > 0 {
      set text(size: 9pt)
      pad(left: 15pt, right: 15pt, {
        text(weight: "bold")[Keywords: ]
        keywords.join[ #sym.dot.c ]
      })
    }
    v(4pt)

    let classf_disp(class_type, class_codes) = {
      set text(size: 10pt)
      pad(left: 15pt, right: 15pt, {
        text(weight: "bold", class_type)
        text(weight: "bold")[: ]
        class_codes
      })
      v(4pt)
    }

    // PACS / MSC classification
    if pacs != none { classf_disp([PACS], pacs) }
    if msc != none  { classf_disp([MSC], msc) }
    if jel != none  { classf_disp([JEL], jel) }

    line(length: 100%, stroke: 0.5pt)
    v(8pt)
  }

  // ========================================
  // BODY
  // ========================================
  body

  let nws = word-count-of(summary)
  let nwb = word-count-of(body)
  
  if show_counts {
    v(8pt)
    block(
      fill: luma(230),
      inset: 8pt,
      radius: 4pt,
      text(font: monofont, fill: rgb("#EE3333"), weight: "semibold")[
        Words in summary: #nws \
        Words in text body: #nwb
      ]
    )
  }
}
