/// DHBW corporate design theme for [touying](https://typst.app/universe/package/touying).
///
/// ```typst
/// #import "@preview/dhbw-presentation:0.1.0": *
/// #show: dhbw-theme.with(
///   aspect-ratio: "16-9",
///   config-info(
///     subtitle: [Elektrotechnik],
///     author: ("Max Mustermann", "Erika Musterfrau"),
///     date: datetime.today(),
///   ),
/// )
/// = Topic
/// == Slide title
/// - Body
/// ```

#import "@preview/touying:0.7.4": *
#import "palette.typ": *
#import "format.typ": format-date
#import "progress.typ": progress-dots, slide-number, title-marker, chapter-marker

/// DHBW wordmark for the header (`assets/dhbw-wordmark.svg`, claim lines clipped).
#let dhbw-logo(height: 1.3em) = image("../assets/dhbw-wordmark.svg", height: height)

/// Full DHBW logo including the claim lines (title and chapter slides).
#let dhbw-logo-full(height: 3.4em) = image("../assets/dhbw.svg", height: height)

// ---------------------------------------------------------------------------
// Page furniture
// ---------------------------------------------------------------------------

/// Header band: slide title left, wordmark right. Uses the last level-1/2
/// heading, so a slide opened by a topic heading shows that heading.
#let _header(self) = context {
  let title = utils.current-heading(depth: 2)
  let logo = self.store.at("logo", default: none)
  block(width: 100%, height: 3.4em, inset: 0pt, align(horizon, grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    if title == none { [] } else { text(size: 1.1em, fill: dhbw-slate, title.body) },
    if logo == none { [] } else { logo },
  )))
}

