 #let _fig-num(n) = {
  let _h = counter(heading).get()
  let l = _h.len()
  let result = ""
  for i in range(0, l) {
    result += str(_h.at(i)) + "."
  }
  result + str(n)
}
