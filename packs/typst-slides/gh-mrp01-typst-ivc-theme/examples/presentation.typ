#import "@preview/touying:0.7.4": *
#import "@preview/cades:0.3.1": qr-code
#import themes.simple: *
#import "/lib/lib.typ": ivc-theme, slide, title-slide, title-slide-open-projects, footcite, ivc-color, focus-slide
#import "macros.typ": *;

#set figure(numbering: none);

#show: ivc-theme.with(aspect-ratio: "16-9", config-info(
  title: [#toolname: A Fancy Paper Title],
  author: [*Leonhard Euler*],
  short-author: [Leonhard Euler et al.],
  date: datetime(day: 27, month: 9, year: 2026),
  additional_info: [The 16th Eurographics Symposium on Visual Computing for Biology and Medicine (VCBM), 2026],
  short-conference: [VCBM 2026],
  institute_url: [ivc.tugraz.at],
  email: "leonhard.euler@tugraz.at",
), config-common(enable-nav: true, enable-footer: true))

#title-slide()

= Introduction
== Live EEG Dementia Screening
#cols[
  - How can we enable live screening for dementia? #text(fill: luma(55%))[(Context: highly prevalent)].

  #uncover("2-")[
    - We classify into three classes:
      - #text(fill: classAD)[Alzheimer's Disease]
      - #text(fill: classFTD)[Frontotemporal Dementia]
      - #text(fill: classHealthy)[Healthy Control]

    - Need *Explainability* for clinical use.
    - Data *Privacy* and ownership issues.
    - *Accessibility* for convenient live use.
  ]
][
  #alternatives()[
    #placeholder([A], width: 100%, height: 100%)
  ][
    #placeholder([B], width: 100%, height: 100%)
  ]
]

= Model
== xEEGNet: 168 Trainable Parameters
*Input*: $C=19$ channels $V_c (t)$ sampled at $N$ timepoints.
#v(-0.5em)
#box(cols[
  *1. Fixed bandpass filters*
  // ($F=7$ FIR filters $delta, theta, alpha, beta_1, beta_2, beta_3, gamma$):
  $ W_(c,f)(t) = #text(fill: blue)[Filter]_f [V_c (t)] $

  *2. Spatial mixing* with weights $w_(c,f)$:
  $ X_f (t) = sum_(c=1)^C w_(c,f) W_(c,f)(t) $
][
  *3. Batch norm and band power*:
  $ hat(Z)_f = 10 log_10 (1/N_1 sum_(i=0)^(N_1-1) X_f (t_i)^2) $

  *4. Linear classifier* ($M in RR^(3 times F)$):
  $ bold(Omega) = M hat(bold(Z)) in RR^3, quad bold(y) = #text(fill: blue)[arg max] (bold(Omega)) $
], stroke: blue, inset: 1em, radius: 1em)
#v(-0.5em)
*Output*: $3$ classes #glsH, #glsAD, #glsFTD.
#footcite(<2025-Zanola-xEEGNet>)

= Demo
== Live Demo
#v(2cm)
#align(center, { qr-code(live-demourl.dest); live-demourl })

= Conclusion
== Summary
- #toolname exposes the *full inference pipeline* of xEEGNet, from the raw EEG signal to the final classification output.
- The dataset #footcite(<2023-miltiadous-dataset>) is rich enough for basic classification tasks.
- Every visual element maps to a *model-intrinsic quantity*, no post-hoc attribution.
- An LLM-driven VACP layer allows natural-language navigation of the dashboard.
- All hosted fully locally, open-source and running in the browser.

*Future Work*
- Extend the model to take signal synchronicity into account, cf. @2023-miltiadous_diceNet_classification.
- Enhance the interface to work with other models as well, live.
- Continue work on the language interaction.

== Acknowledgements
#v(1cm)
#figure(placeholder([Funding logos], width: 60%, height: 4cm));

== Thank you!
#focus-slide(
  [
    #v(-1.0cm)
    Thank You!
    #v(0.5cm)
    #set text(size: 18pt);
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 2em,
      align(
        center,
        { qr-code(demourl.dest, background: ivc-color, color: white); text(size: 10pt)[#demourl]; "\n"; "System Homepage" },
      ),
      align(
        center,
        { qr-code(repourl.dest, background: ivc-color, color: white); text(size: 10pt)[#repourl]; "\n"; "Code Repository"; },
      ),
      align(
        center,
        { qr-code(paperurl.dest, background: ivc-color, color: white); text(size: 10pt)[#paperurl]; "\n"; "Full Paper"; },
      ),
    );
  ],
)

== References
#bibliography("sources.bib", title: none)

= Appendix
== Dimensionality Reductions
#figure(grid(
  columns: 3,
  gutter: 1em,
  placeholder([pca], width: 100%, height: 5cm),
  placeholder([tsne], width: 100%, height: 5cm),
  placeholder([umap], width: 100%, height: 5cm),
), caption: [PCA, t-SNE and UMAP projections implemented in all embedding views.]) <fig:projections>

== Future Work
Probably lots

== Backup Interface Slide
Todo
