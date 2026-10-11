#let _data = yaml("../../../settings/typography-rules.yml")

#let _storage = if "storage" in _data { _data.storage } else { (:) }
#let _rules   = if "rules"   in _data { _data.rules   } else { _data }

#let _resolve-storage(s) = {
  let rest = s
  let out  = ""
  while rest != "" {
    let idx = rest.position(regex("\\$\\{"))
    if idx == none {
      out  = out + rest
      rest = ""
    } else {
      out  = out + rest.slice(0, idx)
      let after = rest.slice(idx + 2)
      let close = after.position("}")
      if close == none {
        out  = out + rest.slice(idx)
        rest = ""
      } else {
        let key-raw = after.slice(0, close)
        let splat   = key-raw.ends-with("*")
        let key     = if splat { key-raw.slice(0, key-raw.len() - 1) } else { key-raw }
        let val     = if key in _storage { _storage.at(key) } else { "${" + key-raw + "}" }
        let resolved = if type(val) == array {
          if splat { val.join("") } else { val.join("|") }
        } else {
          str(val)
        }
        out  = out + resolved
        rest = after.slice(close + 1)
      }
    }
  }
  out
}

#let _parse-inline-evals(s) = {
  let segments = ()
  let rest = s
  while rest != "" {
    let idx = rest.position(regex("#\("))
    if idx == none {
      segments.push((type: "str", value: rest))
      rest = ""
    } else {
      if idx > 0 {
        segments.push((type: "str", value: rest.slice(0, idx)))
      }
      let after = rest.slice(idx + 2)
      let close = after.position(")")
      if close == none {
        segments.push((type: "str", value: rest.slice(idx)))
        rest = ""
      } else {
        segments.push((type: "eval", value: after.slice(0, close)))
        rest = after.slice(close + 1)
      }
    }
  }
  segments
}

#let _build-replacement(template, matched, pattern) = {
  let m        = matched.match(regex("^(?:" + pattern + ")$"))
  let captures = if m != none { m.captures } else { () }
  let segments = _parse-inline-evals(template)
  let parts    = ()
  for seg in segments {
    if seg.type == "eval" {
      parts.push(eval(seg.value, scope: (sym: sym)))
    } else {
      let s = seg.value
      s = s.replace("$0", matched)
      let i = 1
      for cap in captures {
        s = s.replace("$" + str(i), if cap == none { "" } else { cap })
        i += 1
      }
      parts.push(s)
    }
  }
  parts.join()
}

#let _unescape(s) = {
  s
    .replace("\\.", ".")
    .replace("\\!", "!")
    .replace("\\?", "?")
    .replace("\\,", ",")
    .replace("\\:", ":")
    .replace("\\$", "$")
    .replace("\\\\", "\\")
}

#let _parse-condition(condition) = {
  // Парсим "$1(not-in:...)" → (capture: 1, kind: "not-in", value: "...")
  let m = condition.match(regex("^\\$(\\d+)\\(([a-z-]+):(.*)\\)$"))
  if m == none { return none }
  (
    capture: int(m.captures.at(0)),
    kind:    m.captures.at(1),
    value:   m.captures.at(2),
  )
}

#let _check-condition(text, pattern, condition) = {
  let parsed = _parse-condition(condition)
  if parsed == none { return true }

  // Получаем нужный capture
  let m        = text.match(regex("^(?:" + pattern + ")$"))
  let captures = if m != none { m.captures } else { () }
  let idx      = parsed.capture - 1
  let subject  = if idx < captures.len() and captures.at(idx) != none {
    captures.at(idx)
  } else {
    text.clusters().first()
  }

  if parsed.kind == "not-in" {
    // Резолвим ${...} внутри value
    let resolved = _resolve-storage(parsed.value)
    // Разбиваем на отдельные символы/токены по "|"
    let tokens = resolved.split("|").map(s => _unescape(s))
    not tokens.contains(subject)
  } else {
    true
  }
}

#let _apply-rules(rules, body) = {
  if rules.len() == 0 { return body }
  let rule        = rules.first()
  let rest-rules  = rules.slice(1)
  let pattern     = _resolve-storage(rule.at(0))
  let replacement = _resolve-storage(rule.at(1))
  let condition   = if rule.len() > 2 { rule.at(2) } else { none }
  show regex(pattern): it => {
    if condition != none and not _check-condition(it.text, pattern, condition) {
      it.text
    } else {
      _build-replacement(replacement, it.text, pattern)
    }
  }
  _apply-rules(rest-rules, body)
}

#let apply(content) = {
  if _rules.len() == 0 { return content }
  _apply-rules(_rules.rev(), content)
}

#let _dbg-condition(text) = {
  let stored = _storage.at("right-sided-punctuation", default: ())
  let first  = text.clusters().first()
  let mapped = stored.map(s => str(s))
  [first: "#first" | mapped: #mapped.join("|")]
}

#_dbg-condition(". — текст")
