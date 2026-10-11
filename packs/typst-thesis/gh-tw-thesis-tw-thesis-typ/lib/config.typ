#import "util.typ": align-of, date, merge

// Keys a school preset must set; they have no sensible default.
#let school-keys = ("university", "university-en")

// Keys describing one thesis, allowed only in the user's config.
#let thesis-keys = (
  "school",
  "title",
  "title-en",
  "author",
  "author-en",
  "id",
  "advisor",
  "advisor-en",
  "college",
  "college-en",
  "institute",
  "institute-en",
  "degree",
  "degree-en",
  "type",
  "type-en",
  "date",
  "oral-date",
  "keywords",
  "keywords-en",
)

// Every key in `over` must exist in `schema` (default.yml), recursively, so a
// misspelt key fails loudly instead of being ignored. `extra` lists top-level
// keys allowed on top of the schema.
#let check(over, schema, file, extra: (), prefix: "") = {
  for (k, v) in over {
    let name = prefix + k
    if prefix == "" and k in extra { continue }
    if k not in schema {
      panic(file + ": unknown key `" + name + "` (see schools/default.yml)")
    }
    let s = schema.at(k)
    if type(s) == dictionary {
      if type(v) != dictionary {
        panic(file + ": `" + name + "` must be a table of keys")
      }
      check(v, s, file, prefix: name + ".")
    } else if type(v) == dictionary {
      panic(file + ": `" + name + "` must be a single value, not a table")
    }
  }
}

// Splices i18n/en.yml's `strings` keys into i18n/zh.yml's as `xxx-en`, giving
// the xxx/xxx-en dict shape schools/default.yml's `strings:` (and every
// school preset override) expects.
#let i18n-strings(i18n: "/i18n/") = {
  let zh = yaml(i18n + "zh.yml").strings
  let en = yaml(i18n + "en.yml").strings
  for (k, v) in en { zh.insert(k + "-en", v) }
  zh
}

// Reads the `YAML`and applies units, so the template can index the result
// directly. Defaults come only from schools/default.yml.
#let load(path, schools: "/schools/") = {
  let base = yaml(schools + "default.yml")
  base.strings = (: ..base.strings, ..i18n-strings())
  let user = yaml(path)
  check(user, base, path, extra: thesis-keys + school-keys)

  let cfg = base
  if "school" in user {
    let file = schools + user.school + ".yml"
    let school = yaml(file)
    check(school, base, file, extra: school-keys)
    for k in school-keys {
      if k not in school { panic(file + ": missing required key `" + k + "`") }
    }
    cfg = merge(cfg, school)
  }
  cfg = merge(cfg, user)

  let l = cfg.layout
  let h = l.heading
  let caption-position = l
    .caption-position
    .pairs()
    .map(((kind, position)) => {
      assert(position in ("top", "bottom"), message: "layout.caption-position." + kind + ": expected top or bottom")
      (kind, if position == "top" { top } else { bottom })
    })
    .to-dict()
  cfg.layout = (
    ..l,
    caption-position: caption-position,
    font-size: l.font-size * 1pt,
    // ~ auto-picks by language; either way 0 is a valid override that turns
    // indenting off
    first-line-indent: (
      if l.first-line-indent != none { l.first-line-indent }
      else if l.language == "chinese" { 2 }
      else { 1.5 }
    ) * 1em,
    par-spacing: l.par-spacing * 1em,
    title-spread: l.title-spread * 1em,
    line-box: (top: l.line-box.top * 1em, bottom: l.line-box.bottom * 1em),
    margin: (
      top: l.margin.top * 1cm,
      bottom: l.margin.bottom * 1cm,
      left: l.margin.left * 1cm,
      right: l.margin.right * 1cm,
    ),
    heading: (
      ..h,
      size: h.size.map(v => v * 1pt),
      align: h.align.map(align-of),
      gap-above: h.gap-above.map(v => v * 1em),
      gap-below: h.gap-below.map(v => v * 1em),
      number-gap: h.number-gap.map(v => v * 1em),
    ),
  )

  let pn = cfg.page-number
  assert(pn.position in ("top", "bottom"), message: "page-number.position: expected top or bottom")
  assert(pn.align in ("left", "center", "right"), message: "page-number.align: expected left, center or right")
  assert(type(pn.format) == str, message: "page-number.format: expected a string")
  cfg.page-number = (..pn, align: align-of(pn.align))

  let cr = cfg.cross-ref
  assert(cr.numbering == none or type(cr.numbering) == str, message: "cross-ref.numbering: expected a string or ~")
  for key in ("chapter", "section", "subsection") {
    assert(type(cr.at(key)) == str, message: "cross-ref." + key + ": expected a string")
  }
  cfg.cross-ref = (..cr, numbering: if cr.numbering == none {
    if l.language == "chinese" { "一" } else { "1" }
  } else { cr.numbering })

  let o = cfg.outline
  cfg.outline = (
    ..o,
    indent: o.indent * 1em,
    title-size: o.title-size * 1pt,
    entry-gap: o.entry-gap * 1em,
  )

  let c = cfg.cover
  let cm = c.margin
  // ~ falls back to the body margin; an unset bottom mirrors the cover's own
  // top instead of the body's bottom, since a cover is usually symmetric
  let cover-top = if cm.top == none { cfg.layout.margin.top } else { cm.top * 1cm }
  let cover-left = if cm.left == none { cfg.layout.margin.left } else { cm.left * 1cm }
  let cover-right = if cm.right == none { cfg.layout.margin.right } else { cm.right * 1cm }
  let cover-bottom = if cm.bottom == none { cover-top } else { cm.bottom * 1cm }
  cfg.cover = (
    ..c,
    size: c.size.pairs().map(((k, v)) => (k, v * 1pt)).to-dict(),
    gap: c.gap * 1em,
    flex: c.flex * 1fr,
    margin: (top: cover-top, bottom: cover-bottom, left: cover-left, right: cover-right),
  )

  let v = cfg.verification
  let g = v.grid
  cfg.verification = (
    ..v,
    size: v.size.pairs().map(((k, x)) => (k, x * 1pt)).to-dict(),
    flex: v.flex * 1fr,
    flex-end: v.flex-end * 1fr,
    grid: (
      columns: g.columns.map(x => x * 1fr),
      rows: g.rows.map(x => x * 1em),
      gutter: g.gutter * 1%,
      rule: g.rule * 1%,
      rule-pair: g.rule-pair * 1%,
      director-indent: g.director-indent * 1em,
      director-offset: g.director-offset.map(x => x * 1em),
    ),
  )

  cfg.watermark.width = cfg.watermark.width * 1%
  cfg.watermark.opacity = cfg.watermark.opacity * 1%

  let b = cfg.bibliography
  cfg.bibliography = (
    ..b,
    path: if type(b.path) == str { (b.path,) } else { b.path },
    color: rgb(b.color),
  )

  cfg.date = date(cfg.date)
  cfg.oral-date = date(cfg.oral-date)
  cfg
}
