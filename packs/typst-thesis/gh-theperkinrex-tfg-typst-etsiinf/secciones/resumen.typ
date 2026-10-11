#import "../sizes.typ": *
#import "../util.typ": custom_outline_size

#{
  custom_outline_size.update(small_size)
  [= Resumen]
  custom_outline_size.update(none)
}
// #state("heading_outline_size").update(_ => small_size)

// #state("heading_outline_size").update(_ => none)

#lorem(200)

#lorem(100)


#{
  custom_outline_size.update(small_size)
  [= Abstract]
  custom_outline_size.update(none)
}

#lorem(200)

#lorem(100)