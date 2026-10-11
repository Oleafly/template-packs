#import "../template.typ": glossary-used, translated

#let glossary = (
  (key: "central-limit-theorem", long: "Central Limit Theorem", description: "A theorem stating that sums of independent random variables tend toward a normal distribution."),
  (key: "normal-distribution", long: "Normal Distribution", description: [A continuous bell-shaped probability distribution $N(mu, sigma^2)$.]),
  (key: "iid", long: "i.i.d.", description: "Independent and identically distributed random variables."),
  (key: "variance", long: "Variance", description: [A measure of dispersion, denoted $sigma^2$.]),
  (key: "pmf", long: "PMF", description: "Probability Mass Function."),
)

#let glossary-list() = glossary-used(translated("glossary"), glossary)