/// Left footer line from `config-info`: date · authors · topic, unset parts
/// left out. `dhbw-theme(footer-text: ..)` replaces it, `none` hides it.
#let _footer-line(self) = {
  if "info" not in self { return none }
  let info = self.info
  let parts = ()
  let date = info.at("date", default: none)
  if type(date) == datetime {
    parts.push(format-date(date))
  } else if type(date) in (str, content) {
    parts.push(date)
  }
  let author = info.at("author", default: none)
  if type(author) == array {
    parts.push(author.map(it => [#it]).join([, ]))
  } else if type(author) in (str, content) {
    parts.push(author)
  }
  let topic = self.store.at(
    "footer-topic",
    default: info.at("title", default: none),
  )
  if type(topic) in (str, content) {
    parts.push([#topic])
  }
  if parts == () {
    none
  } else {
    parts
      .map(it => if type(it) == content { it } else { [#it] })
      .join([ #sym.dot ])
  }
}

/// Footer: optional red slide number, the footer line and the topic dots.
///
/// The number counts every logical slide after the title (chapter slides count
/// silently, `#pause` subslides keep their slide's number); the dots count the
/// slides inside a topic group, so the two indicators can differ after a
/// chapter slide. Mode comes from `dhbw-theme(progress: ..)`.
#let _footer(self) = context {
  let mode = self.store.at("progress", default: "dots")
  let line = self.store.at("footer-text", default: auto)
  let line = if line == auto { _footer-line(self) } else { line }
  let number = if mode in ("number", "both") { slide-number() } else { none }
  let dots = if mode in ("dots", "both") { progress-dots() } else { none }
  block(width: 100%, height: 1.2em, inset: 0pt, align(horizon, text(
    size: .42em,
    grid(
      columns: (auto, auto, 1fr, auto),
      column-gutter: .6em,
      align: (horizon + left, horizon + left, horizon + left, horizon + right),
      // the number joins the dot rhythm of the footer line: `3 ⋅ 6. Oktober 2026 …`
      if number == none {
        []
      } else if line == none {
        number
      } else {
        [#number#h(.4em)#text(fill: dhbw-gray)[#sym.dot]]
      },
      if line == none { [] } else { text(fill: dhbw-gray, line) },
      [],
      if dots == none { [] } else { dots },
    ),
  )))
}

// ---------------------------------------------------------------------------
// Sources
// ---------------------------------------------------------------------------

/// Body of the sources slide: a `bibliography(...)` is rendered as-is (its own
/// title dropped), an `array` or `str` becomes a bullet list, other content is
/// passed through unchanged.
#let _sources-content(sources) = {
  if type(sources) == content and sources.func() == bibliography {
    set bibliography(title: none)
    sources
  } else if type(sources) == array {
    sources.map(item => [- #item]).sum(default: none)
  } else if type(sources) == str {
    [- #sources]
  } else {
    sources
  }
}

// ---------------------------------------------------------------------------
// Slides
// ---------------------------------------------------------------------------

/// Default slide of the theme: title band on top, content, footer progress.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(header: _header, footer: _footer),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

/// Shared body of the title and chapter slides: full logo top right, title
/// block in the middle, red web link bottom left. `marker` tags the page for
/// the footer indicators and must stay the first element.
#let _title-style-body(
  self,
  title: none,
  subtitle: none,
  lines: (),
  link-text: auto,
  link-url: auto,
  logo-height: 3.4em,
  marker: none,
) = {
  if marker != none { marker }
  set par(spacing: 0pt)
  let link-text = if link-text == auto {
    self.store.at("link-text", default: [www.dhbw.de])
  } else { link-text }
  let link-url = if link-url == auto {
    self.store.at("link-url", default: "https://www.dhbw.de")
  } else { link-url }
  // Logo top right, pulled into the top margin like in the DHBW template.
  v(24pt - self.store.at("margin-top", default: 3.5em))
  align(right, dhbw-logo-full(height: logo-height))
  v(1fr)
  if title != none {
    text(size: 2.2em, fill: dhbw-slate, title)
  }
  if subtitle != none {
    v(.55em)
    text(size: 1.05em, fill: dhbw-slate, subtitle)
  }
  if lines != () {
    v(1.1em)
    text(
      size: .9em,
      fill: dhbw-gray,
      lines.map(entry => text(entry)).join(linebreak()),
    )
  }
  v(1fr)
  if link-text != none {
    link(link-url, text(fill: dhbw-red, underline(link-text)))
  }
}

/// Title slide in the layout of the DHBW template. All content arguments
/// default to `auto` and resolve against `config-info`, `none` hides them.
///
/// - title, subtitle, author, date: from `config-info`; an author array renders
///   one line per name.
/// - meta (array): extra small grey lines (course, supervisor, ...). Pass plain
///   strings — content is re-parsed as markup.
/// - link-text, link-url (auto): red link bottom left, `auto` from `dhbw-theme`.
/// - logo-height (length): height of the full DHBW logo.
#let title-slide(
  config: (:),
  title: auto,
  subtitle: auto,
  author: auto,
  meta: (),
  date: auto,
  link-text: auto,
  link-url: auto,
  logo-height: 3.4em,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  let from-info(key) = self.info.at(key, default: none)
  let title = if title == auto { from-info("title") } else { title }
  let subtitle = if subtitle == auto { from-info("subtitle") } else { subtitle }
  let author = if author == auto { from-info("author") } else { author }
  let author-lines = if author == none {
    ()
  } else if type(author) == array {
    author
  } else {
    (author,)
  }
  let date = format-date(if date == auto { from-info("date") } else { date })
  let lines = author-lines + meta + if date == none { () } else { (date,) }
  touying-slide(
    self: self,
    config: config,
    _title-style-body(
      self,
      title: title,
      subtitle: subtitle,
      lines: lines,
      link-text: link-text,
      link-url: link-url,
      logo-height: logo-height,
      marker: title-marker,
    ),
  )
})

/// Chapter divider in the layout of the title slide, without presenters, date
/// or subtitle. `dhbw-theme` inserts it before every level-1 heading after the
/// first one.
///
/// - title (content): the chapter title.
/// - config (dictionary): touying configuration for this slide.
/// - link-text, link-url, logo-height: as on `title-slide`.
#let chapter-slide(
  title,
  config: (:),
  link-text: auto,
  link-url: auto,
  logo-height: 3.4em,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  touying-slide(
    self: self,
    config: config,
    _title-style-body(
      self,
      title: title,
      link-text: link-text,
      link-url: link-url,
      logo-height: logo-height,
      marker: chapter-marker,
    ),
  )
})

/// Full-bleed slide in DHBW red for key messages (`background`/`foreground`).
#let focus-slide(
  config: (:),
  background: dhbw-red,
  foreground: dhbw-white,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: background, margin: 1.6em),
    // red on red would be invisible on a full-bleed focus slide
    config-methods(alert: (self: none, body) => text(fill: foreground, body)),
    config,
  )
  set text(fill: foreground, weight: "semibold", size: 1.9em)
  touying-slide(self: self, align(center + horizon, body))
})

// ---------------------------------------------------------------------------
// Title and chapter slides driven by level-1 headings
// ---------------------------------------------------------------------------

#let _is-section(it) = utils.is-heading(it) and it.depth == 1

/// `touying:skip` leaves a heading alone, `touying:unoutlined` marks an
/// appendix (a sources slide).
#let _section-skipped(it) = (
  it.has("label") and str(it.label) in ("touying:unoutlined", "touying:skip")
)

/// Walks the document and inserts a slide in front of every level-1 heading:
/// the first one the title slide (with `auto-title-slide`), every following one
/// a chapter slide (with `chapter-slides`). The heading stays *after* the
/// inserted slide, so touying attaches it to the first content slide of its
/// chapter — the page the footer progress uses as group boundary.
///
/// With a deck title (`config-info(title:)`) the title slide shows *that*
/// title and the first heading gets its own chapter slide, unless both texts
/// are identical. Returns the rebuilt children plus the section titles.
#let _insert-section-slides(
  children,
  auto-title-slide,
  chapter-slides,
  config-title,
  sections,
) = {
  let out = ()
  for child in children {
    if utils.is-styled(child) {
      let (inner, inner-sections) = _insert-section-slides(
        (child.child,),
        auto-title-slide,
        chapter-slides,
        config-title,
        sections,
      )
      if inner != () {
        out.push(utils.reconstruct-styled(child, inner.sum(default: none)))
      }
      sections = inner-sections
    } else if utils.is-sequence(child) {
      let (inner, inner-sections) = _insert-section-slides(
        child.children,
        auto-title-slide,
        chapter-slides,
        config-title,
        sections,
      )
      if inner != () { out.push(inner.sum(default: none)) }
      sections = inner-sections
    } else if _is-section(child) {
      if not _section-skipped(child) {
        if sections == () {
          if auto-title-slide {
            if config-title == none {
              out.push(title-slide(title: child.body))
            } else {
              out.push(title-slide(title: config-title))
              if chapter-slides and config-title != child.body {
                out.push(chapter-slide(child.body))
              }
            }
          }
        } else if chapter-slides {
          out.push(chapter-slide(child.body))
        }
        sections = sections + (child.body,)
      }
      out.push(child)
    } else {
      out.push(child)
    }
  }
  (out, sections)
}

