#let at(d, k, fallback) = d.at(k, default: fallback)

// `YAML`gives dates as strings. "2026-12-01" -> (year: 2026, month: 12, day: 1);
// a part that is not a number, like the ○○ placeholder, is kept as text.
#let date(s) = {
  let p = str(s).split("-").map(x => if x.match(regex("^\d+$")) != none { int(x) } else { x })
  if p.len() != 3 { panic("date must be YYYY-MM-DD, got `" + str(s) + "`") }
  (year: p.at(0), month: p.at(1), day: p.at(2))
}

// 12 -> "12", 1 -> "01"; placeholder text passes through
#let pad2(v) = if type(v) == int and v < 10 { "0" + str(v) } else { str(v) }

// 2027 -> 116. A placeholder year (○○○○) has no roc equivalent.
#let roc-year(year, offset: 1911, placeholder: "○○○") = if type(year) == int {
  year - offset
} else { placeholder }

// 1 -> "January", from the month names the config carries; a placeholder
// month passes through untouched
#let month-name(month, names) = if type(month) == int {
  names.at(month - 1)
} else { month }

// "{author} 君" + (author: "王小明") -> "王小明 君"
#let fill(tpl, vars) = {
  let out = tpl
  for (k, v) in vars {
    out = out.replace("{" + k + "}", str(v))
  }
  out
}

#let align-of(name) = if name == "center" { center } else if name == "right" {
  right
} else { left }

// the `numbering:` value for `math.equation`, built from `layout.equation-numbering`
// and `layout.equation-per-chapter`. Flat mode is a plain pattern like "(1)";
// chapter-scoped mode returns a function combining the chapter number with a
// counter that gets reset every level-1 heading (see `template.typ`).
#let eq-numbering(l) = if l.equation-per-chapter {
  n => context numbering("(1." + l.equation-numbering + ")", counter(heading).get().first(), n)
} else {
  "(" + l.equation-numbering + ")"
}

// "參~考~文~獻" -> 參 考 文 獻, like latex's ~
#let spread(s, gap: 0.5em) = s.split("~").join(h(gap))

// `over` wins, but nested dicts are merged rather than replaced -- so a config
// can override one key of a preset's `layout` without restating the rest.
#let merge(base, over) = {
  let out = base
  for (k, v) in over {
    let old = base.at(k, default: none)
    out.insert(
      k,
      if type(v) == dictionary and type(old) == dictionary { merge(old, v) } else { v },
    )
  }
  out
}

// A footnote inside a figure caption would be re-rendered in the list of
// figures, putting the note at the foot of that page too. Show rules do not
// reach outline entries, so the caption is rebuilt without them instead.
#let strip-footnotes(c) = {
  if c == none { return none }
  if c.func() == footnote { return none }
  if c.has("children") {
    return c.children.map(strip-footnotes).filter(x => x != none).join()
  }
  if c.has("body") and c.body != none {
    let f = c.func()
    if f == text or f == raw { return c }
    return f(strip-footnotes(c.body))
  }
  c
}
