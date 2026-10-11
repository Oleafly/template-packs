// Pieces

#let piece-type(p) = { if p == "." { return "." }; upper(p) }
#let is-white(p) = p != "." and p == upper(p)
#let is-black(p) = p != "." and p == lower(p)

#let piece-assets = (
  "K": "wking.svg",   "k": "bking.svg",
  "Q": "wqueen.svg",  "q": "bqueen.svg",
  "R": "wrook.svg",   "r": "brook.svg",
  "N": "wknight.svg", "n": "bknight.svg",
  "B": "wbishop.svg", "b": "bbishop.svg",
  "P": "wpawn.svg",   "p": "bpawn.svg",
)

#let starting-grid = (
  ("r", "n", "b", "q", "k", "b", "n", "r"),
  ("p", "p", "p", "p", "p", "p", "p", "p"),
  (".", ".", ".", ".", ".", ".", ".", "."),
  (".", ".", ".", ".", ".", ".", ".", "."),
  (".", ".", ".", ".", ".", ".", ".", "."),
  (".", ".", ".", ".", ".", ".", ".", "."),
  ("P", "P", "P", "P", "P", "P", "P", "P"),
  ("R", "N", "B", "Q", "K", "B", "N", "R"),
)

// Coordinates

#let col-to-file = ("a", "b", "c", "d", "e", "f", "g", "h")
#let file-to-col = (
  "a": 0, "b": 1, "c": 2, "d": 3,
  "e": 4, "f": 5, "g": 6, "h": 7,
)

#let coords-to-square(col, row) = col-to-file.at(col - 1) + str(9 - row)
#let square-to-coords(sq) = ((file-to-col.at(sq.at(0)) + 1), (9 - int(sq.at(1))))

// Grid

#let copy-grid(g) = g.map(r => r.map(c => c))
#let on-board(col, row) = col >= 1 and col <= 8 and row >= 1 and row <= 8
#let at(grid, col, row) = {
  if not on-board(col, row) { return "." }
  grid.at(row - 1).at(col - 1)
}

#let find-pieces(grid, color, type) = {
  let pieces = ()
  let test = if color == "white" { is-white } else { is-black }
  for r in range(8) {
    for c in range(8) {
      let p = grid.at(r).at(c)
      if p != "." and piece-type(p) == type and test(p) {
        pieces.push((c + 1, r + 1))
      }
    }
  }
  pieces
}

#let apply-move(grid, col, row, dest-col, dest-row, promotion: none, en-passant: none) = {
  let g = copy-grid(grid)
  let piece = g.at(row - 1).at(col - 1)
  g.at(row - 1).at(col - 1) = "."

  if en-passant != none {
    g.at(en-passant.at(1) - 1).at(en-passant.at(0) - 1) = "."
  }

  if promotion != none {
    let color = if is-white(piece) { upper } else { lower }
    g.at(dest-row - 1).at(dest-col - 1) = color(promotion)
  } else {
    g.at(dest-row - 1).at(dest-col - 1) = piece
  }
  g
}

// Board

#let is-dark-sq(file, rank) = calc.rem(file + rank, 2) == 1

#let render-board(board) = {
  let files = ("a", "b", "c", "d", "e", "f", "g", "h")
  let ranks = ("8", "7", "6", "5", "4", "3", "2", "1")
  let cell-size = 2.8em
  let label-size = 0.4em
  let white = rgb("#f0d9b5")
  let black = rgb("#b58863")

  align(center + horizon, grid(
    columns: (cell-size,) * 8,
    rows: (cell-size,) * 8,
    ..{
      let cells = ()
      for rank in range(8) {
        for file in range(8) {
          let piece = board.at(rank).at(file)
          let sq-color = if is-dark-sq(file, rank) { black } else { white }
          let display = if piece == "." { [] } else {
            image("assets/" + piece-assets.at(piece), width: cell-size * 0.85)
          }

          let labels = ()
          if rank == 7 {
            labels.push(place(bottom + left, dx: 0.15em, dy: -0.15em, text(
              size: label-size,
              fill: if is-dark-sq(file, 7) { white } else { black },
              files.at(file),
            )))
          }
          if file == 7 {
            labels.push(place(top + right, dx: -0.15em, dy: 0.15em, text(
              size: label-size,
              fill: if is-dark-sq(7, rank) { white } else { black },
              ranks.at(rank),
            )))
          }

          cells.push(box(
            width: cell-size,
            height: cell-size,
            fill: sq-color,
            place(center + horizon, display) + labels.fold([], (acc, l) => acc + l),
          ))
        }
      }
      cells
    },
  ))
}
