// Setup document wide styles according to the AMSN guidelines
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  background: place(top + left, dx: 1.5cm, dy: 1.5cm, rect(width: 100% - 3cm, height: 100% - 3cm, stroke: 1pt + black)),
)

#set text(
  font: "Times New Roman",
  size: 13pt,
  fill: rgb("#000000"),
)

// List spacing rules
#set list(marker: ([•], [◦]), spacing: 1.5cm)
#set enum(spacing: 1.5cm)

// ==========================================
// CUSTOM HEADING STYLES
// ==========================================
#show heading.where(level: 1): it => block(
  width: 100%,
  stroke: (bottom: 1pt + rgb("#19365d")),
  inset: (bottom: 0.5em),
  above: 24pt,
  below: 18pt,
  text(fill: rgb("#19365d"), size: 22pt, weight: "bold", it.body),
)

#show heading.where(level: 2): it => block(
  width: 100%,
  above: 18pt,
  below: 12pt,
  text(fill: rgb("#000000"), size: 16pt, weight: "bold", it.body),
)

#show heading.where(level: 3): it => block(
  width: 100%,
  above: 12pt,
  below: 8pt,
  text(fill: black, size: 22pt, weight: "bold", it.body),
)

// ==========================================
// SCIENTIFIC TABLE STYLES (APA Three-Line)
// ==========================================
// APA-style: thick rules at top and bottom, thin rule below header,
// no vertical rules, no horizontal rules between data rows.
// Each table uses explicit table.hline() calls for the three lines.

#set table(
  stroke: none, // No default cell borders — use explicit hlines
  fill: none,
  inset: (x: 4pt, y: 2.5pt),
  align: center + horizon,
)

// All table cells: 10pt
#show table.cell: set text(size: 10pt)

// Header row (y=0): add bold
#show table.cell.where(y: 0): set text(weight: "bold")

// Table figure: "Table 1: caption" (bold, one line) above table body
#show figure.where(kind: table): it => {
  block(
    width: 100%,
  )[
    #align(center)[
      #strong(it.supplement + " " + context it.counter.display() + ": " + it.caption.body)
    ]
    #v(4pt)
    #it.body
  ]
}

// Figure caption styling (bold, 13pt)
// Numbering is set per-section: "1" for main body, "A.1" for Appendix A, etc.

#show figure.caption: it => [
  #set text(size: 13pt, font: "Times New Roman", fill: black, weight: "bold")
  #it.supplement #context it.counter.display(it.numbering)#it.separator #it.body
]

// ==========================================
// 1. COVER PAGE (AMSN DEPARTMENT TEMPLATE)
// ==========================================
#v(0.05cm)
#align(center, text(13pt, weight: "bold")[UNIVERSITY OF SCIENCE AND TECHNOLOGY OF HANOI])
#v(0.1cm)
#align(center, text(10.5pt, weight: "bold")[DEPARTMENT OF ADVANCED MATERIALS SCIENCE AND NANOTECHNOLOGY])

#v(0.2cm)
#align(center, image("figures/intro_img_usth-logo.png", width: 8cm))

#v(0.5cm)
#align(center, text(15pt)[Research and Development])
#v(0.2cm)
#align(center, text(26pt, weight: "bold")[INTERNSHIP REPORT])

#v(0.2cm)
#align(center, text(13pt)[By])
#v(0.2cm)
#align(center, text(18pt, weight: "bold")[NGUYEN XUAN TAI])

#v(0.2cm)
#align(center, text(13pt)[Title:])
#v(0.2cm)
#align(center, text(26pt, weight: "bold")[Fabrication and Characterization of Polydopamine-based Crossbar Devices])

#v(2.0cm)
#align(center)[
  #grid(
    columns: (auto, auto),
    gutter: 1em,
    [*Supervisor(s):*], [Dr. NGUYEN VAN QUYEN \ AMSN Department, USTH],
  )
]

#v(2cm)
#align(center, text(13pt, weight: "bold")[Hanoi, July 2026])

#set par(
  leading: 0.5em, // Exact 1.5 line spacing (line-height 150%) matching the HTML template
  justify: true,
  spacing: 1.5em, // Standard paragraph spacing
)

// ==========================================
// 2. PREFACE & PRE-CONTENTS (ROMAN NUMERALS)
// ==========================================
#pagebreak()
#set page(
  background: none, // Disable page border for the content pages
  numbering: "i", // Roman numerals for Preface elements
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
)
#counter(page).update(1) // Set preface pages count to 1

// SUPERVISOR CERTIFICATION
#v(0.0cm)
#grid(
  columns: (2fr, 8fr),
  align: (left + horizon, left + horizon),
  column-gutter: 0.2cm,
  [
    #image("figures/intro_img_usth-logo.png", width: 100%)
  ],
  [
    #set text(size: 11pt)
    #align(left)[
      *UNIVERSITÉ DES SCIENCES ET DES TECHNOLOGIES DE HANOI* \
      *UNIVERSITY OF SCIENCE & TECHNOLOGY OF HANOI* \
      *TRƯỜNG ĐẠI HỌC KHOA HỌC & CÔNG NGHỆ HÀ NỘI*
    ]
  ],
)
#v(0.15cm)

To whom it may concern,

I, *Dr. NGUYEN VAN QUYEN* (Supervisor), certify that the thesis / internship report of Mr. *NGUYEN XUAN TAI* is qualified to be presented in the Internship Jury 2025-2026.

#v(1.0cm)
#align(right)[
  #h(-3.5cm) Hanoi, 9th July 2026 \
  #v(0.2cm)
  *Supervisor's Signature*
]

