// ============================================================================
// Academic Poster: Physics-Informed Generative World Models for Real-Time Bidding
// KDD 2026 | Typst + peace-of-posters
// ============================================================================
#import "@preview/peace-of-posters:0.5.6" as pop

// --- Page & Layout Setup ---
#set page("a0", margin: 1cm)
#pop.set-poster-layout(pop.layout-a0 + (
    // "paper":            "a0",
    // "size":             (841mm, 1188mm),
    // "body-size":        33pt,
    "heading-size":     39pt,
    // "title-size":       75pt,
    // "subtitle-size":    60pt,
    // "authors-size":     50pt,
    // "institutes-size":  45pt,
    // "keywords-size":    40pt,
))

// --- Custom Minimalist Theme ---
#let primary = rgb("#1a5276")
#let accent  = rgb("#2980b9")
#let lightbg = rgb("#f4f6f7")
#let darkfg  = rgb("#2c3e50")

#pop.set-theme((
  "body-box-args": (
    inset: 0.8em,
    width: 100%,
    stroke: 1.2pt + primary.lighten(60%),
    radius: 6pt,
    fill: white,
  ),
  "body-text-args": (fill: darkfg),
  "heading-box-args": (
    inset: 0.8em,
    width: 100%,
    fill: primary,
    radius: (top: 6pt),
  ),
  "heading-text-args": (fill: white, weight: "bold"),
  "title-box-args": (
    inset: 0.8em,
    fill: gradient.linear(primary, accent, angle: 0deg),
    radius: 8pt,
  ),
  "title-text-args": (fill: white),
))

#set text(size: 28pt, font: "New Computer Modern")
#let box-spacing = 0.8em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

// table
#set table(align: center + horizon, stroke: none, inset: .5em)
#let tlt(..args) = table(table.hline(stroke: 1pt, y: 0), table.hline(stroke: .5pt, y: 1), ..args, table.hline(stroke: 1pt))
// ============================================================================
// TITLE
// ============================================================================
#pop.title-box(
  "Physics-Informed Generative World Models for Real-Time Bidding",
  subtitle: "Deriving Statistical Laws from First Principles",
  authors: "Chenyang Wu¹ · Tianyu Wang² · Shengjun Fang¹ · Mingjun Cao¹ · Pengfei Liu¹ · Zongzhang Zhang¹ · Yeshu Li² · Zhilin Zhang² · Chuan Yu² · Jian Xu² · Bo Zheng²",
  institutes: "¹Nanjing University       ²Alibaba Group",
  keywords: "Real-Time Bidding · Generative World Models · Physics-Informed Statistical Modeling · Normalizing Flow Copula",
  text-relative-width: 70%,
  spacing: 0pt,
  title-size: 54pt,
  subtitle-size: 45pt,
  authors-size: 30pt,
  institutes-size: 29pt,
  keywords-size: 28pt,
  logo: block(height: 300pt, align(horizon, stack(
    grid(
      columns: (1fr, 0.4fr),
      column-gutter: 1cm,
      align(right, image("base/lamda_logo.png")),
      align(right, image("base/nju_color_logo.png")),
    )
  ))),
)

#set par(justify: true)

// ============================================================================
// 3-Column Layout
// ============================================================================
#columns(3, [

// ===================== COLUMN 1 =====================

#pop.column-box(heading: "Motivation & Problem")[
  Existing RTB simulators rely on *log-domain MSE regression*, which is fundamentally ill-posed for auction data:\
  *①* *Log-MSE biases the mean:* Jensen's inequality gives $EE[log Y] != log EE[Y]$, so log-domain regression systematically underestimates $EE[Y]$.\
  *②* *Ignores zero-inflation:* A large fraction of auctions yield zero feedback (lost bids). MSE treats these as ordinary small values.\
  *③* *Ignores extreme heteroscedasticity:* Variance scales as $op("Var")[Y] prop mu^p$ — orders-of-magnitude differences across campaigns that a single MSE loss cannot handle.\
  *④* *Ignores heavy tails:* RTB feedback exhibits power-law tails; MSE penalises extreme events symmetrically, distorting the fit.\
  *⑤* *Ignores tail dependence:* Cost and Value share the same winning impressions, so they are strongly coupled in extreme regimes; MSE models each variable independently.\
  *Our goal:* Estimate the full conditional joint density $P_theta (bold(y)_t | h_t, bold(b)_t, bold(c))$ that respects zero-inflation, heavy tails, and tail dependence — the indispensable simulator for offline RL in computational advertising.
]

