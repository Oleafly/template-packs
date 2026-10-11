#import "../../macros/probability.typ": *

== Probability notation

The probability module provides common probability operators, distribution names, and moment helpers.

=== Operators and distributions

$Pr(A)$, $Law(X)$, $X_1, dots, X_n iid P$.

$Normal(mu, sigma^2)$, $Bern(p)$, $Cat(pi)$, and $Poisson(lambda)$.

=== Expectations, variances, and covariances

#EE[$X$]

#EE($X$, given: $Y$)

#EE($X$, given: $Y$, measure: $P$)

#Var[$X$]

#Var($X$, given: $Y$)

#Var($X$, given: $Y$, measure: $P$)

#Cov[$X$]

#Cov($X$, $Y$)

#Cov($X$, $Y$, given: $Z$)

#Cov($X$, $Y$, given: $Z$, measure: $P$)

=== Indicators

$Ind(A)$ and $EE[Ind(A)] = Pr(A)$.
