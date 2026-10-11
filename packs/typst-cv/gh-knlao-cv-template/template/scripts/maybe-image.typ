#let maybe-image(path, ..args) = context {
  let path-label = label(path)
  let first-time = query((context {}).func()).len() == 0
  if first-time or query(path-label).len() > 0 {
    [#image(path, ..args)#path-label]
  } else {
    // rect(width: 50%, height: 5em, fill: luma(235), stroke: 1pt)[
    //   #set align(center + horizon)
    //   找不到 #raw(path)
    // ]
    [#image("../images/dummy.jpg", width: 300pt)]
    [#text(fill: red)[找不到 #raw(path)]]
  }
}