// Page numbers in the outer bottom corners (or centred, position = "center").
// Odd page = right (right corner), even page = left (left corner).
// To hide the number on a page, put #no-number on it.

#import "config.typ": cfg, number-box-height

#let no-number = [#metadata("no-number") <no-number>]

#let _hidden(page-no) = query(<no-number>).any(m => m.location().page() == page-no)

#let page-number() = context {
  if not cfg.numbers.enabled { return }
  let phys = here().page()
  if _hidden(phys) { return }
  let n = counter(page).get().first()
  let is-right = calc.odd(phys)
  let w = 15mm
  let centered = cfg.numbers.position == "center"
  let dx = if centered { (page.width - w) / 2 } else if is-right { page.width - cfg.numbers.x - w } else { cfg.numbers.x }
  place(
    top + left,
    dx: dx,
    dy: page.height - cfg.numbers.y - number-box-height / 2,
    box(width: w, height: number-box-height, align(
      (if centered { center } else if is-right { right } else { left }) + horizon,
      text(size: cfg.numbers.size, fill: cfg.numbers.color, number-type: "lining", str(n)),
    )),
  )
}
