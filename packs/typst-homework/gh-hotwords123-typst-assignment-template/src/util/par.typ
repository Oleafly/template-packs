#let indent = context h(par.first-line-indent.amount, weak: true)
#let no-indent = context h(-par.first-line-indent.amount, weak: true)

#let leading = context v(par.leading, weak: true)
#let spacing = context v(par.spacing, weak: true)
#let spacing-eq = context v(par.spacing - 0.15em, weak: true)

#let cont = leading + no-indent
#let cont-eq = spacing-eq + no-indent
