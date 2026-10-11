// Stochastic-process notation.

#let Filtration = math.op("F")
#let Mart = math.op("Mart")
#let adapted = math.op("adapted")
#let predictable = math.op("predictable")
#let stopping = math.op("stopping")

#let FF(t) = $cal(F) _ #t$
#let process(x, t) = $#x _ #t$
#let stopped(x, tau, t) = $#x _ (#t inter #tau)$