#pop.column-box(heading: "Paper Outline")[
  // *① Marginal Modeling*
  // #block(fill: lightbg, inset: 0.4em, radius: 4pt, width: 100%)[
  //   Statistical model selection *fails* in heavy-tail regimes (Flat Minima). We instead derive distributions from *first principles* (physics-informed). Empirical evidence validates the assumptions. ZI-GB2 serves as the practical surrogate.
  // ]
  // *② Dependence Modeling*
  // #block(fill: lightbg, inset: 0.4em, radius: 4pt, width: 100%)[
  //   Cost and Value are *perfectly tail-dependent* ($lambda_u = 1$) by construction — a Gaussian copula ($lambda_u = 0$) is provably wrong. A *Normalizing Flow copula* flexibly captures the full nonlinear dependence.
  // ]
  // *③ Experimental Results*
  // #block(fill: lightbg, inset: 0.4em, radius: 4pt, width: 100%)[
  //   SOTA *distributional fidelity* on production Taobao data. Physics-informed objectives are *architecture-agnostic* and exhibit superior *neural scaling*.
  // ]

  *① Marginal Modeling*\
  #hide[① ]Physics-informed derivation; ZI-GB2 surrogate.
  
  *② Dependence Modeling*\
  #hide[② ]Perfect tail dependence; NF copula.

  *③ Experimental Results*\
  #hide[③ ]SOTA fidelity; architecture-agnostic.
]


// #pop.column-box(heading: "Paper Outline")[
//   #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
//   #set text(24.2pt)
//   #diagram(
//     node-stroke: .08em,
//     node-fill: gradient.radial(lightbg, primary.lighten(70%), center: (30%, 20%), radius: 80%),
//     spacing: 3em,
//     edge-stroke: primary,
//     node((0,0), [*Marginal\ Modeling*], inset: 1em),
//     edge("-|>"),
//     node((1,0), [*Dependence\ Modeling*], inset: 1em),
//     edge("-|>"),
//     node((2,0), [*Experimental\ Results*], inset: 1em),
//   )
// ]

#pop.column-box(heading: "Key Notation")[
  #v(16pt)
  #table(
    columns: (auto, 1fr),
    stroke: none,
    inset: (x: 0.4em, y: 0.3em),
    align: (right, left),
    table.hline(stroke: 0.8pt),
    table.header([*Symbol*], [*Description*]),
    table.hline(stroke: 0.5pt),
    [$bold(y)_t$],     [Multi-dimensional feedback vector (clicks, cost, GMV)],
    [$h_t$],           [Interaction history up to time $t$],
    [$bold(b)_t$],     [Bidding control vector (action)],
    [$bold(c)$],       [Static campaign covariates],
    [$N$],             [Number of winning impressions in a slot],
    [$X_i$],           [Per-impression value (microscopic mark)],
    [$Y = sum X_i$],   [Cumulative feedback aggregated over $N$ impressions],
    [$lambda$],        [Poisson intensity (latent market activity rate)],
    [$pi$],            [Zero-inflation probability (structural zeros)],
    [$mu, sigma^2$],   [Mean and variance of $ln lambda$ (lognormal heterogeneity)],
    [$alpha, beta$],   [Gamma shape and rate parameters of mark $X_i$],
    [$a,p,q,b$],       [ZI-GB2 distribution shape and scale parameters],
    [$lambda_u$],      [Upper tail dependence coefficient between Cost and Value],
    table.hline(stroke: 0.8pt),
  )
  #v(24pt)
]

// ===================== COLUMN 2 =====================

