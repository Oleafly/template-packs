// Core template, constants, and color palette
#import "template.typ": *
#import "constants.typ": *
#import "colors.typ": *
// Drawing helpers for figures and plots
#import "@preview/cetz:0.4.0": *
#import "@preview/cetz-plot:0.1.2": plot, chart
// PDF manipulation and paragraph split helpers
#import "@preview/muchpdf:0.1.1": muchpdf
#import "@preview/subpar:0.2.2"

// Apply global theorem styling rules
#show: thmrules

// Definition box style with tighter spacing
#let definition = thmbox("definition", "Definition", inset: (x: par-first-line-indent, top: 0.3em, bottom: 0.3em))

// Place table captions above the content
#show figure.where(kind: table): set figure.caption(position: top)

// Defines boolean state if we are in the outline or not
#let in-outline = state("in-outline", false)

// Defines a flexible caption that returns the short version if we are in the outline, else the long version (actual figure caption)
#let flex-caption(short, long) = context {
  if in-outline.get() [#short] else [#long]
}

// Set in-outline state to true when we are actually in an outline
#show outline: it => in-outline.update(true) + it + in-outline.update(false)

#show figure.caption.where(kind: image): it => {
  let numbering = if it.numbering != none {
    [~] + context it.counter.display(it.numbering)
  }
    [#it.supplement#numbering#it.separator#it.body]
}

// Dissertation metadata and title page content
#show: project.with(
  title: "Advanced Procrastination \nDynamics in Graduate Studies",
  author: (
    name: "Jane Doe",
    email: "j.doe@sleep.uot.edu",
    affiliation: "Institute of Deadline Extension",
  ),
  city: "Panic City",
  university: "University of Typst Templates",
  department: "Department of Caffeine Research",
  date-submission: datetime(year: 2026, month: 1, day: 1),
  date-defense: datetime(year: 2026, month: 1, day: 2),
  inside-outside-margins: true,
)


// Start with blank frontmatter page, reset numbering, and show synopsis
#context {
      set page(header: "", footer: "")
      pagebreak(to: "odd")
      counter(page).update(1)
      chapter-page[Synopsis]
}


#let section-page-parity = "even" // Forces chapters to open on even pages

#pagebreak-clean(to: section-page-parity)
= Introduction: The Art of Doing Nothing
<sec:intro>

The phenomenon of academic delay is rarely a result of laziness, but rather a sophisticated, subconscious prioritization algorithm. We define "Advanced Procrastination" not as the avoidance of work, but as the active engagement in tasks of secondary importance to simulate productivity @slacker2024. This state, often referred to as "productive paralysis," allows the researcher to maintain a facade of busyness while the primary objective remains untouched.

Recent studies indicate that the guilt associated with procrastination actually fuels a specific type of hyper-focused anxiety, which is occasionally useful for meeting deadlines in the final 4% of the allotted timeline @panic2023. We posit that without this deadline-induced adrenaline spike, the average graduate student would lack the kinetic energy required to open their laptop lid.

== Literature Review on Cat Videos
<sec:intro:cat-videos>

The consumption of feline-based digital media has emerged as the primary sink for graduate attention spans. #cites(<whiskers2022>) argues that the infinite scroll of short-form cat content provides a distinct dopamine feedback loop that rivals traditional substance abuse. In their landmark study, "If I Fits, I Sits: A Topological Approach to Comfort," they demonstrated that the cuteness of the subject is inversely proportional to the viewer's remaining time until a committee meeting.

Furthermore, #cites(<purrington2025>) suggests that watching cats knock objects off tables serves as a vicarious release for the graduate student's desire to dismantle the established academic hierarchy. While detractors claim this is "wasting time," we argue it is essential cognitive maintenance, preventing the complete calcification of the soul during the literature review phase.

#lorem(300)

== The Impact of Caffeine on Anxiety Levels
<sec:intro:caffeine-anxiety>

The relationship between caffeine intake and thesis output is best described by the Yerkes-Dodson Law, but shifted significantly towards the "breakdown" axis. While #cites(<beans2021>) postulates that there is a "Goldilocks Zone" of three espressos where clarity is achieved, our empirical data suggests this zone is theoretical and exists for approximately twelve seconds.

