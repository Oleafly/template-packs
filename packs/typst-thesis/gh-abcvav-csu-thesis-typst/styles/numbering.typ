#let main-text-numbering(..nums) = {
  let args_arr = nums.pos()
  if args_arr.len() == 1 {
    numbering("第1章 ", ..nums)
  } else {
    numbering("1.1", ..nums)
  }
}

#let appendix-numbering(..nums) = {
  let nums-arr = nums.pos()
  if nums-arr.len() == 1 {
    numbering("附录A ", ..nums)
  } else {
    numbering("A.1", ..nums)
  }
}