#pagebreak()

// TABLE OF CONTENTS
#show outline.entry.where(level: 1): it => {
  if it.element.func() == heading {
    set text(weight: "bold")
    it
  } else {
    it
  }
}
#outline(title: "TABLE OF CONTENTS", depth: 1, indent: 1.5cm)
#pagebreak()

// ACKNOWLEDGEMENT
= ACKNOWLEDGEMENT

I would like to express my gratitude to all those who supported me throughout this internship. Foremost, I thank my supervisor, Dr. Nguyen Van Quyen, for his continuous guidance in constructing the experimental framework and supporting me during characterization work. His mentorship not only shaped this thesis but also evaluated and enhanced my research abilities throughout the internship.

I am also grateful to Associate Professor Zoutie Xie at Guangdong Technion-Israel Institute of Technology (GTIIT) for providing the infrastructure and support for pulsed electrical characterization. Special thanks to Tran Thien Vu and Pham Duc Trung, masters of the AMSN Department, for their invaluable assistance and discussions during the experimental work. I also thank Tran Thi Kim Oanh, assistant of the AMSN Department, and the department's faculty for their support throughout my studies. I acknowledge my friends and my girlfriend, Dang Thao Nguyen, for their encouragement and patience.

The use of AI tools during this thesis is detailed in Appendix C, including the specific models, workflows, and writing constraints applied. The author reviewed, validated, and takes full responsibility for all AI-assisted content. No AI-generated result was used without direct verification against experimental data or primary literature sources. The complete agent definitions, skill libraries, and analysis scripts are available at https://github.com/taixuann/thesis-ai-tools.

#v(1cm)
#pagebreak()

// LIST OF ABBREVIATIONS
= LIST OF ABBREVIATIONS

#pad(left: 50pt)[
  #grid(
    columns: (100pt, 1fr),
    row-gutter: 1.2em,
    [AFM], [Atomic Force Microscopy],
    [CA], [Chronoamperometry],
    [CV], [Cyclic Voltammetry],
    [EIS], [Electrochemical Impedance Spectroscopy],
    [GCE], [Glassy Carbon Electrode],
    [HRS], [High Resistance State],
    [ITO], [Indium Tin Oxide],
    [LRS], [Low Resistance State],
    [PCET], [Proton-Coupled Electron Transfer],
    [PDA], [Polydopamine],
    [PPF], [Paired-Pulse Facilitation],
    [SCE], [Saturated Calomel Electrode],
    [SERS], [Surface-Enhanced Raman Scattering],
    [STP], [Short-Term Plasticity],
    [USTH], [University of Science and Technology of Hanoi],
    [UV-Vis], [Ultraviolet-Visible Spectroscopy],
    [XPS], [X-ray Photoelectron Spectroscopy],
    [BE], [Binding Energy],
    [FWHM], [Full Width at Half Maximum],
  )
]
#pagebreak()

// LIST OF TABLES
= LIST OF TABLES
#outline(title: none, target: figure.where(kind: table))
#pagebreak()

// LIST OF FIGURES
= LIST OF FIGURES
#outline(title: none, target: figure.where(kind: image))
#pagebreak()

// ABSTRACT
= ABSTRACT
Bio-inspired PDA volatile memristors with a Cu/C/PDA/ITO crossbar architecture were fabricated and characterized. Chronoamperometry at +0.25 V in acidic electrolyte was used to convert the PDA film to the proton-doped state. XPS deconvolution confirmed the chemical transition: the quinone carbonyl (C=O) fraction increased from 46.0% to 74.0%, and the imine (C=N-) fraction increased from 19.54% to 29.71%. SERS vibrational analysis showed an increase in the $I_D$/$I_G$ ratio from 0.31 to 0.71, indicating the formation of a more disordered, proton-doped polymer backbone. The devices were integrated into a $6 times 6$ crossbar array and exhibited volatile threshold switching at approximately 0.56 V with an $R_"HRS"$/$R_"LRS"$ ratio of $10^3$. Weibull analysis gave shape parameters $beta$ of 5.63, 5.54, and 4.36 across device-to-device, sample-to-sample, and batch-to-batch levels, confirming uniform switching. Pulsed endurance exceeded $10^6$ cycles, and transient active energy consumption was evaluated at 0.45 nJ at 1.25 V to 2.00 nJ at 2.75 V over the 250 ns rise edge. Intrinsic steady-state plateau conductance ranged from 0.72 to 6.98 $G_0$ (0.056–0.541 mS) with fast nanosecond relaxation (213–461 ns). Under 50-pulse stimulation (500 ns inter-pulse delay), the devices demonstrated pulse-train potentiation with a Synaptic Gain Index ($A_50 / A_1$) of 103.61% (+3.61% cumulative increase). The results suggest a switching mechanism mediated by protonic transport within the protonated PDA matrix.

#v(0.5cm)
*Key words*: Polydopamine, Memristor, Volatile threshold switching, Protonic acid doping, Amorphous carbon barrier, Neuromorphic computing.

// ==========================================
// 3. MAIN THESIS SECTIONS (ARABIC NUMERALS)
// ==========================================
#pagebreak()
#set page(
  numbering: "1", // Standard page numbers start here
)
#counter(page).update(1) // Page 1 starts at Introduction!

#include "sections/introduction.typ"
#pagebreak()

#include "sections/objectives.typ"
#pagebreak()

#include "sections/methodology.typ"
#pagebreak()

#include "sections/results.typ"
#pagebreak()

#include "sections/conclusion.typ"
#pagebreak()

#include "sections/references.typ"
#pagebreak()

#include "sections/appendix.typ"
