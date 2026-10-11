// This file defines `partial-display` and `full-display` utility function for certain circunstances, 
// like lists, to use, in order to make up the disability of std `numbering` function, which does not 
// support partial display of the numbering
#import "@preview/numbly:0.1.0": numbly

#let partial-display(patterns) = {
  let raw = ()
  for p in patterns.matches(regex("\{(\d)(:(.+?))?\}")) {
    raw.push(p)
  }
  let arr = ()
  for i in range(raw.len() - 1) {
    arr.push(patterns.slice(raw.at(i).start, raw.at(i + 1).start))
  }
  arr.push(patterns.slice(raw.at(-1).start))
  return numbly(..arr)
}

#let full-display(patterns) = {
  let raw = ()
  for p in patterns.matches(regex("\{(\d)(:(.+?))?\}")) {
    raw.push(p)
  }
  let arr = ()
  arr.push(patterns.slice(raw.at(0).start, raw.at(1).start))
  for i in range(1, raw.len() - 1) {
    arr.push(arr.at(-1) + patterns.slice(raw.at(i).start, raw.at(i + 1).start))
  }
  arr.push(arr.at(-1) + patterns.slice(raw.at(-1).start))
  return numbly(..arr)
}
