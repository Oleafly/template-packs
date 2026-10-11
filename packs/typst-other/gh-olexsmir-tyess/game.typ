#import "board.typ": apply-move, at, copy-grid, file-to-col, find-pieces, is-black, is-white, on-board, piece-type, render-board, square-to-coords, starting-grid
#import "notation.typ": parse-move
#import "rules.typ": generate-moves-for, has-legal-move, is-attacked, is-in-check, pawn-moves

#let initial-state() = (
  grid: starting-grid,
  turn: "white",
  castles: "KQkq",
  ep: none,
  error: none,
  checkmate: false,
  stalemate: false,
)

#let apply-castling(state, side) = {
  let castles = state.castles
  let grid = copy-grid(state.grid)

  let row = if state.turn == "white" { 7 } else { 0 }
  let case-p = if state.turn == "white" { upper } else { lower }
  let (rook-from, rook-to, king-to) = if side == "kingside" { (7, 5, 6) } else { (0, 3, 2) }
  grid.at(row).at(4) = "."
  grid.at(row).at(rook-from) = "."
  grid.at(row).at(king-to) = case-p("K")
  grid.at(row).at(rook-to) = case-p("R")

  let lost = if state.turn == "white" { "KQ" } else { "kq" }
  for c in lost { castles = castles.replace(c, "") }

  (
    grid: grid,
    turn: if state.turn == "white" { "black" } else { "white" },
    castles: castles,
    ep: none,
    error: none,
    checkmate: false,
    stalemate: false,
  )
}

#let apply-parsed-move(state, parsed) = {
  if parsed.kind == "error" { return (..state, error: parsed.raw + ": illegal notation") }
  if parsed.kind == "castle" { return apply-castling(state, parsed.side) }

  let dest-col = parsed.dest.at(0)
  let dest-row = parsed.dest.at(1)

  // find the source pieces that can reach the destination
  let candidates = ()
  if parsed.piece == "P" {
    let pawn-file = none
    if parsed.disambig != none and parsed.disambig.type == "file" {
      pawn-file = file-to-col.at(parsed.disambig.value) + 1
    }

    for (col, row) in find-pieces(state.grid, state.turn, "P") {
      if pawn-file != none and col != pawn-file { continue }
      for m in pawn-moves(state.grid, col, row, state.turn, ep: state.ep) {
        if m.at(0) == dest-col and m.at(1) == dest-row {
          candidates.push((col, row))
          break
        }
      }
    }
  } else {
    for (col, row) in find-pieces(state.grid, state.turn, parsed.piece) {
      let moves = generate-moves-for(state.grid, col, row, state.turn, ep: state.ep)
      for m in moves {
        if m.at(0) == dest-col and m.at(1) == dest-row {
          candidates.push((col, row))
        }
      }
    }

    // apply disambiguation
    if candidates.len() > 1 and parsed.disambig != none {
      if parsed.disambig.type == "file" {
        let f = file-to-col.at(parsed.disambig.value) + 1
        candidates = candidates.filter(c => c.at(0) == f)

      } else if parsed.disambig.type == "rank" {
        let r = 9 - int(parsed.disambig.value)
        candidates = candidates.filter(c => c.at(1) == r)

      } else if parsed.disambig.type == "square" {
        let (cf, rf) = square-to-coords(parsed.disambig.value)
        candidates = candidates.filter(c => c.at(0) == cf and c.at(1) == rf)
      }
    }
  }

  // auto-promote to queen
  let promotion = parsed.promotion
  if promotion == none and parsed.piece == "P" and (dest-row == 1 or dest-row == 8) { promotion = "Q" }
  if promotion != none and "QRBN".position(upper(promotion)) == none { return (..state, error: parsed.raw + "=" + promotion + ": illegal notation") }

  // check if it's an en passant capture
  let is-ep = parsed.piece == "P" and state.ep != none and dest-col == state.ep.at(0) and dest-row == state.ep.at(1)
  let ep-captured = if is-ep { (dest-col, if state.turn == "white" { dest-row + 1 } else { dest-row - 1 }) } else { none }

  // filter to only legal moves
  let legal-candidates = ()
  for (sc, sr) in candidates {
    let sim = apply-move(state.grid, sc, sr, dest-col, dest-row, promotion: promotion, en-passant: ep-captured)
    if not is-in-check(sim, state.turn) { legal-candidates.push((sc, sr)) }
  }
  candidates = legal-candidates

  if candidates.len() == 0 { return (..state, error: parsed.raw + ": illegal move") }
  let (src-col, src-row) = candidates.at(0)

  let new-grid = apply-move(state.grid, src-col, src-row, dest-col, dest-row, promotion: promotion, en-passant: ep-captured)
  let new-turn = if state.turn == "white" { "black" } else { "white" }

  // update castling rights
  let castles = state.castles
  let lost = if parsed.piece == "K" { if state.turn == "white" { "KQ" } else { "kq" } } else {
    let flags = ""
    for (rc, rr, flag) in ((1, 8, "Q"), (8, 8, "K"), (1, 1, "q"), (8, 1, "k")) {
      if src-col == rc and src-row == rr { flags += flag }
      if dest-col == rc and dest-row == rr { flags += flag }
    }
    flags
  }
  for c in lost { castles = castles.replace(c, "") }

  // set en passant target for the next move
  let new-ep = none
  if parsed.piece == "P" and calc.abs(dest-row - src-row) == 2 { new-ep = (dest-col, int((src-row + dest-row) / 2)) }

  // check for checkmate or stalemate
  let in-check = is-in-check(new-grid, new-turn)
  let no-legal = not has-legal-move(new-grid, new-turn, ep: new-ep, castles: castles)

  (
    grid: new-grid,
    turn: new-turn,
    castles: castles,
    ep: new-ep,
    error: none,
    checkmate: in-check and no-legal,
    stalemate: not in-check and no-legal,
  )
}

