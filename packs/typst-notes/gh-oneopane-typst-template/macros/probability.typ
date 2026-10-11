// Probability notation.

#let Pr = math.op("Pr")
#let Law = math.op("Law")
#let iid = math.op("iid")

#let Normal = math.op("Normal")
#let Bern = math.op("Bern")
#let Cat = math.op("Cat")
#let Poisson = math.op("Poisson")

#let EE(x, given: none, measure: none) = {
  let op = if measure == none { $op("E")$ } else { $op("E")_#measure$ }
  if given == none {
    $#op lr([#x])$
  } else {
    $#op lr([#x | #given])$
  }
}
#let Var(x, given: none, measure: none) = {
  let op = if measure == none { $op("Var")$ } else { $op("Var")_#measure$ }
  if given == none {
    $#op lr([#x])$
  } else {
    $#op lr([#x | #given])$
  }
}
#let Cov(x, given: none, measure: none, ..args) = {
  let pos = args.pos()
  if args.named().len() > 0 {
    panic("Cov received unexpected named arguments")
  }
  let op = if measure == none { $op("Cov")$ } else { $op("Cov")_#measure$ }
  if pos.len() == 0 {
    if given == none {
      $#op lr([#x])$
    } else {
      $#op lr([#x | #given])$
    }
  } else if pos.len() == 1 {
    let y = pos.at(0)
    if given == none {
      $#op lr([#x, #y])$
    } else {
      $#op lr([#x, #y | #given])$
    }
  } else {
    panic("Cov accepts at most two positional arguments")
  }
}

#let Ind(x) = $bb(1)_#x$
