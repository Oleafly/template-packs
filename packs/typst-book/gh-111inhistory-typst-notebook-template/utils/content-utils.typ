#import "common.typ": *

#let sequence = [].func()
#let styled = text(red, "").func()
#let space = [ ].func()
#let symbol = [#sym.acute].func()

#let inline-element-funcs = (
  box,
  text,
  styled,
  space,
  symbol,
  linebreak,
  h,
  link,
  ref,
  footnote,
  emph,
  strong,
  underline,
  overline,
  strike,
  sub,
  super,
  smallcaps,
  highlight,
  smartquote,
  metadata,
)

/// Checks inline-only elements and elements whose inline status depends on fields.
#let is-inline-element(body) = {
  if body.func() in inline-element-funcs {
    return true
  }

  if body.func() in (math.equation, raw, quote) {
    return body.has("block") and body.block == false
  }

  false
}

/// Trim the content by the body type.
#let _trim-content-by-type(body, accept-type, predicate-func, recursive) = {
  if recursive and body.func() == sequence {
    let acc = []
    let rest = []
    let collecting = true
    for child in body.children {
      if collecting {
        let (flag, child-acc, child-rest) = _trim-content-by-type(child, accept-type, predicate-func, recursive)
        if flag {
          acc += child-acc
        } else {
          collecting = false
          if child-rest != none {
            rest += child-rest
          }
        }
      } else {
        rest += child
      }
    }
    return (collecting, acc, if rest == [] { none } else { rest })
  }
  if body.func() in accept-type or (predicate-func != none and predicate-func(body)) {
    return (true, body, none)
  }
  (false, [], body)
}

#let trim-content-by-type(body, accept-type: (), predicate-func: none, recursive: true) = {
  let (_, acc, rest) = _trim-content-by-type(body, accept-type, predicate-func, recursive)
  (acc, rest)
}


/// Receives a content element, returns the first paragraph as `first` and the rest of the content as `rest`.
/// If the first paragraph is the only content, `rest` will be `none`.
/// - body (sequence): The content to be split.
/// -> dictionary
#let split-first-paragraph(body) = {
  if body.func() != sequence {
    return (
      first: body,
      rest: none,
    )
  }

  let (first, rest) = trim-content-by-type(body, predicate-func: is-inline-element)

  (first: first, rest: rest)
}

/// Checks whether the given content contains any content whose func() equals the given func.
/// - body (content): The content to be checked.
/// - func (string): The function to look for.
/// -> boolean
#let has-func(body, func) = {
  if body.func() == sequence {
    for i in body.children {
      if has-func(i, func) {
        return true
      }
    }
  } else if body.func() == func {
    return true
  }
  return false
}
