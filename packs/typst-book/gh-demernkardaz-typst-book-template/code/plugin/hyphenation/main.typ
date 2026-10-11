#let _data = yaml("../../../settings/hyphenation.yml")

#let _options = _data.at("options", default: (:))
#let _words   = _data.at("words",   default: ())

#let _escape(word) = {
  word
    .replace("\\", "\\\\")
    .replace(".", "\\.")
    .replace("+", "\\+")
    .replace("?", "\\?")
    .replace("(", "\\(")
    .replace(")", "\\)")
    .replace("[", "\\[")
    .replace("]", "\\]")
    .replace("{", "\\{")
    .replace("}", "\\}")
    .replace("^", "\\^")
    .replace("$", "\\$")
    .replace("|", "\\|")
}

#let _parse-word(word) = {
  let prefix-wild = word.starts-with("*")
  let suffix-wild = word.ends-with("*")

  let core = word
  if prefix-wild { core = core.slice(1) }
  if suffix-wild { core = core.slice(0, core.len() - 1) }

  let chars     = core.clusters()
  let clean-arr = ()
  let positions = ()

  for ch in chars {
    if ch == "-" {
      positions.push(clean-arr.len())
    } else {
      clean-arr.push(ch)
    }
  }

  let clean   = clean-arr.join()
  let escaped = _escape(clean)
  let pre     = if prefix-wild { "\\w*" } else { "\\b" }
  let post    = if suffix-wild { "\\w*" } else { "\\b" }

  (
    pattern:     pre + escaped + post,
    clean:       clean,
    clean-len:   clean-arr.len(),
    positions:   positions,
    prefix-wild: prefix-wild,
    suffix-wild: suffix-wild,
  )
}

#let _parsed = _words.map(w => _parse-word(str(w)))

#let _create-pattern(parsed, options) = {
  if parsed.len() == 0 { return none }
  let case-sensitive = options.at("case-sensitive", default: false)
  let case-flag = if case-sensitive { "" } else { "(?i)" }
  let patterns = parsed.map(p => p.pattern)
  regex(case-flag + "(" + patterns.join("|") + ")")
}

#let _pattern = _create-pattern(_parsed, _options)

#let _insert-shy(text, positions) = {
  let result = ""
  let i      = 0
  for ch in text.clusters() {
    if positions.contains(i) {
      result = result + "\u{00AD}"
    }
    result = result + ch
    i = i + 1
  }
  result
}

#let _apply-shy(matched-text, options) = {
  let case-sensitive = options.at("case-sensitive", default: false)
  let compare   = if case-sensitive { matched-text } else { lower(matched-text) }

  for p in _parsed {
    let clean-cmp = if case-sensitive { p.clean } else { lower(p.clean) }

    let inner = if p.prefix-wild or p.suffix-wild {
      compare.contains(clean-cmp)
    } else {
      compare == clean-cmp
    }

    if inner {
      let clusters = matched-text.clusters()
      let cmp-clusters = compare.clusters()

      let start = if p.prefix-wild {
        // ищем позицию в символах
        let found = none
        let ci = 0
        while ci <= cmp-clusters.len() - p.clean-len {
          if cmp-clusters.slice(ci, ci + p.clean-len).join() == clean-cmp {
            found = ci
            break
          }
          ci = ci + 1
        }
        if found == none { 0 } else { found }
      } else {
        0
      }

      let prefix = clusters.slice(0, start).join()
      let middle = clusters.slice(start, start + p.clean-len).join()
      let suffix = clusters.slice(start + p.clean-len).join()

      return prefix + _insert-shy(middle, p.positions) + suffix
    }
  }

  matched-text
}

#let apply(content) = {
  if _pattern == none { return content }
  show _pattern: it => _apply-shy(it.text, _options)
  content
}
