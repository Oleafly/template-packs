#let _data = yaml("../../../settings/nobreak.yml")

#let _options = _data.at("options", default: (:))
#let _words = _data.at("words", default: ())

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

#let _word-to-pattern(word) = {
  let prefix-wild = word.starts-with("*")
  let suffix-wild = word.ends-with("*")

  let core = word
  if prefix-wild { core = core.slice(1) }
  if suffix-wild { core = core.slice(0, core.len() - 1) }

  let escaped = _escape(core)

  let pre  = if prefix-wild { "\\w*" } else { "\\b" }
  let post = if suffix-wild { "\\w*" } else { "\\b" }

  pre + escaped + post
}

#let _create-rule(words, options) = {
  if words.len() == 0 { return none }

  let case-sensitive = options.at("case-sensitive", default: false)
  let case-flag = if case-sensitive { "" } else { "(?i)" }

  let patterns = words.map(w => _word-to-pattern(str(w)))

  regex(case-flag + "(" + patterns.join("|") + ")")
}

#let _pattern = _create-rule(_words, _options)

#let apply(content) = {
  if _pattern == none { return content }
  show _pattern: match => box[#match.text]
  content
}
