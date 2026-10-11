// cody.typ
#import "@preview/codelst:2.0.1": sourcecode, codelst
#import "font.typ": fonts

#let codify-state = state("codify-lang", none)

/// Add boxes to raw contents.
///
/// - doc (any): The document.
/// -> content
#let raw-style(doc) = {
  show raw.line: set text(font: fonts.mono)

  show raw.where(block: true): it => {
    if it.lang == none or it.lang == "none" {
      block(width: 100%, radius: 2pt, fill: rgb("#f8f8f8"), stroke: 0.5pt + rgb("#ddd"), inset: 0.5em, it)
    } else {
      set raw(lang: none)
      sourcecode(it)
    }
  }
  show raw.where(block: false): it => {
    if it.has("lang") and it.lang != none {
      box(inset: (left: 0.2em, right: 0.2em), box(radius: 2pt, fill: rgb(50%, 50%, 50%, 10%), outset: 0.2em, it))
    } else {
      it
    }
  }

  doc
}

/// Make raw contents have the default language.
///
/// - lang (string): The language.
/// -> content
#let codify(body, lang: "cpp") = {
  set raw(lang: lang)
  body
}

#let codify-enable(lang: "cpp") = {
  codify-state.update(lang)
}

#let codify-disable() = {
  codify-state.update(none)
}

/// Make a code block from text slice.
///
/// - start (integer string none): The start line (from 1). If none, slice from the first line.
/// - end (integer string none): The end line (from 1). If none, slice to the last line.
/// - count (integer none): Number of lines from start. If none, all lines will be kept.
/// - region (string none): The prefix of start and end.
/// - lang (string): The language to use.
/// -> content
#let cody(txt, start: none, end: none, count: none, region: none, lang: "cpp", font-size: auto) = {
  let a = txt.split("\n")
  if region != none and lang == "cpp" {
    start = "#pragma region " + region
    end = "#pragma endregion " + region
  }
  if end != none {
    if type(end) == str {
      let _end = end
      end = a.position(x => x.contains(_end))
      assert(end != none, message: "Fail to find region end '" + _end + "'")
    }
    a = a.slice(0, end)
  }
  if start != none {
    if type(start) == str {
      let _start = start
      start = a.position(x => x.contains(_start))
      assert(start != none, message: "Fail to find region start '" + _start + "'")
      start += 2
    }
    a = a.slice(start - 1)
  }
  if count != none {
    a = a.slice(0, count)
  }
  txt = a.join("\n")
  if font-size == auto {
    raw(txt, block: true, lang: lang)
  } else {
    show raw.line: set text(size: font-size)
    raw(txt, block: true, lang: lang)
  }

  /* sourcecode(
    raw(text, block: true, lang: lang),
    numbers-start: if start != none { start } else { 1 }
  ) */
}