#pop.column-box(heading: "Marginal Modeling")[
  === Why Statistical Model Selection Fails

  In heavy-tail regimes, NLL is dominated by the bulk of the distribution. Multiple families yield *indistinguishably similar NLL* scores ("Flat Minima"), yet imply *wildly different moments* — making data-driven selection unreliable.

  // #v(0.2em)
  // #text(size: 23pt)[
  //   #tlt(
  //     columns: (1fr, auto, auto, auto),
  //     table.header[*Distribution*][*Test NLL*][*Mean ($10^3$)*][*Var ($10^7$)*],
  //     [ZI-SLN],        [$9.2484$], [$4.42$], [$2.04$],
  //     [ZI-GB2],        [$9.2485$], [$4.39$], [$2.02$],
  //     [ZI-GLN],        [$9.2485$], [$4.37$], [$1.90$],
  //     [ZI-TLN],        [$9.2491$], [$4.40$], [$2.06$],
  //     [ZI-Lognormal],  [$9.2495$], [$4.42$], [$2.14$],
  //     [ZI-BurrXII],    [$9.2546$], [$4.47$], [$4.00$],
  //     [ZI-Log-logistic],[$9.2569$],[$4.74$], [$39.5$],
  //     [ZI-Gamma],      [$9.2909$], [$4.38$], [$1.28$],
  //   )
  // ]
  // #text(size: 22pt)[_NLL gap $< 0.005$ yet variance differs by $30times$._]

  // #v(0.2em)
  === Physics-Informed Approach: Axioms & Hypotheses

  #block(fill: lightbg, inset: 0.35em, radius: 4pt, width: 100%)[
    *Axiom 1 — Discrete Counting:*  $N tilde "Poisson"(lambda Delta t)$
  ]
  #v(0.06em)
  #block(fill: lightbg, inset: 0.35em, radius: 4pt, width: 100%)[
    *Axiom 2 — Compound Accumulation:*  $Y = sum_(i=1)^N X_i$
  ]
  #v(0.06em)
  #block(fill: lightbg, inset: 0.35em, radius: 4pt, width: 100%)[
    *Axiom 3 — Shared Event:*  Cost & Value coupled via shared winning impressions $N$
  ]
  #v(0.06em)
  #block(fill: lightbg, inset: 0.35em, radius: 4pt, width: 100%)[
    *Axiom 4 — Dual Zero-Inflation:*  Structural ($e^(-lambda Delta t)$) + Anomalous gate $G$
  ]
  #v(0.15em)
  *Hypothesis 1:* $ln lambda tilde cal(N)(mu, sigma^2)$ (multiplicative heterogeneity)\
  *Hypothesis 2:* $X_i tilde "Gamma"(alpha, beta)$ (microscopic marks)

  // #v(0.2em)
  === Evidence for Hypothesis 1

  #figure(caption: [Q-Q plot of latent $ln lambda$ vs.\ standard normal ($R^2 = 0.99942$)])[
    #image("images/fig3_posterior_qq_plot.png", width: 74%)
  ]

  #v(0.2em)

  *Evidence for Hypothesis 2* (Gamma marks): fitting the distribution of individual PGMV marks:

  #text(size: 23pt)[
    #tlt(
      columns: (1fr, auto, auto, auto),
      table.header[*Model*][*NLL*][*KS Stat*][*AD Stat*],
      [Log-normal],  [$3389.17$], [$0.1129$], [$18.07$],
      [Gumbel],      [$4358.78$], [$0.2265$], [$95.49$],
      [*Gamma*],     [*$3293.00$*], [*$0.0554$*], [*$3.05$*],
    )
  ]
  #text(size: 22pt)[_Gamma decisively outperforms alternatives in Anderson-Darling test._]

  // #v(0.2em)
  === Derived Laws & ZI-GB2 Surrogate

  *Traffic* → ZI-Poisson-Lognormal\
  *Value* → ZI-Tweedie-Lognormal (ZI-TLN)

  Since ZI-TLN lacks a closed form, we use *ZI-GB2* as the practical surrogate:
  $ P(y) = (1 - pi) delta(y) + pi dot (a y^(a p - 1)) / (b^(a p) B(p,q) [1 + (y\/b)^a]^(p+q)) $

  #text(size: 23pt)[
    #tlt(
      columns: (1fr, auto, auto, auto, auto),
      table.header[*Surrogate*][*NLL Gap*][*VaR Err*][*Mean Err*][*Var Err*],
      [ZI-Lognormal], [$0.094$], [$54.3%$], [$41.2%$], [$1725%$],
      [ZI-SLN], [$0.086$], [$30.5%$], [$30.6%$], [$1075%$],
      [*ZI-GB2 (Ours)*], [*$0.047$*], [*$11.5%$*], [*$18.3%$*], [*$36.6%$*],
    )
  ]
]

