#import "board.typ": at, copy-grid, find-pieces, is-black, is-white, on-board, piece-type

// move generation

#let enemy(turn, target) = if turn == "white" { is-black(target) } else { is-white(target) }

#let pawn-dir(turn) = if turn == "white" { -1 } else { 1 }
#let pawn-moves(grid, col, row, turn, ep: none) = {
  let moves = ()
  let start-row = if turn == "white" { 7 } else { 2 }
  let dir = pawn-dir(turn)

  // forward one
  let nr = row + dir
  if on-board(col, nr) and at(grid, col, nr) == "." {
    if nr == 1 or nr == 8 {
      for prom in ("Q", "R", "B", "N") { moves.push((col, nr, prom)) }
    } else { moves.push((col, nr)) }

    // forward two from start
    let nr2 = row + 2 * dir
    if row == start-row and at(grid, col, nr2) == "." { moves.push((col, nr2)) }
  }

  // captures
  for dc in (-1, 1) {
    let nc = col + dc
    let nr = row + dir
    if on-board(nc, nr) {
      if enemy(turn, at(grid, nc, nr)) {
        if nr == 1 or nr == 8 {
          for prom in ("Q", "R", "B", "N") { moves.push((nc, nr, prom)) }
        } else {
          moves.push((nc, nr))
        }
      }

      // en passant capture: pawn ends on ep square, captured pawn is one rank behind
      if ep != none and nc == ep.at(0) {
        let captured-row = ep.at(1) - dir
        if enemy(turn, at(grid, nc, captured-row)) { moves.push((ep.at(0), ep.at(1))) }
      }
    }
  }

  moves
}

#let knight-offsets = ((-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1))
#let knight-moves(grid, col, row, turn) = {
  let moves = ()
  for (dc, dr) in knight-offsets {
    let nc = col + dc
    let nr = row + dr
    if on-board(nc, nr) {
      let target = at(grid, nc, nr)
      if target == "." or enemy(turn, target) {
        moves.push((nc, nr))
      }
    }
  }
  moves
}

#let sliding-moves(grid, col, row, turn, dirs) = {
  let moves = ()
  for (dc, dr) in dirs {
    let nc = col + dc
    let nr = row + dr
    while on-board(nc, nr) {
      let target = at(grid, nc, nr)
      if target == "." {
        moves.push((nc, nr))
      } else if enemy(turn, target) {
        moves.push((nc, nr))
        break
      } else { break }
      nc = nc + dc
      nr = nr + dr
    }
  }
  moves
}

#let bishop-dirs = ((-1, -1), (-1, 1), (1, -1), (1, 1))
#let bishop-moves(grid, col, row, turn) = sliding-moves(grid, col, row, turn, bishop-dirs)

#let rook-dirs = ((-1, 0), (1, 0), (0, -1), (0, 1))
#let rook-moves(grid, col, row, turn) = sliding-moves(grid, col, row, turn, rook-dirs)

#let queen-moves(grid, col, row, turn) = {
  let moves = ()
  for m in bishop-moves(grid, col, row, turn) { moves.push(m) }
  for m in rook-moves(grid, col, row, turn) { moves.push(m) }
  moves
}

#let king-dirs = ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1))
#let king-moves(grid, col, row, turn) = {
  let moves = ()
  for (dc, dr) in king-dirs {
    let nc = col + dc
    let nr = row + dr
    if on-board(nc, nr) {
      if at(grid, nc, nr) == "." or enemy(turn, at(grid, nc, nr)) {
        moves.push((nc, nr))
      }
    }
  }
  moves
}

#let generate-moves-for(grid, col, row, turn, ep: none) = {
  let p = at(grid, col, row)
  if p == "." { return () }
  if turn == "white" and not is-white(p) { return () }
  if turn == "black" and not is-black(p) { return () }

  let type = piece-type(p)
  if type == "P" { return pawn-moves(grid, col, row, turn, ep: ep) }
  if type == "N" { return knight-moves(grid, col, row, turn) }
  if type == "B" { return bishop-moves(grid, col, row, turn) }
  if type == "R" { return rook-moves(grid, col, row, turn) }
  if type == "Q" { return queen-moves(grid, col, row, turn) }
  if type == "K" { return king-moves(grid, col, row, turn) }
  ()
}

