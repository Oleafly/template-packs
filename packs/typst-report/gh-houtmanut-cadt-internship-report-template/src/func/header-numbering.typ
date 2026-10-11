#import "../config.typ": (
  numbered-header-deep-format, numbered-header-deep-level,
  numbered-header-sub-format, numbered-header-top-format,
)

#let content-header-numbering(..number) = {
  let n = number.pos()
  let level = n.len()
  if level == 1 {
    numbering(numbered-header-top-format, ..n)
  } else if level < numbered-header-deep-level {
    numbering(numbered-header-sub-format, ..n)
  } else {
    numbering(numbered-header-deep-format, ..n.slice(numbered-header-deep-level - 1))
  }
}