Beyond this threshold, the subject enters the "Vibrating Phase," characterized by high typing speeds but extremely low semantic coherence. As noted by #cites(<jitters2023>), the transition from "alert" to "existential dread" is often triggered by a single sip of cold brew after 4:00 PM, leading to a state where the student can hear colors but cannot recall the definition of a p-value.

#lorem(300)

#lorem(200)

#pagebreak-clean(to: section-page-parity)
= Background: Why Work at All?
<sec:methods>

#lorem(300)

#lorem(200)

== Historical Attempts at Productivity
<sec:background:history>

#lorem(160)

== The Myth of the Perfect Workspace
<sec:background:workspace>

#lorem(160)

#lorem(300)

#lorem(200)

#pagebreak-clean(to: section-page-parity)
= Methods: Theory of Avoiding Real Work
<sec:methods>

To rigorously investigate the dynamics of delay, we employed a multi-modal approach involving high-fidelity distraction techniques. We categorized activities based on their "Justification Score"—a metric defining how easily one can convince a supervisor that the activity was actually research-adjacent.

== Gods as Topological Invariants
<sec:methods:cleaning>

#publication-header-text(
  authors: [Daniel Schoch],
  title: "Gods as Topological Invariants",
  venue: "Journal of Theoretical Topology and Theology, Vol. 3 (Special Issue on Metaphysics)",
)


=== Sorting Books by Color Gradient


We attempted to apply the principles of theotopology to the physical organization of the laboratory workspace. By rearranging the reference library according to the visible light spectrum rather than the Library of Congress system, we achieved a state of "Chromological Harmony" @rainbow2024. This process took three days and rendered the library functionally useless, but the aesthetic satisfaction provided a temporary reprieve from impostor syndrome.

The resulting gradient ($R \to G \to B$) creates a continuous manifold on the bookshelf, proving that while knowledge is discrete, procrastination is continuous. As illustrated in @fig:methods:theotopology:classification, the classification of divine entities shares a surprising structural similarity to the way we categorize our unread textbooks: by cover glossiness rather than content.

#figure(
    image("./res/topology.jpg", width: 80%),
  caption: flex-caption[
    The Fundamental Theorem of Theotopology: Classifying deities by genus.
  ][
    Visualizing the topological structures of divine entities. *(a) The Monotheistic Sphere ($g=0$):* Represents absolute unity and perfect symmetry with no handle for criticism. *(b) The Reincarnation Torus ($g=1$):* Mathematically distinct from a sphere but identical to a coffee cup, representing cyclic belief systems. *(c) The Trickster Klein Bottle:* A non-orientable surface for deities with ambiguous morality who exist outside standard distinct boundaries. *(d) The Polytheistic Calabi-Yau Manifold ($g=n$):* A high-dimensional complex space necessary to map the convoluted family trees of Greek mythology.
  ],
) <fig:methods:theotopology:classification>

#lorem(300)

#lorem(182)

#lorem(246)

=== Alphabetizing the Spice Rack

Following the failure of the bookshelf experiment, we pivoted to culinary logistics. #cites(<thyme2022>) argues that a disordered spice rack is a manifestation of a chaotic mind. Therefore, alphabetizing cumin, coriander, and cardamom becomes a proxy for organizing one's dissertation arguments.

This task, while critically unimportant, offers a tangible "complete" state that academic writing lacks. The granularity of the task—deciding if "Smoked Paprika" belongs under 'S' or 'P'—requires a level of pedantic decision-making that perfectly mimics the peer-review process, satisfying the urge to be critical without the risk of rejection.

#lorem(129)

#lorem(210)

#lorem(345)

=== Reformatting Charts for Six Hours

The final methodology in this series involved the infinite optimization of data visualization. We spent forty hours adjusting the kerning on the axis labels of a plot that will likely be moved to an appendix. #cites(<pixel2023>) refers to this as "Vectorized Vanity."

By tweaking the opacity of error bars by increments of 1%, we successfully simulated the feeling of rigorous analysis. This activity yields a high Justification Score because "presentation matters," even though the underlying data was fabricated by a random number generator.

#lorem(156)

#lorem(278)

== Astrology in the Era of Exoplanets
<sec:methods:panic>

#publication-header-text(
  authors: [Michael B. Lund],
  title: "Astrology in the Era of Exoplanets",
  venue: "Proceedings of the Celestial Computation Conference (C3), Vol. II",
)

=== Mapping Exoplanet Horoscopes

