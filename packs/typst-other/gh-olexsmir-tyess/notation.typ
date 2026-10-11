#import "board.typ": file-to-col, square-to-coords

#let str-index-of(s, c) = {
  for i in range(s.len()) { if s.at(i) == c { return i } }
  none
}

#let parse-move(move-str) = {
  let s = move-str.trim()
  let suffix = ""
  if s.len() > 0 and (s.at(-1) == "+" or s.at(-1) == "#") {
    suffix = s.at(-1)
    s = s.slice(0, -1)
  }

  // promotion (e8=Q, e8)
  let promotion = none
  let idx = str-index-of(s, "=")
  if idx != none {
    promotion = s.slice(idx + 1, s.len())
    s = s.slice(0, idx)
  }

  // castling
  if lower(s) == "o-o" or s == "0-0" { return (kind: "castle", side: "kingside", suffix: suffix) }
  if lower(s) == "o-o-o" or s == "0-0-0" { return (kind: "castle", side: "queenside", suffix: suffix) }

  // determine piece type
  let ptype = "P"
  let pi = 0
  if s.len() > 0 and "KQRNBkqrn".contains(s.at(0)) {
    ptype = ("k": "K", "q": "Q", "r": "R", "n": "N").at(s.at(0), default: s.at(0))
    pi = 1
  }

  // find dest square
  let dest-start = -1
  for i in range(pi, s.len() - 1) {
    if "abcdefgh".contains(s.at(i)) and "12345678".contains(s.at(i + 1)) { dest-start = i }
  }

  if dest-start == -1 { return (kind: "error", raw: s) }
  let dest = square-to-coords(s.at(dest-start) + s.at(dest-start + 1))

  // check for capture by scanning for 'x' before destination
  let is-capture = false
  for i in range(pi, dest-start) {
    if s.at(i) == "x" {
      is-capture = true
      break
    }
  }

  // disambiguation between piece and destination
  let disambig = none
  if dest-start > pi {
    let between = s.slice(pi, dest-start)
    let capture-fix = if is-capture { between.replace("x", "") } else { between }
    if capture-fix.len() == 1 {
      if "abcdefgh".contains(capture-fix) { disambig = (type: "file", value: capture-fix) }
      else if "12345678".contains( capture-fix,) { disambig = (type: "rank", value: capture-fix) }
    } else if capture-fix.len() == 2 {
      if "abcdefgh".contains(capture-fix.at(0)) and "12345678".contains(capture-fix.at(1)) {
        disambig = (type: "square", value: capture-fix)
      }
    }
  }

  return (
    kind: "move",
    piece: ptype,
    dest: dest,
    capture: is-capture,
    promotion: promotion,
    suffix: suffix,
    disambig: disambig,
    raw: s,
  )
}
