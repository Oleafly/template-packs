#import "style.typ": *
#show: paper-style

#paper-title[Monolayer-to-mesoscale modulation of the optical properties in 2D CrI₃ mapped by hyperspectral microscopy]
#paper-authors[Marta Galbiati¹\*†, Fernando Ramiro-Manzano¹,²\*†, José Joaquín Pérez Grau¹, Fernando Cantos-Prieto¹, Jaume Meseguer-Sanchez¹, Ivona Kosic¹, Filippo Mione¹, Ana Pallarés Vilar¹, Andrés Cantarero¹, David Soriano³,⁴, and Efrén Navarro-Moratalla¹\*]

// Main article: two columns, matching pages 1–5 of the reference.
#paper-columns[
  #paper-abstract[Magnetic 2D materials hold promise to change the miniaturization paradigm of unidirectional photonic components. However, the integration of these materials in devices hinges on the accurate determination of the optical properties down to the monolayer limit, which is still missing. By using hyperspectral wide-field imaging we reveal a non-monotonic thickness dependence of the complex optical dielectric function in the archetypal magnetic 2D material CrI₃ extending across different length scales: onsetting at the mesoscale, peaking at the nanoscale and decreasing again down to the single layer.]

  The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

    The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

      The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

        The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

          The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

            The dependence of the physical properties of van der Waals materials with the number of layers has been the flagship of two-dimensional (2D) materials since their discovery. In general, this layer dependence gains importance upon approaching the single layer limit, where the strict confinement of electrons in a 2D lattice imposes dramatic changes in the electronic structure of the crystal.

  #paper-subtitle[An example of a reusable scientific-paper layout]

  This text is an illustrative excerpt rather than a complete transcription of the manuscript. Replace it with your manuscript content. The main-text paragraph style, two-column measure and first-line indentation come from the IDML.

  The optical response can be represented by a frequency-dependent dielectric function $epsilon(omega) = epsilon_1(omega) - i epsilon_2(omega)$.

  // Replace the rectangle with image("figures/transmittance.png", width: 100%).
  // The label must follow the function call, not be written inside it.
  #paper-figure(
    rect(width: 100%, height: 85pt, stroke: 0.5pt + gray),
    title: [Visible-range transmittance spectra of CrI₃ crystals.],
    caption: [Measurements for different layer numbers.],
    // placement: here,
    placement: top,
    // scope: "column",
    // scope: "parent",
  ) <fig:transmittance>

  As shown in @fig:transmittance, the optical response changes with thickness.

  #paper-section[References]
  The bibliography is stored in #text(font: "Libertinus Mono")[references.yml]. Insert a Typst citation such as @novoselov2005graphene and enable the bibliography at the end of the final article.
]

// In the original, affiliations are pinned to the bottom of the first page.
// For a faithful production version, put this affiliation block into a first-page
// footer/background or a dedicated positioned panel after figures are finalized.
#pagebreak()
#paper-section[Methods]
#method-par[Crystal growth and isolation of few-layer crystals:][High-quality CrI₃ crystals were grown by chemical vapor transport and characterized by diffraction and spectroscopy.]
#method-par[Optical transmission experiment:][Hyperspectral transmittance images were acquired under monochromatic light.]

#pagebreak()
#supplementary-section[Supporting information]
#paper-title[Monolayer-to-mesoscale modulation of the optical properties in 2D CrI₃ mapped by hyperspectral microscopy]
#paper-authors[Marta Galbiati et al.]
#outline(title: [Contents], depth: 2)
#pagebreak()
#heading(level: 1)[Materials characterization and sample preparation]
#heading(level: 2)[Bulk CrI₃ crystal characterization]
#supplementary-body[The crystal structure of CrI₃ was characterized by powder X-ray diffraction. Insert the supplementary text and figures here.]

// Bibliography uses native Typst + Hayagriva and numeric reference labels.
#pagebreak()
#bibliography("references.yml", title: [References], style: "ieee")