#figure(
  image("res/planets.jpg", width: 80%),
    caption: flex-caption[
    Integrating exoplanets into a neo-zodiacal astrological framework.
  ][
    This figure illustrates a proposed expansion of traditional astrology, termed the "Neo-Zodiacal Chart." The left panel shows the classic twelve zodiacal houses and constellations centered on Earth. The right panel integrates numerous confirmed exoplanets, categorized by type (e.g., Hot Jupiter, Super-Earth) and specific systems (e.g., TRAPPIST-1, Kepler-452b). Colored "aspect lines" with symbols for trines (△), squares (□), and conjunctions (☌) link these distant worlds to the traditional zodiac signs and Earth, visualizing proposed new celestial influences in the era of exoplanet discovery.
  ],) <fig:methods:panic:exoplanets>

With the discovery of thousands of exoplanets, traditional horoscopes are statistically outdated. We propose a Neo-Zodiacal framework that accounts for the gravitational influence of Super-Earths on graduate funding applications. As seen in @fig:methods:panic:exoplanets, the retrograde motion of Kepler-452b is strongly correlated with the rejection of conference abstracts.

#cites(<zodiac2025>) suggests that rising signs should now include Hot Jupiters. If your thesis defense falls when TRAPPIST-1 is in the House of the Reviewer 2, failure is topologically inevitable. We spent three weeks calculating these alignments instead of writing the discussion section.

#lorem(164)

#lorem(325)

#lorem(231)

=== Stellar Alignment Scorecards

We developed a rubric for assessing daily productivity based on the transit of Proxima Centauri. Results indicate that "Mercury in Retrograde" is a valid excuse for missing data, but "The Sun was in my eyes" is not accepted by the dean.

#lorem(142)

#lorem(188)


=== Retrograde Corrections for Distant Worlds

Correcting for light-speed lag in astrological predictions requires relativistic adjustments. We derived a formula to calculate how unlucky you are in real-time, adjusted for the expansion of the universe. This calculation is non-convergent, much like the edit history of this document.

#lorem(207)

#lorem(360)

#lorem(148)

== Stopping GAN Violence: Generative Unadversarial Networks
<sec:methods:snack-cadence>

#publication-header-text(
  authors: [Samuel Albanie, Sébastien Ehrhardt, João F. Henriques],
  title: "Stopping GAN Violence: Generative Unadversarial Networks",
  venue: "Harmony in Machine Learning Symposium (HiML)",
)

=== Mediating Generator-Discriminator Dialogue

The adversarial nature of GANs promotes a toxic workplace environment for neural networks. We introduced a "Therapy Layer" between the Generator and Discriminator, utilizing Natural Language Processing to encourage non-violent communication @peace2024.


#definition("Empathy Loss for GUNs")[
  #set text(style: "italic")
  Let $psi(t)$ be the therapeutic bandwidth of the mediator at batch time $t$ and $lambda$ the decay rate of grudges. The Empathy Loss is defined as $L_{"emp"} = chi(M) + psi(t) * ||G(x) - D(x)||_2^2$, where $M$ is the shared meeting manifold for Generator $G$ and Discriminator $D$. A GAN is considered "unadversarial" when $L_{"emp"} \le 3$ and each network contributes at least one compliment sandwich per optimizer step.
]

#figure(
    image("./res/gans.jpg", width: 80%),
  caption: flex-caption[
    Visualizing the transition from adversarial conflict to collaborative dialogue in Generative Unadversarial Networks (GUNs).
  ][
    This figure illustrates the core principle of Generative Unadversarial Networks (GUNs) as a solution to the inherent "violence" of traditional GAN training. The left panel depicts the classic adversarial minimax game, where the Generator and Discriminator are locked in a zero-sum conflict, leading to unstable training and mode collapse. The central panel introduces the "Mediator" module, which interrupts this destructive cycle by facilitating a "Dialogue Channel" and enforcing an "Empathy Loss." The right panel shows the resulting harmonious GUN framework, where the networks cooperate towards a common goal of high-quality generation, leading to a stable equilibrium and superior results.
  ],
) <fig:methods:snack-cadence:gun-framework>

Instead of a minimax game, the networks engage in a "collaborative journaling session." As shown in @fig:methods:snack-cadence:gun-framework, this results in blurry images, but the loss function reports significantly higher levels of self-esteem for both networks.

#lorem(195)