// ===================== COLUMN 3 =====================

#pop.column-box(heading: "Dependence Modeling: NF Copula")[
  === Perfect Tail Dependence from Physics

  *Proposition* (Asymptotic Tail Dependence): Under the axioms and hypotheses,
  $ lim_(u arrow 1^-) P(F_C (C) > u | F_V (V) > u) = 1 $
  Cost and Value are *perfectly tail-dependent*.

  === Normalizing Flow Copula

  #figure(caption: [Conditional tail probability $P(U_("PGMV") > u | U_("PV") > u)$ (where $U = F(dot)$ denotes the probability integral transform) vs.\ tail threshold $(1-u)$. Real data maintains high co-extreme dependence as $u arrow 1$; the NF copula tracks this faithfully, while the Gaussian copula incorrectly decays to independence.])[
    #image("images/fig4_tail_dependence_cond_prob.png", width: 80%)
  ]

  #text(size: 25.3pt)[
    #tlt(
      columns: (auto, auto, auto, auto, auto),
      table.header[*Copula*][*Gaussian*][*Student-t*][*Gumbel*][*NF (Ours)*],
      [*Test NLL*], [$-1.405$], [$-1.441$], [$-0.540$], [*$-1.909$*],
    )
  ]
  #text(size: 24.5pt)[_NF copula achieves best NLL and correctly captures tail dependence._]
]

#pop.column-box(heading: "Main Results: Distributional Fidelity")[
  #v(3pt)
  #text(size: 22pt)[
    #show table.cell.where(y: 0): set text(.7em)
    #tlt(
      columns: (160pt, auto, auto, auto, auto, auto, auto, auto, auto),
      table.header[#text(1.3em)[*Method*]][*CLICK\ SMAPE*][*CLICK\ CRPS*][*COST\ SMAPE*][*COST\ CRPS*][*PV\ SMAPE*][*PV\ CRPS*][*VALUE\ SMAPE*][*VALUE\ CRPS*],
      [BFM (MSE)],    [1.763], [1.417], [1.680], [0.860], [1.974], [50.46], [1.756], [8.231],
      [BFM (GB2)],    [0.685], [0.688], [0.775], [0.605], [0.479], [12.13], [0.738], [3.434],
      [Inf. (MSE)],   [1.226], [0.473], [1.358], [0.660], [0.388], [14.80], [0.567], [3.670],
      [Inf. (SLN)],   [*0.188*], [*0.381*], [*0.266*], [0.330], [0.377], [14.20], [0.348], [2.586],
      [Inf. (GB2)],   [0.352], [0.638], [0.269], [*0.316*], [*0.314*], [*8.81*], [*0.342*], [*2.091*],
      [Trans. (MSE)], [1.432], [0.944], [1.635], [0.787], [0.476], [16.66], [0.808], [4.606],
      [Trans. (GB2)], [0.706], [0.734], [0.772], [0.603], [0.471], [12.16], [0.733], [3.445],
    )
  ]
  #v(1pt)

  *Key insights:*
  - *MSE* yields the worst performance across *all* architectures, confirming log-MSE regression is ill-suited for RTB
  - *ZI-GB2* achieves SOTA distributional fidelity across all metrics (PV CRPS: $14.80 arrow 8.81$, Value CRPS: $3.670 arrow 2.091$)
  - Physics-informed loss is *architecture-agnostic*: consistent gains on BFM, Informer, and Transformer backbones
]

// #pop.column-box(heading: "Conclusions")[
//   + *Motivation:* Log-MSE regression fails to model zero-inflation, heteroscedasticity, heavy tails, and tail dependence — and cannot even estimate the mean correctly.
//   + *Marginal:* Statistical model selection fails in heavy-tail regimes; physics-informed derivation from axioms yields ZI-PLN and ZI-TLN laws; *ZI-GB2* is the efficient surrogate.
//   + *Dependence:* Shared winning impressions imply $lambda_u = 1$; *NF copula* captures this where Gaussian copula ($lambda_u = 0$) fails.
//   + *Results:* SOTA distributional fidelity; $alpha_("GB2") approx 0.16 > alpha_("MSE") approx 0.12$ — physics-informed models scale better.
// ]

])
