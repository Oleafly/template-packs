// Showcase deck. Compile from the repository root:
//   typst compile --root . examples/seminar.typ

#import "../lib.typ": *

#show: brownbag-theme.with(
  accent: "blue",
  config-info(
    title: [Monetary Policy Transmission with Heterogeneous Households],
    short-title: [Monetary Transmission with Heterogeneity],
    subtitle: [Evidence from a quantitative HANK model],
    author: ("Jane Doe", "John Smith"),
    institution: [Department of Economics, University of Example],
    date: datetime.today(),
  ),
)

#title-slide(extra: [Macro Seminar])

#focus-slide[
  How much of monetary transmission works through #alert[household income] rather than the interest rate?
]

// A roadmap is a plain outline. Repeat these two lines at the start of a
// section and that section is highlighted.
== Roadmap

#outline()

= Motivation

== Why household heterogeneity matters

#muted[The representative-agent benchmark and where it fails]

Representative-agent models transmit policy through *intertemporal substitution*.
In the data, that channel is small.

#pause

- Many households hold #highlight[little liquid wealth] and have a high marginal propensity to consume.
- Their consumption responds to #alert[income], not to the real rate $r_t$.
  - So the indirect, general-equilibrium effect carries most of the transmission.

#pause

+ How large is the indirect effect?
+ Does it depend on the distribution of liquid assets?

= Model

== The household problem

A household with assets $a$ and idiosyncratic productivity $z$ solves

$ V_t (a, z) = max_(c, a') u(c) + beta EE_t [V_(t+1) (a', z') | z] $

subject to the budget constraint and a borrowing limit,

$ c + a' = (1 + r_t) a + w_t z - tau_t (z), quad a' >= underline(a). $

#pause

The Euler equation holds with inequality for constrained households:
$u'(c_t) >= beta (1 + r_(t+1)) EE_t [u'(c_(t+1))]$.

== Decomposing the consumption response

Aggregate consumption is $C_t = integral c_t (a, z) dif mu_t$. Differentiating with respect to the policy shock,

$
  dif C_0 = underbrace(integral_0^oo (partial C_0) / (partial r_t) dif r_t dif t, "direct effect")
  + underbrace(integral_0^oo ((partial C_0) / (partial w_t) dif w_t + (partial C_0) / (partial tau_t) dif tau_t) dif t, "indirect effects").
$

#pause

In the calibrated model of #cite(<kaplan2018hank>, form: "prose") the direct effect accounts for #alert[less than 20%] of the total.

== When is the indirect effect large?

#assumption(title: [Liquidity])[
  A mass $lambda > 0$ of households is at the borrowing limit $underline(a)$.
]

#pause

#proposition(number: 1, title: [Transmission shares])[
  Let $m$ denote the average marginal propensity to consume. The indirect share of the consumption response is increasing in $m$, and
  $ lim_(m -> 1) (dif C_0^"indirect") / (dif C_0) = 1. $
]

#pause

#proof[
  Constrained households have $partial c \/ partial r = 0$. Aggregate over $mu_t$ and let $lambda -> 1$.
]

== Impulse responses to a 25 bp cut

// An image with no explicit size fills the height that the rest of the slide
// leaves free. Give it a `width:` or `height:` to size it yourself.
#figure(
  image("figures/irf.svg"),
  caption: [Consumption response to the shock, percent deviation from steady state.],
)

#keypoint[Same peak response, entirely different channels @auclert2019redistribution.]

#source[stylised responses, for illustration only.]

== What drives the difference?

// With a figure in one column, the columns take the remaining slide height.
#cols(columns: (5fr, 6fr), align: horizon)[
  - Both models are calibrated to the same peak response.
  - In HANK, constrained households spend the #alert[income] gain, which raises demand further.
  - That feedback makes the response more persistent.
][
  #figure(image("figures/irf.svg"))
]

== Is the decomposition robust?

#quote(block: true, attribution: [Referee 2])[
  The authors should clarify whether the ranking of channels survives once the borrowing limit is calibrated to the data rather than set to zero.
]

#pause

The decomposition is model-dependent#footnote[With a representative agent the direct effect is above 95%, because the household is always on its Euler equation.] but the ranking of channels is robust across calibrations. #goto(<calibration>)[Calibration]

= Results

== Consumption response by liquid wealth

#figure(
  table(
    columns: 4,
    table.header[][(1)][(2)][(3)],
    [Rate cut $times$ low liquidity], [0.412], [0.398], [0.371],
    [], [(0.087)], [(0.091)], [(0.094)],
    [Rate cut], [0.053], [0.049], [0.046],
    [], [(0.041)], [(0.040)], [(0.043)],
    table.hline(stroke: 0.5pt + luma(140)),
    [Household FE], [], [Yes], [Yes],
    [Region $times$ year FE], [], [], [Yes],
    [Observations], [48,210], [48,210], [47,906],
  ),
  caption: [Dependent variable: log consumption growth. Standard errors clustered by household in parentheses. Illustrative numbers.],
)

#keypoint[The response is concentrated among #alert[low-liquidity] households.]

= Computation

== Solving the household problem

The policy functions are computed with the endogenous grid method @carroll2006egm:

```julia
function egm_step(c_next, a_grid, z_grid, Π, r, w; β = 0.986, γ = 2.0)
    Eu = Π * (c_next .^ (-γ))'             # expected marginal utility
    c  = (β * (1 + r) .* Eu') .^ (-1 / γ)  # invert the Euler equation
    a  = (c .+ a_grid .- w .* z_grid') ./ (1 + r)
    return c, a
end
```

Convergence takes about 40 iterations on a grid of `200 × 7` points.

#focus-slide[Thank you.]

// Backup slides: outside the slide total. A slide that is the target of a
// `#goto` gets a "Back" link in its footer.
#show: appendix

== Calibration <calibration>

#figure(
  table(
    columns: 3,
    align: (left, center, left),
    table.header[Parameter][Value][Target],
    [Discount factor $beta$], [0.986], [Liquid wealth to GDP],
    [Risk aversion $gamma$], [2.0], [Standard],
    [Borrowing limit $underline(a)$], [−1.0], [One quarter of average income],
    [Share at the limit $lambda$], [0.28], [Hand-to-mouth households],
  ),
  caption: [Quarterly calibration. Illustrative numbers.],
)

== References

#bibliography("refs.bib")
