//
// APA 7th Edition Style for Pergamon
// Based on the Publication Manual of the American Psychological Association (2020)
// and the official apa.csl specification
//

#import "@preview/pergamon:0.8.0": *
#import "@preview/oxifmt:1.0.0": strfmt

// ============================================================================
// CITATION STYLE
// ============================================================================

/// Helper to concatenate author names with APA-appropriate delimiters.
#let _apa7-concat-names(
  names,
  narrative: false,
  maxnames: 2,
  minnames: 1,
  etal-str: "et al.",
) = {
  if names == none or names.len() == 0 { return "" }

  let etal = names.len() > maxnames and names.len() > minnames
  let num-names = if etal { calc.min(minnames, names.len()) } else { names.len() }

  // APA 7th: "and" for narrative, "&" for parenthetical
  let two-delim = if narrative { " and " } else { " & " }
  let many-delim = if narrative { ", and " } else { ", & " }

  if etal {
    let nn = names.slice(0, num-names).join(", ")
    nn + " " + etal-str
  } else if names.len() == 1 {
    names.at(0)
  } else if names.len() == 2 {
    names.at(0) + two-delim + names.at(1)
  } else {
    names.join(", ", last: many-delim)
  }
}

/// Helper to remove trailing period if present
#let _no-trailing-period(content) = {
  let text-str = repr(content)
  if text-str.ends-with(".]") or text-str.ends-with(".") {
    // Strip trailing period to avoid double period before DOI/URL
    let stripped = text-str.trim(".", at: end)
    eval(stripped)
  } else {
    content
  }
}

