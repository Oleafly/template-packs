#let maybe-include(path, ..args) = context {
  let path-label = label(path)
  let first-time = query((context {}).func()).len() == 0
  if first-time or query(path-label).len() > 0 {
    [#include path;#path-label]
  } else {
    [#text(fill: red)[找不到 #raw(path)]]
  }
}