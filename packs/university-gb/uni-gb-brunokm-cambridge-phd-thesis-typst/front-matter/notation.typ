// Mathematical conventions and standard measure/probability notation.
#let groups = (
  (title: [Sets and measures], entries: (
    ([$NN, ZZ, RR, CC$], [Natural numbers (including zero), integers, real numbers, and complex numbers]),
    ([$RR^d$], [$d$-dimensional Euclidean space]),
    ([$(S, cal(A), mu)$], [A measure space with $sigma$-algebra $cal(A)$ and measure $mu$]),
    ([$cal(B)(S)$], [Borel $sigma$-algebra of a topological space $S$]),
    ([$lambda$], [Lebesgue measure on $RR^d$]),
    ([$bold(1)_A$], [Indicator function of a set $A$]),
    ([$integral_S f dif mu$], [Integral of $f$ with respect to $mu$]),
    ([$nu lt.double mu$], [Absolute continuity of $nu$ with respect to $mu$]),
    ([$(dif nu) / (dif mu)$], [Radon-Nikodym derivative of $nu$ with respect to $mu$, when it exists]),
    ([$L^p (mu)$], [Measurable functions with finite $integral |f|^p dif mu$, identified up to $mu$-null sets; $1 <= p < infinity$]),
  )),
  (title: [Probability], entries: (
    ([$(Omega, cal(F), bb(P))$], [A probability space: outcomes, events, and probability measure]),
    ([$bb(P)(A)$], [Probability of an event $A in cal(F)$]),
    ([$X tilde mu$], [The random variable $X$ has distribution $mu$]),
    ([$bb(E)[X]$], [Expectation of an integrable random variable $X$]),
    ([$bb(E)[X mid(|) cal(G)]$], [Conditional expectation given a sub-$sigma$-algebra $cal(G) subset.eq cal(F)$]),
    ([$op("Var")(X)$], [Variance $bb(E)[(X - bb(E)[X])^2]$]),
    ([$op("Cov")(X, Y)$], [Covariance $bb(E)[(X - bb(E)[X])(Y - bb(E)[Y])]$]),
    ([$X_n limits(arrow)^"a.s." X$], [Almost sure convergence: convergence outside an event of probability zero]),
    ([$X_n limits(arrow)^bb(P) X$], [Convergence in probability]),
    ([$X_n limits(arrow)^"d" X$], [Convergence in distribution]),
  )),
)
