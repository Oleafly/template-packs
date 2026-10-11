#import "./format.typ" as format

#let regex-rules = (
  w-s-unit: "^(\\d+)\\s*[×*]\\s*(\\d+)\\s*in\\s*(.+)$",
  color-fn: "^(rgb|cmyk|luma|oklab|oklch|color\\.linear-rgb|color\\.hsl|color\\.hsv)\\((.*)\\)$",
)

#let _parse-color(fn-name, args-str) = {
  let args = args-str
    .split(",")
    .map(a => a.trim())
    .filter(a => a.len() > 0)

  let parse-arg(a) = {
    if a.ends-with("deg") {
      eval(a)
    } else if a.ends-with("%") {
      eval(a)
    } else if a.starts-with("#") {
      a
    } else if a.match(regex("^\\d+$")) != none {
      int(a)
    } else {
      eval(a)
    }
  }

  let parsed = args.map(parse-arg)

  if fn-name == "rgb" {
    if parsed.len() == 1 {
      rgb(parsed.at(0))
    } else if parsed.len() == 3 {
      rgb(parsed.at(0), parsed.at(1), parsed.at(2))
    } else {
      rgb(parsed.at(0), parsed.at(1), parsed.at(2), parsed.at(3))
    }
  } else if fn-name == "cmyk" {
    cmyk(parsed.at(0), parsed.at(1), parsed.at(2), parsed.at(3))
  } else if fn-name == "luma" {
    luma(parsed.at(0))
  } else if fn-name == "oklab" {
    if parsed.len() == 3 {
      oklab(parsed.at(0), parsed.at(1), parsed.at(2))
    } else {
      oklab(parsed.at(0), parsed.at(1), parsed.at(2), parsed.at(3))
    }
  } else if fn-name == "oklch" {
    if parsed.len() == 3 {
      oklch(parsed.at(0), parsed.at(1), parsed.at(2))
    } else {
      oklch(parsed.at(0), parsed.at(1), parsed.at(2), parsed.at(3))
    }
  } else if fn-name == "color.linear-rgb" {
    if parsed.len() == 3 {
      color.linear-rgb(parsed.at(0), parsed.at(1), parsed.at(2))
    } else {
      color.linear-rgb(parsed.at(0), parsed.at(1), parsed.at(2), parsed.at(3))
    }
  } else if fn-name == "color.hsl" {
    color.hsl(parsed.at(0), parsed.at(1), parsed.at(2))
  } else if fn-name == "color.hsv" {
    color.hsv(parsed.at(0), parsed.at(1), parsed.at(2))
  }
}

#let parse-value(value) = {
  if value == none or type(value) != str {
    return value
  }

  // размер вида "170 × 260 in mm"
  let size-match = value.match(regex(regex-rules.w-s-unit))
  if size-match != none {
    let captures = size-match.captures
    let unit = captures.at(2)
    return (
      eval(captures.at(0) + unit),
      eval(captures.at(1) + unit),
    )
  }

  let color-match = value.match(regex(regex-rules.color-fn))
  if color-match != none {
    return _parse-color(color-match.captures.at(0), color-match.captures.at(1))
  }

  if value.match(regex("^(auto|none|start|end|left|center|right|top|horizon|bottom)$")) != none {
    return eval(value)
  }

  let starts-with-number = value.match(regex("^-?\\d")) != none
  let has-units = value.match(regex("\\d+(pt|mm|cm|in|em|%|deg|rad|fr)")) != none
  let has-operators = value.match(regex("\\s[+\\-*/]\\s")) != none

  if starts-with-number and (has-units or has-operators) {
    return eval(value)
  }

  value
}

#let parse-dict(dict) = {
  let lookup = (:)

  for (k, v) in dict {
    lookup.insert(lower(k), (key: k, value: v))
  }

  (
    get: key => {
      let entry = lookup.at(lower(key), default: none)
      if entry != none { entry.value } else { none }
    },
    key: key => {
      let entry = lookup.at(lower(key), default: none)
      if entry != none { entry.key } else { none }
    },
    entry: key => lookup.at(lower(key), default: none),
  )
}

#let parse-parameters(content) = {
  parse-value(content)
}

#let resolve-path(dict, key-path) = {
  let parts = key-path.split(".")
  let node = dict
  for part in parts {
    if type(node) == dictionary and part in node {
      node = node.at(part)
    } else {
      return none
    }
  }
  node
}

#let iso-parse(raw) = {
  let parts = raw.split("-")
  (
    iso639: parts.at(0),
    iso3166: parts.at(1),
  )
}
