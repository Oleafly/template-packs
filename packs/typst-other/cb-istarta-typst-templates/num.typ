#let assignment-numbering(..nums) = {
  let nums = nums.pos()
  if nums.len() == 2 {
    numbering("a)", nums.last())
  } else if nums.len() == 3 {
    numbering("i)", nums.last())
  } else if nums.len() == 1 {
    "Aufgabe " + numbering("1", nums.last())
  }
}