/// Inserts the title and chapter slides of a document body and returns the new
/// body together with the section titles (heading bodies) in document order.
#let _section-slides(body, auto-title-slide, chapter-slides, config-title) = {
  let children = if utils.is-sequence(body) { body.children } else { (body,) }
  let (out, sections) = _insert-section-slides(
    children,
    auto-title-slide,
    chapter-slides,
    config-title,
    (),
  )
  if out == () {
    (body, sections)
  } else {
    (out.sum(default: none), sections)
  }
}

// ---------------------------------------------------------------------------
// Theme
// ---------------------------------------------------------------------------

/// Red edge bar on the left, drawn as page background.
#let _edge-bar(margin-top: 3.5em, width: 15pt, height: 3.7em) = place(
  top + left,
  dy: margin-top - 6pt,
  rect(width: width, height: height, fill: dhbw-red),
)

/// Flattens `body` to an array: `f` is called on every content element and
/// its result is appended, so `f` returns `()` for elements it ignores.
#let _scan(it, f) = {
  if type(it) != content {
    ()
  } else {
    f(it) + it.fields().values().map(v =>
      if type(v) == content { _scan(v, f) } else if type(v) == array {
        v.map(x => if type(x) == content { _scan(x, f) } else { () }).sum(
          default: (),
        )
      } else { () }
    ).sum(default: ())
  }
}

/// True when the deck cites literature: a `@key`/`#cite(<key>)` target that is
/// not a label defined in the body resolves against the bibliography.
#let _bibliography-cited(body) = {
  let targets = _scan(body, it =>
    if it.func() == ref { (it.target,) } else if it.func() == cite {
      (it.key,)
    } else { () })
  let defined = _scan(body, it =>
    if "label" in it.fields() { (it.label,) } else { () })
  targets.any(t => not (t in defined))
}