#lorem(258)

#lorem(134)

#lorem(312)

=== Cooperative Loss Landscapes

We replaced the standard gradient descent with "empathetic descent," where the model only updates weights if it feels emotionally ready to do so. Training times increased by 4000%, but we successfully avoided mode collapse by simply letting the mode vent about its feelings.

#lorem(177)

#lorem(289)

=== Peace Treaties Between Networks

We drafted a formal treaty ensuring that the Discriminator offers constructive criticism (e.g., "I like the texture, but the edges are a bit artifact-y") rather than binary rejection. This led to the development of the "Compliment Sandwich Loss" (CSL), which wraps the error gradient in positive reinforcement.

#lorem(204)

#lorem(154)

#lorem(339)

== Science Spoofs, Physics Pranks and Astronomical Antics
<sec:methods:email-drafting>

#publication-header-text(
  authors: [Douglas Scott],
  title: "Science Spoofs, Physics Pranks and Astronomical Antics",
  venue: "Annals of Scientific Whimsy, Vol. 12",
)

=== Cataloging Classic Lab Pranks

We conducted a longitudinal study of laboratory humor, categorizing pranks into three distinct taxonomies as seen in @fig:methods:email-drafting:spoofs-pranks-antics. The "Frozen Nitrogen Banana" remains the standard deviation of comedy in cryogenics labs, while "labeling water as Dihydrogen Monoxide" has seen a steady decline in p-value significance due to overuse.

#figure(
    image("./res/science.jpg", width: 80%),
  caption: flex-caption[
    A visual taxonomy of the three pillars of scientific tomfoolery.
  ][
    This triptych illustrates the three distinct categories of scientific humor detailed in the paper. Panel 1, "Science Spoofs," depicts a classic lab prank involving the mislabeling of chemical reagents to confuse colleagues. Panel 2, "Physics Pranks," shows a lighthearted take on modifying fundamental equations and setting up elaborate, physics-based gags. Panel 3, "Astronomical Antics," visualizes a humorous "first contact" scenario where aliens play a practical joke on astronomers by obstructing their telescope with a rubber duck. These examples highlight the creativity and humor found within the scientific community, often serving as a form of stress relief and social bonding.
  ],
) <fig:methods:email-drafting:spoofs-pranks-antics>

#lorem(266)

#lorem(133)

=== Humor as a Creative Catalyst

#cites(<giggle2021>) theorizes that the "Eureka" moment is chemically identical to the realization of a good pun. We tested this by replacing all variables in the Schrödinger equation with emojis. While mathematically unsound, the resulting paper was much more engaging to read on a smartphone.

#lorem(226)

#lorem(198)

#lorem(347)

#lorem(159)

=== Ethics of Practical Jokes in Research

We examine the ethical implications of gluing a colleague's mouse to the desk. While #cites(<prankster2019>) argues this constitutes "hostile architecture," we conclude it serves as a necessary test of the colleague's problem-solving skills and grip strength.

#lorem(272)

#lorem(185)

#pagebreak-clean(to: section-page-parity)
= Discussion and Conclusion
<sec:discussion>

Our research conclusively proves that avoiding work requires more energy than actually doing the work. However, the quality of the resulting anxiety is far superior. Through the rigorous application of topological book sorting and exoplanet astrology, we have successfully delayed graduation by another three semesters.

== Limitations and Future Procrastination
<sec:discussion:limitations>

Our study was limited by the occasional accidental burst of productivity, which skewed our data. Future research will focus on "Quantum Procrastination," where the thesis is simultaneously written and unwritten until observed by an advisor.


#lorem(80)

#lorem(302)

#lorem(146)

== Reframing Productivity Metrics
<sec:discussion:metrics>

We propose a new metric: The "Words Per Panic Attack" (WPPA). Under this framework, our output is exceptionally high. We conclude that we are not failing; we are simply excelling at a different game entirely.

#lorem(100)

#lorem(162)

#lorem(226)


// Optional list of todos
// #note-outline() // list of todos


// Bibliography section
#pagebreak(weak: true)
#set page(header: [])

#bibliography("bibliography.bib", style: "csl/bib-v1.csl", full: true)

#pagebreak()


#pagebreak(to: "odd", weak: false)
#chapter-page[Publications]
// Disable footer (page number)
#set page(footer: "")
#include "pages/publications.typ"
