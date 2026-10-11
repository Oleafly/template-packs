#let trim-cjk-spaces(it) = {
  let re-left = regex("(^|\w)\s+(\p{Han})")
  show re-left: it => {
    let match = it.text.match(re-left)
    match.captures.at(0) + match.captures.at(1)
  }

  let re-right = regex("(\p{Han})\s+($|\w)")
  show re-right: it => {
    let match = it.text.match(re-right)
    match.captures.at(0) + match.captures.at(1)
  }

  it
}
