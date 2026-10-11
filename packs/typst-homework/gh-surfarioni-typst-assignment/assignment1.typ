#import "lib.typ":*
#show: doc => conf(
  title: [Assignment 1],
  authors: [XYZ XYZ],
  id: [703820582],
  email: "703820582@edu.cn",
  doc
)

= Q1

First, we can model this problem as a optimization problem:

- Objective function

$
  min_(bold(w)) bold(w)^T bold(Sigma) bold(w)
$

- Constraint

$
  bold(w)^T bold(mu_e) = bold(mu^*) - bold(R_f)
$

Set up the Lagrangian:

$
  cal(L) = bold(w)^T bold(Sigma) bold(w) - lambda(bold(w)^T bold(mu_e) - bold(mu^*) + bold(R_f))
$

And we derivative with respect to $bold(w), lambda$, respectively.

$
  frac(partial cal(L),partial bold(w)) = 2 bold(Sigma) bold(w) - lambda bold(mu_e) arrow.r.double bold(w) = lambda/2 bold(Sigma)^(-1) bold(mu_e)
$

$
  frac(partial cal(L),partial lambda) = bold(w)^T bold(mu_e) - (bold(mu_e)-bold(R_f)) = 0 arrow.r.double bold(w)^T bold(mu_e) = bold(mu^*) - bold(R_f)
$

Eliminate $w$ to solve for $lambda$:

Substitute $bold(w) = lambda/2 bold(Sigma)^(-1) bold(mu_e)$, 

$
  (lambda/2 bold(Sigma)^(-1) bold(mu_e))^T bold(mu_e) = bold(mu^*-R_f) arrow.r.double lambda = frac(2(bold(mu^*-R_f)),bold(mu_e^T Sigma^(-1)mu_e))
$

And then we substitute $lambda$,

$
  bold(w)^* = lambda/2 bold(Sigma)^(-1) bold(mu_e) = frac(2(bold(mu^*-R_f)),bold(mu_e^T Sigma^(-1)mu_e)) dot 1/2 bold(Sigma^(-1) mu_e) = (frac(bold(mu^*-R_f),bold((mu_e)^T)Sigma^(-1)mu_e)) dot bold(Sigma^(-1) mu_e)
$

The answer is #answer()[
  $
    bold(w)^* = (frac(bold(mu^*-R_f),bold((mu_e)^T)Sigma^(-1)mu_e)) dot bold(Sigma^(-1) mu_e)
  $
]

= Q2

- average return：0.0077
- t value：2.4227
- p value：0.0160

= Q3

- average return: 0.0148
- t value: 5.5662
- p value: 0.0000