/// DHBW Stuttgart slide theme.
///
/// ```typst
/// #show: dhbw-theme.with(
///   aspect-ratio: "16-9",
///   primary: dhbw-red,
/// )
/// ```
///
/// - aspect-ratio (string): `"16-9"` or `"4-3"`.
/// - font, code-font, math-font (string): body, code and equation typefaces;
///   `math-font` also backs up body symbols such as `#sym.dot`.
/// - size (length): base font size.
/// - primary (color): accent colour for alerts, rules and the active dot.
/// - margin (dictionary, length): page margins.
/// - logo (content, none): right end of the title band, `auto` for the wordmark.
/// - footer-text (content, auto): footer line, `auto` composes date · authors ·
///   topic from `config-info`.
/// - progress (str, none): footer indicator — `"dots"` (default), `"number"`,
///   `"both"` or `none`.
/// - link-text (content, none), link-url (string): red link bottom left of the
///   title and chapter slides.
/// - auto-title-slide (bool): the first level-1 heading renders the title slide
///   (title from the heading, the rest from `config-info`). With
///   `config-info(title:)` the title slide shows that title instead and the
///   first heading gets a chapter slide — unless both texts are identical.
///   `false` when you call `#title-slide(...)` yourself.
/// - chapter-slides (bool): every later level-1 heading renders a
///   `chapter-slide`. Title and chapter slides have no header or footer.
/// - sources (content, array, str, none): appended as the last slide. Pass
///   `bibliography("quellen.bib")` (cited in the deck) or a list of strings;
///   `none`, an empty list or an uncited bibliography adds nothing (unless
///   `full: true`).
/// - sources-title (content): heading of the appended slide, default `[Quellen]`.
/// - ..args: further touying configurations (`config-info`, `config-common`, ...).
#let dhbw-theme(
  aspect-ratio: "16-9",
  font: dhbw-font,
  code-font: dhbw-code-font,
  math-font: dhbw-math-font,
  size: 24pt,
  primary: dhbw-red,
  margin: (x: 2.2em, top: 3.5em, bottom: 1.5em),
  logo: auto,
  footer-text: auto,
  progress: "dots",
  link-text: [www.dhbw.de],
  link-url: "https://www.dhbw.de",
  auto-title-slide: true,
  chapter-slides: true,
  sources: none,
  sources-title: [Quellen],
  ..args,
  body,
) = {
  assert(
    progress in ("dots", "number", "both", none),
    message: "dhbw-theme progress: \"dots\", \"number\", \"both\" or none",
  )
  let top-margin = if type(margin) == dictionary {
    margin.at("top", default: margin.at("x", default: 3.5em))
  } else { margin }
  let info = args.pos().find(it => type(it) == dictionary and "info" in it)
  let info-title = if info == none { none } else { info.info.at("title", default: none) }
  let deck-title = if type(info-title) in (content, str) { info-title } else { none }
  let (body, sections) = _section-slides(
    body,
    auto-title-slide,
    chapter-slides,
    deck-title,
  )
  let body = if sections == () and auto-title-slide and deck-title != none {
    title-slide() + body
  } else { body }
  // Topic in the footer line: deck title if set, else the title-slide heading.
  let footer-topic = if deck-title != none {
    deck-title
  } else if sections != () {
    sections.first()
  } else {
    none
  }
  // Skip the sources slide when it would say nothing (empty list, uncited
  // bibliography; `full: true` always counts as content).
  let sources-keep = if sources == none {
    false
  } else if type(sources) == array {
    sources.len() > 0
  } else if type(sources) == content and sources.func() == bibliography {
    sources.at("full", default: false) or _bibliography-cited(body)
  } else {
    true
  }
  let body = if not sources-keep { body } else {
    // Built as markup so typst parses `heading.depth` (touying needs it to
    // split slides); the label keeps the slide out of the outline and dots.
    body + [= #sources-title <touying:unoutlined>] + _sources-content(sources)
  }
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: margin,
      header-ascent: 0%,
      footer-descent: 0%,
      background: _edge-bar(margin-top: top-margin),
    ),
    config-common(
      slide-fn: slide,
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-methods(
      init: (self: none, body) => {
        // The maths font doubles as body fallback: Source Sans 3 lacks symbols
        // such as `#sym.dot` and would pull in an arbitrary serif font.
        let text-font = if type(font) == array {
          if math-font in font { font } else { font + (math-font,) }
        } else {
          (font, math-font)
        }
        set text(font: text-font, size: size, lang: "de", fill: dhbw-slate)
        show raw: set text(font: code-font)
        show math.equation: set text(font: math-font)
        show footnote.entry: set text(size: .6em)

        show heading.where(level: 3): set text(
          size: 1.05em,
          weight: "bold",
          fill: dhbw-slate,
        )
        show heading.where(level: 4): set text(
          size: .95em,
          weight: "semibold",
          fill: dhbw-gray,
        )
        show heading: set block(above: 1.15em, below: .55em)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      neutral-light: dhbw-gray,
      neutral-lightest: dhbw-white,
      neutral-darkest: dhbw-ink,
      primary: primary,
    ),
    config-store(
      logo: if logo == auto { dhbw-logo() } else { logo },
      footer-text: footer-text,
      progress: progress,
      link-text: link-text,
      link-url: link-url,
      margin-top: top-margin,
      footer-topic: footer-topic,
    ),
    ..args,
  )

  body
}