// chess rules

#let is-attacked(grid, col, row, by-color) = {
  let enemy(piece) = if by-color == "white" { is-white(piece) } else { is-black(piece) }

  // knight attacks
  for (dc, dr) in knight-offsets {
    let p = at(grid, col + dc, row + dr)
    if p != "." and piece-type(p) == "N" and enemy(p) { return true }
  }

  // king attacks
  for (dc, dr) in king-dirs {
    let p = at(grid, col + dc, row + dr)
    if p != "." and piece-type(p) == "K" and enemy(p) { return true }
  }

  // pawn attacks
  let pawn-checks = if by-color == "white" { ((-1, 1), (1, 1)) } else { ((-1, -1), (1, -1)) }
  for (dc, dr) in pawn-checks {
    let p = at(grid, col + dc, row + dr)
    if p != "." and piece-type(p) == "P" and enemy(p) { return true }
  }

  // sliding pieces
  for (dirs, types) in ((bishop-dirs, ("B", "Q")), (rook-dirs, ("R", "Q"))) {
    for (dc, dr) in dirs {
      let nc = col + dc
      let nr = row + dr
      while on-board(nc, nr) {
        let p = at(grid, nc, nr)
        if p != "." {
          if enemy(p) and types.contains(piece-type(p)) { return true }
          break // blocked by any piece
        }
        nc += dc
        nr += dr
      }
    }
  }

  false
}

#let is-in-check(grid, turn) = {
  let king-char = if turn == "white" { "K" } else { "k" }
  let enemy = if turn == "white" { "black" } else { "white" }
  for r in range(8) {
    for c in range(8) {
      if grid.at(r).at(c) == king-char {
        return is-attacked(grid, c + 1, r + 1, enemy)
      }
    }
  }
  false
}

#let can-castle(grid, row, empty-cols, check-cols, enemy) = {
  if is-attacked(grid, 5, row, enemy) { return false }
  for c in empty-cols { if at(grid, c, row) != "." { return false } }
  for c in check-cols { if is-attacked(grid, c, row, enemy) { return false } }
  true
}

#let has-legal-move(grid, turn, ep: none, castles: "") = {
  for r in range(8) {
    for c in range(8) {
      let p = grid.at(r).at(c)
      if p == "." { continue }
      if turn == "white" and not is-white(p) { continue }
      if turn == "black" and not is-black(p) { continue }

      let type = piece-type(p)

      let col = c + 1
      let row = r + 1
      let raw-moves = if type == "P" { pawn-moves(grid, col, row, turn, ep: ep) } else {
        generate-moves-for(grid, col, row, turn, ep: ep)
      }

      for m in raw-moves {
        let (dc, dr) = (m.at(0), m.at(1))
        let new-grid = copy-grid(grid)
        new-grid.at(r).at(c) = "."
        let mover = p
        let is-pawn = type == "P"
        if is-pawn and (dr == 1 or dr == 8) {
          mover = if turn == "white" { "Q" } else { "q" }
        }
        new-grid.at(dr - 1).at(dc - 1) = mover
        if is-pawn and ep != none and dc == ep.at(0) and dr == ep.at(1) {
          let captured-row = if turn == "white" { dr + 1 } else { dr - 1 }
          new-grid.at(captured-row - 1).at(dc - 1) = "."
        }
        if not is-in-check(new-grid, turn) { return true }
      }
    }
  }

  let enemy = if turn == "white" { "black" } else { "white" }
  let options = if turn == "white" {
    (("K", 8, (6, 7), (6, 7)), ("Q", 8, (2, 3, 4), (3, 4)))
  } else {
    (("k", 1, (6, 7), (6, 7)), ("q", 1, (2, 3, 4), (3, 4)))
  }

  for (flag, row, empty, check) in options {
    if castles.contains(flag) and can-castle(grid, row, empty, check, enemy) { return true }
  }

  false
}
