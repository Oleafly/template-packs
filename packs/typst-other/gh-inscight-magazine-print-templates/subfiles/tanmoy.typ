#import "/template-files/inscight-template.typ": *

#let title = "The Physics of Forgetting: When Information Becomes Heat"
#let authors = ("Tanmoy Pandit",)
#let affiliations = ("Quantum Algorithm Scientist, Espoo, Finland",)
#let abstract = "Every act of remembering, measuring, or deleting information leaves a scar in the fabric of the universe by releasing heat. This connection, known as *Landauer’s Principle*, bridges two of  greatest intellectual adventures—computation and thermodynamics—and reveals that information itself obeys the laws of physics."
#let coverImage = "/covers/tanmoy.svg"
#let authorImage = "/authFaces/tanmoy.png"
#let authorInfo = "*Tanmoy Pandit* is a Quantum Algorithm Scientist at QMill (Espoo, Finland), focusing on quantum error mitigation, quantum noise characterization, and algorithms for NISQ devices, alongside large-scale simulations of open many-body quantum systems. Beyond physics, he switched from  Quantum Algorithm to music—violin and piano—and he's committed to scientist activism and public-interest science through the India March for Science – Abroad Chapter (IMFS-A) and the Breakthrough Science Society (BSS) – Abroad Chapter. #parbreak() This article draws inspiration from: T. Pandit, G. Paul, A. Misra, and P. Chattopadhyay, _Landauer Principle and Thermodynamics of Computation_, *Rep. Prog. Phys.* *88*, 086001 (2025)."
#let received = (month: 11, day: 01, year: 2025)
#let category = "Physics"
#let reviewedBy = ("Archita Sarkar",) 

#show: article.with(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  title: title, 
  authors: authors,
  authorAffiliations: affiliations,
  abstract: abstract,
  coverImage: coverImage,
  authorImage: authorImage,
  authorInfo: authorInfo,
  // authorImageWidth: (40%,40%),
  received: received,
  reviewedBy: reviewedBy,
  // breakAfter: (7,),
  outlinePrefix: [*From Issue #6: *],
)

== A Whisper of Heat

#dcap("When you delete a file from your personal laptop, it vanishes from your screen. But in a deeper sense, it doesn’t disappear—it transforms.  
In 1961,  physicist Rolf Landauer made a bold claim: erasing one bit of information must release a tiny but unavoidable amount of heat into the environment. The minimum possible cost is")
```
Q_"min" = k_B T ln 2
```

where `k_B` is Boltzmann’s constant and `T` is the temperature of the surroundings. At room temperature this is only `2.9 times 10^(-21)` joules per bit—too small to notice, but large enough to impose a fundamental limit on every computer that has ever existed or will ever be built.

Landauer’s insight turned information from an abstract concept into a physical quantity. Knowledge, it seems, comes with a price tag—paid not in dollars, but in entropy.

== The Demon who Cheated the Second Law

The idea traces back to one of physics’ most famous thought experiments. In 1867, James Clerk Maxwell imagined a mischievous being—a “demon”—who could sort fast and slow gas molecules using a tiny trapdoor between two chambers. By letting only the fast ones through one way and slow ones the other, the demon could create a temperature difference out of randomness, apparently defying the second law of thermodynamics:

```
Delta S_"total" = Delta S_"system" + Delta S_"environment" >= 0
```

If such a demon existed, it could create useful work for free, making a perpetual-motion machine of the second kind and this was century old unsolved problems.

== Szilard's Brilliant Simplification

Half a century later in 1929, the Hungarian physicist Leo Szilard gave the demon a more concrete stage. He devised a _Gedankenexperiment_  that distilled Maxwell’s paradox to its purest form: a box containing just a single molecule of an ideal gas in contact with a heat reservoir. His “one-molecule engine” proceeds in four conceptual steps:

#set enum(numbering: "a)")

+ Insert a partition to divide the box into two equal halves of volume `V/2`. The lone molecule lands on one side or the other.

+ Measure which side it’s on. That act of observation gives the demon exactly one bit of information.

+ Attach a frictionless piston to the correct side. The molecule pushes the piston outward, expanding isothermally and doing work 
```
W_"out" = k_B T ln 2
```

+ Remove the partition and reset the system. The demon is ready to start again.

#img(path: "/images/tanmoy1.jpeg", caption: "Schematic of Szilard’s _gedanken experiment_. The demon inserts a partition, measures the molecule’s position, and allows isothermal expansion to extract work `k_B T ln 2`. To repeat the cycle, the demon must erase its memory, dissipating the same heat", position: top, width: 100%, portrait: true)

At first glance, Szilard’s setup appears to defeat the second law: the demon extracts work from random motion without any apparent cost. The catch lies in the demon’s memory. To repeat the cycle, it must erase the record of which side the molecule occupied. According to Landauer, that act of forgetting releases exactly the same energy gained earlier:

```
W_"erase" = k_B T ln 2 = W_"out"
```

Balance restored—the second law follows. The demon can’t win, because the universe always collects its entropic cost.

#img(path: "/images/men.jpg", caption: "In 1867, J C Maxwell imagined a tiny being that could seemingly outwit the second law of thermodynamics. Decades later, Leo Szilard transformed the paradox into a single-molecule engine, showing that information and energy were inseparably linked. In 1961, Rolf Landauer closed the loop, proving that erasing information carries a fundamental thermodynamic cost.", position: bottom, width: 100%, portrait: false)

== When Bits Meet Atoms

This simple realization changed how scientists view both computation and nature. In  Shannon’s information theory, uncertainty is measured by the Shannon entropy

```
H = - sum_i p_i log_2 p_i
```

while in statistical physics, the Boltzmann entropy reads

```
S = -k_B sum_i p_i ln p_i = k_B ln 2 H
```

They are not just mathematically similar—they are the same concept in different units. Every bit of information corresponds to a physical entropy of `k_B ln 2`.

// #colbreak() 

Whenever a computer deletes or erasure data from its hardware chip, it is not merely rearranging symbols on silicon chip of your computer; it is converting structured information into heat that diffuses into the environment. Or as Landauer famously said, *"Information is physical."*

== From Thought Experiment to Real World Technology

For decades, Landauer’s limit was a theoretical curiosity. Today, it defines the holy grail of low-power and quantum computing. Modern transistors waste billions of times more energy per operation than this bound, largely because real devices operate far from equilibrium. But as engineers shrink circuits to atomic scales, and physicists manipulate qubits that are easily disturbed by heat, Landauer’s principle becomes not just elegant but essential.

Recent experiments have even erased information using *angular momentum* instead of energy, and verified quantum versions of the principle using superconducting qubits. Each test confirms the same conclusion: there is always a thermodynamic price for forgetting.

== The Universe Keeps its Books

From Maxwell’s  demon to Landauer’s principle, the message is clear: there is no free lunch, not even for information. Every act of learning creates order; every act of forgetting restores disorder. The heat from your laptop, the power consumed by data centers, and the entropy of black holes are all governed by the same equation.

In a sense, we are all demons—tiny processors in a vast cosmic engine. And as we compute, think, and erase, the universe quietly tallies our debts in units of heat. To know is to order. To forget is to warm the world, ever so slightly.
