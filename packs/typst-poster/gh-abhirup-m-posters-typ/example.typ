#import "settings.typ": *
#import "helpers.typ": *

#show: poster.with(
  background: "exampleImages/background.svg",
  sizeMul: 4,
)

#header(
  logo: rect(inset: 0pt, image("exampleImages/iiser.png"), fill: white),
  title: [Mott Criticality as The Confinement Transition of A Pseudogap-Mott Metal],
  subtitle: "a new auxiliary model approach for correlated electrons",
  firstAuthor: [Abhirup Mukherjee],
  otherAuthors: ([S R Hassan], [A Mukherjee], [N S Vidhyadhiraja], [A Taraphder], [S Lal]),
  reference: [New J. Phys. 28 013503],
)
#let chunk1 = chunk(
  title: "Challenges: Pseudogap & Strange Metal",
  layout: ((1, 2, 3), (4,)),
  widths: ((1fr, 0.9fr, 0.9fr), (1fr,)),
  {image(width: 100%, "exampleImages/dagotto.jpeg")},
  {image(width: 100%, "exampleImages/fermiArc1.png")},
  [
    Puzzling experimental observations
  ],
  [
    - Nature & origin of *pseudogap* and strange metal
    - Parent phase of Mott insulator at 1/2−filling ?
  ],
)

#let chunk2 = chunk(
  title:[Our Approach, In a Nutshell],
  layout: ((1,), ),
  widths: ((1fr,), ),
  {image(width: 100%, "exampleImages/tilingHamiltonian.svg")},
)

#let chunk3 = chunk(
  title: "Phase Diagram & Pseudogapping Transition",
  layout: ((1, 2), (3,)),
  widths: ((1fr, 0.9fr), (1fr,)),
  {image(width: 90%, "exampleImages/phaseDiagram.pdf")},
  {image(width: 90%, "exampleImages/Ad_zoomin_77-1500.pdf")},
  [
    #v(-0.5em)
    $ Delta J(k_1, k_2) ~ (J^2 + 4 J W) $
    #v(-0.5em)
    - Competition leads to *Kondo breakdown* for $W < 0$
    - pseudogap between Fermi liquid and Mott insulator,
    - Impurity spectral function shows *pseudogap* at $omega = 0$
  ]
)

#let chunk4 = chunk(
  title: "Kondo Breakdown Through the PG",
  layout: ((1, 2), (3,)),
  widths: ((1fr, 1fr), (1fr,)),
  {image(width: 90%, "exampleImages/sdz_77-1500.pdf")},
  {image(width: 90%, "exampleImages/QPR_77-1500.pdf")},
  [
    #v(-0.5em)
    - PG marked by vanishing of *quasiparticle residue*
    - Finite magnetisation appears on impurity
    - Fixed point theory: long-range *two-channel* Kondo model
  ]
)

#let chunk5 = chunk(
  title: "Luttinger Surfaces in the Pseudogap",
  layout: ((1, 2,), (3,)),
  widths: ((1fr, 1.2fr,), (1fr,)),
  {image(width: 100%, "exampleImages/kspaceDOS-77.pdf")},
  {image(width: 100%, "exampleImages/selfEnergy_d_fit_77-1500.pdf")},
  [
    - PG shows *electronic differentiation* in lattice DOS
    - Antinodes gapped, nodes gapless
    - Robust exponent of 2 in *self-energy*: $1\/Sigma^(prime prime) ~ 1\/Sigma_0^(prime prime) + omega^2$
  ]
)

#let chunk6 = chunk(
  title: "Long-Ranged Entanglement",
  layout: ((1, 2,), (3,)),
  widths: ((1fr, 1fr,), (1fr,)),
  {image(width: 90%, "exampleImages/I2-di_77-700.pdf")},
  {image(width: 90%, "exampleImages/QPR_77-1500.pdf")},
  [
    - real-space correlations and entanglement becomes *long-ranged* in the pseudogap
    - Quantum Fisher information shows a jump in *multipartite entanglement* of 2 in FL to 5 within PG.
  ]
)

#let chunk7 = chunk(
  title: [Singular Nodal Metal at Critical Point],
  layout: ((1, 2,), (3,)),
  widths: ((0.5fr, 1fr,), (1fr,)),
  {image(width: 90%, "exampleImages/nodalMetal.pdf")},
  [
    Nodal non-Fermi liquid described by *Hatsugai-Kohmoto model*
    $ sum_(k, sigma) epsilon_k n_(k sigma) + U sum_k n_(k arrow.t) n_(k arrow.b) $
  ],
  [deconfined *holon-doublon* excitations],
)

#let chunk8 = chunk(
  title: "Main Takeaways",
  layout: ((1,), ),
  widths: ((1fr,), ),
  [
    - Realisation of Mott’s vision with deconfined holes & doubles
    - new phase of strongly interacting quantum matter
    - noisy, incoherent environment for electrons
  ] 
  + align(center, [ == Acknowledgements]) + [AM thanks IISER Kolkata for funding via JRF/SRF. SL thanks SERB for funding through MATRICS and Core Research Grants.],
)

#let row1 = row(boxes: (chunk1, chunk2), ratios: (0.45fr, 0.55fr))
#let row2 = row(boxes: (chunk3, chunk4), ratios: (0.5fr, 0.5fr))
#let row3 = row(boxes: (chunk5, chunk6), ratios: (0.5fr, 0.5fr))
#let row4 = row(boxes: (chunk7, chunk8), ratios: (0.43fr, 0.57fr))

#grid(
  rows: auto,
  gutter: 1em,
  separator(),
  row1,
  separator(),
  row2,
  separator(),
  row3,
  separator(),
  row4,
  // stack(dir:ltr, spacing: 1fr, )
)