#let apply-moves(moves-strs) = {
  let state = initial-state()
  let states = (state,)
  for ms in moves-strs {
    if state.at("checkmate", default: false) or state.at("stalemate", default: false) { break }
    let new-state = apply-parsed-move(state, parse-move(ms))
    states += (new-state,)
    state = new-state
  }
  states
}

#let parse-moves(body) = {
  let extract(it) = {
    if it == [ ] { " " } else if it.func() == text { it.text } else if it.func() == [].func() {
      it.children.map(extract).join()
    } else { "" }
  }
  extract(body).split().filter(s => s != "")
}

#let render(state) = {
  let banner(body) = text(fill: rgb("#0a7e8c"), weight: "bold", size: 1.2em, body)

  let label = none
  let label-fill = none
  if state.at("checkmate", default: false) {
    label = banner[Checkmate!]
    label-fill = rgb("#0a7e8c").transparentize(75%)
  } else if state.at("stalemate", default: false) {
    label = banner[Stalemate!]
    label-fill = rgb("#0a7e8c").transparentize(75%)
  } else {
    let err = state.at("error", default: none)
    if err != none {
      label = text(fill: red, weight: "bold", err)
      label-fill = red.transparentize(75%)
    } else if is-in-check(state.grid, state.turn) {
      label = text(fill: yellow, weight: "bold")[Check!]
      label-fill = yellow.transparentize(75%)
    }
  }

  block(height: 1.8em, width: 100%, inset: 0pt, above: 0pt, below: 0pt,
    align(center, {
      if label != none { box(fill: label-fill, inset: 0.3em, label) }
    }))
  v(0.15em)
  render-board(state.grid)
}

// Usage:
//   #show: chess.with()
//   g4 d5 Bg5 Bxg4 c4 c6 cxd5 cxd5 Qb3
//
#let chess(body) = {
  // Fixed page size: board (8 × 2.8em) + label area (1.8em) + spacing (0.15em) + margins
  set page(
    width: 22.4em + 1in,
    height: 24.65em + 1in,
    margin: 0.5in,
  )
  let moves = parse-moves(body)
  let states = apply-moves(moves)
  render(states.last())
}