/// Creates an APA 7th edition citation style for in-text citations.
#let format-citation-apa7(
  format-parens: nn(it => [(#it)]),
  citation-separator: "; ",
  prefix-separator: " ",
  suffix-separator: ", ",
  maxnames: 2,
  minnames: 1,
  etal-str: "et al.",
  nodate-str: "n.d.",
) = {
  let is-year-defined(reference) = {
    let pd = reference.fields.at("parsed-date", default: none)
    pd != none and "year" in pd
  }

  let get-family-names(parsed-names) = {
    if parsed-names == none { none } else { parsed-names.map(it => it.at("family", default: "")) }
  }

  let formatter(reference-dict, form) = {
    let (family-names, year, extradate) = reference-dict.reference.at("label")
    let year-defined = is-year-defined(reference-dict.reference)
    let narrative = form in ("t", "g", "name")

    let authors-str = _apa7-concat-names(
      family-names,
      narrative: narrative,
      maxnames: maxnames,
      minnames: minnames,
      etal-str: etal-str,
    )

    let extradate-fmt = if extradate == none { "" } else if year-defined { extradate } else if (
      form in ("t", "g", "p", auto)
    ) { [[#extradate]] } else { [(#extradate)] }

    if form == "name" { authors-str } else if form == "year" { [#year#extradate-fmt] } else if form == "t" {
      [#authors-str #format-parens([#year#extradate-fmt])]
    } else if form == "g" { [#authors-str\'s #format-parens(year)] } else if form == "n" {
      [#authors-str, #year#extradate-fmt]
    } else { format-parens([#authors-str, #year#extradate-fmt]) }
  }

  let list-formatter(reference-dicts, form, options) = {
    let prefix = options.at("prefix", default: none)
    let suffix = options.at("suffix", default: none)
    let individual-form = if form == "p" or form == auto { "n" } else { form }

    let individual-citations = reference-dicts.map(x => {
      if type(x) == str { [*?#x?*] } else {
        let lbl = x.at(0)
        let reference = x.at(1)
        link(label(lbl), formatter(reference, individual-form))
      }
    })

    let joined = individual-citations.join(citation-separator)
    let with-prefix = if prefix != none { [#prefix#prefix-separator#joined] } else { joined }
    let with-affixes = if suffix != none { [#with-prefix#suffix-separator#suffix] } else { with-prefix }

    if form == "p" or form == auto { format-parens(with-affixes) } else { with-affixes }
  }

  let label-generator(index, reference) = {
    let labelname = get-family-names(reference.fields.labelname)
    let pd = reference.fields.at("parsed-date", default: none)
    let year = if pd != none and "year" in pd { str(pd.year) } else { nodate-str }

    let extradate = if "extradate" in reference.fields {
      numbering("a", reference.fields.extradate + 1)
    } else { none }

    let lbl = (labelname, year, extradate)
    let authors-str = _apa7-concat-names(
      labelname,
      narrative: false,
      maxnames: maxnames,
      minnames: minnames,
      etal-str: etal-str,
    )
    let lbl-repr = strfmt("{}, {}{}", authors-str, year, if extradate != none { extradate } else { "" })

    (lbl, lbl-repr)
  }

  (
    "format-citation": list-formatter,
    "label-generator": label-generator,
    "reference-label": (index, reference) => none,
  )
}

// ============================================================================
// REFERENCE FORMATTING HELPERS
// ============================================================================

/// Format author names for reference list per APA 7th
/// Format: Family, G. M., Family, G. M., & Family, G. M.
/// For 21+ authors: First 19, ... Last
#let _format-apa7-authors(parsed-authors) = {
  if parsed-authors == none or parsed-authors.len() == 0 { return none }

  let format-one-name(d) = {
    let family = d.at("family", default: "")
    let given = d.at("given", default: "")
    // Initialize with ". " per CSL initialize-with
    let initials = given
      .split(regex("[ -]"))
      .map(n => {
        if n.len() > 0 { n.at(0) + ". " } else { "" }
      })
      .join("")
      .trim()
    if initials.len() > 0 {
      family + ", " + initials
    } else {
      family
    }
  }

  let names = parsed-authors.map(format-one-name)

  if names.len() == 1 {
    names.at(0)
  } else if names.len() == 2 {
    // Two authors: Family, G. M., & Family, G. M.
    names.at(0) + ", & " + names.at(1)
  } else if names.len() <= 20 {
    // 3-20 authors: all names with comma before &
    names.slice(0, -1).join(", ") + ", & " + names.last()
  } else {
    // 21+ authors: first 19, ... last (APA 9.8)
    names.slice(0, 19).join(", ") + ", . . . " + names.last()
  }
}

/// Format date for reference list
/// Articles/books: just year
/// Magazines/newspapers/blogs: year, month day
#let _format-apa7-date(parsed-date, entry-type) = {
  if parsed-date == none or "year" not in parsed-date {
    return "n.d."
  }

  let year = str(parsed-date.year)

  // Full dates for ephemeral sources (APA 9.14)
  let needs-full-date = (
    entry-type
      in (
        "article-magazine",
        "article-newspaper",
        "post",
        "post-weblog",
        "webpage",
        "broadcast",
        "speech",
        "event",
        "interview",
      )
  )

  if not needs-full-date or "month" not in parsed-date {
    return year
  }

  let month-names = (
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  )

  let month = parsed-date.month
  let month-str = if type(month) == int and month >= 1 and month <= 12 {
    month-names.at(month - 1)
  } else {
    str(month)
  }

  if "day" in parsed-date {
    year + ", " + month-str + " " + str(parsed-date.day)
  } else {
    year + ", " + month-str
  }
}

/// Format DOI as URL (APA 9.34-36)
/// APA 9.35: Do not add a period after DOI/URL
#let _format-apa7-doi(doi) = {
  if doi == none { return none }
  let url = "https://doi.org/" + doi
  link(url, url)
}


/// Format URL (APA 9.34-36)
#let _format-apa7-url(url-str) = {
  if url-str == none { return none }
  link(url-str, url-str)
}

// ============================================================================
// REFERENCE DRIVERS
// ============================================================================

/// APA 7th article driver
/// Format: Author. (Year). Title. Journal, Volume(Issue), Pages. DOI
#let _driver-article-apa7(reference, options) = {
  let fd(fld) = reference.fields.at(fld, default: none)

  // Author
  let author = _format-apa7-authors(fd("parsed-author"))

  // Date
  let date = _format-apa7-date(fd("parsed-date"), reference.entry_type)

  // Title (no quotes, no italics for articles)
  let title = fd("title")
  if title != none {
    // Link title to DOI if available
    if fd("doi") != none and options.link-titles {
      title = link("https://doi.org/" + fd("doi"))[#title]
    } else if fd("url") != none and options.link-titles {
      title = link(fd("url"))[#title]
    }
  }

  // Journal (italics)
  let journal = fd("journaltitle")
  if journal == none { journal = fd("journal") }

  // Volume (italics) and Issue
  let volume = fd("volume")
  let issue = fd("number")
  if issue == none { issue = fd("issue") }

  // Pages (no "pp." for journals)
  let pages = fd("pages")

  // DOI/URL (not linked if title is already linked)
  let identifier = if fd("doi") != none and not options.link-titles {
    _format-apa7-doi(fd("doi"))
  } else if fd("url") != none and not options.link-titles {
    _format-apa7-url(fd("url"))
  } else if fd("doi") != none {
    // DOI exists but title is linked - still show DOI
    _format-apa7-doi(fd("doi"))
  } else {
    none
  }

  // Build source: Journal, Volume(Issue), Pages
  let source-parts = ()
  if journal != none { source-parts.push(emph(journal)) }
  if volume != none {
    if issue != none {
      source-parts.push(emph(volume) + [(#issue)])
    } else {
      source-parts.push(emph(volume))
    }
  }
  if pages != none { source-parts.push(pages) }

  // Assemble: Author. (Date). Title. Source. DOI
  let author-date = if author != none and date != none {
    [#author (#date).]
  } else if author != none {
    [#author.]
  } else if date != none {
    [(#date).]
  } else {
    none
  }

  let title-part = if title != none { [#title.] } else { none }

  // Source ends with period only if no DOI/URL follows
  let source-part = if source-parts.len() > 0 {
    if identifier != none {
      source-parts.join(", ") + [.] // Period before DOI
    } else {
      source-parts.join(", ") + [.] // Final period
    }
  } else { none }

  // Join with spaces - DOI/URL has no trailing period per APA
  let result = ()
  if author-date != none { result.push(author-date) }
  if title-part != none { result.push(title-part) }
  if source-part != none { result.push(source-part) }
  if identifier != none { result.push(identifier) }

  result.join(" ")
}

/// APA 7th book driver
/// Format: Author. (Year). Title (Edition). Publisher. DOI
#let _driver-book-apa7(reference, options) = {
  let fd(fld) = reference.fields.at(fld, default: none)

  let author = _format-apa7-authors(fd("parsed-author"))
  if author == none {
    // Fall back to editor
    let editors = _format-apa7-authors(fd("parsed-editor"))
    if editors != none {
      let label = if fd("parsed-editor") != none and fd("parsed-editor").len() > 1 { "Eds." } else { "Ed." }
      author = editors + " (" + label + ")"
    }
  }

  let date = _format-apa7-date(fd("parsed-date"), reference.entry_type)
  let title = fd("title")

  // Title in italics for books
  if title != none {
    if fd("doi") != none and options.link-titles {
      title = emph(link("https://doi.org/" + fd("doi"))[#title])
    } else if fd("url") != none and options.link-titles {
      title = emph(link(fd("url"))[#title])
    } else {
      title = emph(title)
    }
  }

  // Edition
  let edition = fd("edition")
  let title-with-edition = if edition != none and title != none {
    [#title (#edition ed.)]
  } else {
    title
  }

  let publisher = fd("publisher")

  let identifier = if fd("doi") != none {
    _format-apa7-doi(fd("doi"))
  } else if fd("url") != none {
    _format-apa7-url(fd("url"))
  } else { none }

  let author-date = if author != none and date != none {
    [#author (#date).]
  } else if author != none {
    [#author.]
  } else if date != none {
    [(#date).]
  } else {
    none
  }

  let result = ()
  if author-date != none { result.push(author-date) }
  if title-with-edition != none { result.push([#title-with-edition.]) }
  if publisher != none { result.push([#publisher.]) }
  if identifier != none { result.push(identifier) }

  let output = result.join(" ")
  if identifier != none { _no-trailing-period(output) } else { output }
}

/// APA 7th chapter/incollection driver
/// Format: Author. (Year). Chapter title. In Editor (Ed.), Book title (pp. Pages). Publisher. DOI
#let _driver-chapter-apa7(reference, options) = {
  let fd(fld) = reference.fields.at(fld, default: none)

  let author = _format-apa7-authors(fd("parsed-author"))
  let date = _format-apa7-date(fd("parsed-date"), reference.entry_type)

  // Chapter title (no italics)
  let title = fd("title")
  if title != none and fd("doi") != none and options.link-titles {
    title = link("https://doi.org/" + fd("doi"))[#title]
  }

  // Editor
  let editor-names = fd("parsed-editor")
  let editor = if editor-names != none and editor-names.len() > 0 {
    let eds = editor-names.map(d => {
      let given = d.at("given", default: "")
      let family = d.at("family", default: "")
      let initials = given.split(regex("[ -]")).map(n => if n.len() > 0 { n.at(0) + ". " } else { "" }).join("").trim()
      initials + " " + family
    })
    let label = if eds.len() > 1 { "Eds." } else { "Ed." }
    if eds.len() == 1 { eds.at(0) + " (" + label + ")" } else if eds.len() == 2 {
      eds.at(0) + " & " + eds.at(1) + " (" + label + ")"
    } else { eds.slice(0, -1).join(", ") + ", & " + eds.last() + " (" + label + ")" }
  } else { none }

  // Book title (italics)
  let booktitle = fd("booktitle")
  if booktitle != none { booktitle = emph(booktitle) }

  // Pages with pp. prefix for chapters
  let pages = fd("pages")
  let pages-str = if pages != none {
    if pages.contains("-") or pages.contains("–") { "(pp. " + pages + ")" } else { "(p. " + pages + ")" }
  } else { none }

  let publisher = fd("publisher")

  let identifier = if fd("doi") != none {
    _format-apa7-doi(fd("doi"))
  } else if fd("url") != none {
    _format-apa7-url(fd("url"))
  } else { none }

  // Build "In Editor (Ed.), Book title (pp. Pages)"
  let in-parts = ()
  if editor != none { in-parts.push(editor + ",") }
  if booktitle != none { in-parts.push(booktitle) }
  if pages-str != none { in-parts.push(pages-str) }
  let in-clause = if in-parts.len() > 0 { [In ] + in-parts.join(" ") } else { none }

  let author-date = if author != none and date != none {
    [#author (#date).]
  } else if author != none {
    [#author.]
  } else if date != none {
    [(#date).]
  } else {
    none
  }

  let result = ()
  if author-date != none { result.push(author-date) }
  if title != none { result.push([#title.]) }
  if in-clause != none { result.push([#in-clause.]) }
  if publisher != none { result.push([#publisher.]) }
  if identifier != none { result.push(identifier) }

  result.join(" ")
}

// ============================================================================
// REFERENCE FORMATTER
// ============================================================================

/// Creates an APA 7th edition reference formatter for bibliographies.
/// This is a custom implementation that does NOT add trailing periods
/// (APA 9.35: "Do not add a period after a DOI or URL").
#let format-reference-apa7(
  reference-label: none,
  link-titles: true,
) = {
  // Build options dictionary for drivers
  let options = (
    link-titles: link-titles,
  )

  // Map entry types to drivers
  let drivers = (
    "article": _driver-article-apa7,
    "book": _driver-book-apa7,
    "incollection": _driver-chapter-apa7,
    "inbook": _driver-chapter-apa7,
  )

  // Default driver for unknown types - uses article format
  let default-driver = _driver-article-apa7

  // Return a formatter function compatible with Pergamon's print-bibliography
  let formatter(index, reference) = {
    let entry-type = lower(reference.entry_type)
    let driver = drivers.at(entry-type, default: default-driver)

    // Call driver to get formatted content (no trailing period added)
    let content = driver(reference, options)

    // Return as single-element array (Pergamon expects array for multi-column support)
    // parbreak needed for hanging indent to work on each entry
    ([#parbreak()#content],)
  }

  formatter
}

// ============================================================================
// CONVENIENCE FUNCTIONS
// ============================================================================

/// Set up a complete APA 7th style.
///
/// Returns a style bundle compatible with Pergamon 0.8.0's
/// `refsection(style: ...)` API.
#let apa7-style() = {
  let cit = format-citation-apa7()
  let ref-formatter = format-reference-apa7(
    reference-label: cit.reference-label,
  )

  (
    citation-style: cit.format-citation,
    reference-style: ref-formatter,
    label-generator: cit.label-generator,
  )
}

/// Print an APA 7th formatted bibliography with proper layout.
///
/// When called inside a `refsection(style: apa7-style())`, the format-reference
/// and label-generator are resolved automatically from the style bundle state.
///
/// APA 7th requires:
/// - Hanging indent: 0.5 inches
/// - Double line spacing (within entries)
/// - No extra space between entries (entry-spacing="0" in CSL)
#let print-apa7-bibliography(
  style,
  title: none,
  ..args,
) = {
  context {
    // Match row-gutter to document's leading so entries have same spacing as lines
    let current-leading = par.leading
    print-bibliography(
      format-reference: style.reference-style,
      label-generator: style.label-generator,
      sorting: "nyt",
      title: title,
      grid-style: (row-gutter: current-leading),
      ..args,
    )
  }
}
