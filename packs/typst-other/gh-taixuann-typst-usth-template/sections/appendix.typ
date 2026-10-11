= APPENDICES

// ==========================================
// Appendix A: Electrochemical Optimization
// ==========================================
#let letter = "A"
#set figure(numbering: (n) => [#letter.#n])
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)

== Appendix A

#figure(
  image("../figures/appendix_chemical-structure-pda.pdf", width: 80%),
  caption: [Polymerization process of dopamine showing the chemical structures of the monomer and key oligomeric intermediates.],
) <fig_appendix_chemical_structure_pda>

#figure(
  image("../figures/appendix_dopamine-quinone.pdf", width: 80%),
  caption: [Chemical structural transition and cross-linking of PDA during CA electrochemical treatment.],
) <fig_appendix_dopamine_quinone>

#figure(
  image("../figures/res_pH-investigation-CV.pdf", width: 100%),
  caption: [Electrochemical characterization of PDA on GCE. (A) CV deposition of PDA on GCE (10 cycles). (B) CV characterization of PDA/GCE at pH 3.0, 6.65, and 11.15 showing charge-permselectivity.],
) <fig_echem_ph_cv>

#figure(
  image("../figures/appendix_eis-sweep.pdf", width: 100%),
  caption: [Electrochemical optimization of CA doping conditions on GCE. (A) CA current transients at different potentials (-0.25 V to +0.25 V) and durations. (B) Nyquist plots of PDA/GCE at -0.25 V after different doping times. (C) Nyquist plots of PDA/GCE at +0.25 V after different doping times.],
) <fig_appendix_eis_sweep>

#figure(
  table(
    columns: (1.3fr, 0.7fr, 0.5fr, 0.8fr, 0.8fr),
    align: (col, row) => if col < 1 { left + horizon } else { center + horizon },
    table.hline(stroke: 1.5pt),
    table.header(
      [*Condition*], [*Rct* (kΩ)], [*n*], [$chi^2_w$], [*MAPE* (%)]
    ),
    table.hline(stroke: 0.5pt),
    [Undoped], [1.14], [0.89], [$1.82 times 10^-4$], [1.14],
    table.hline(stroke: 0.2pt),
    [+0.25 V, 10 s], [41.2], [0.71], [$2.01 times 10^-5$], [0.38],
    [+0.25 V, 20 s], [17.9], [0.74], [$2.90 times 10^-5$], [0.46],
    [+0.25 V, 30 s], [35.6], [0.71], [$9.44 times 10^-5$], [0.74],
    [+0.25 V, 60 s], [65.6], [0.72], [$4.18 times 10^-5$], [0.46],
    table.hline(stroke: 0.2pt),
    [-0.25 V, 10 s], [18.4], [0.66], [$1.45 times 10^-4$], [0.98],
    [-0.25 V, 20 s], [17.0], [0.72], [$6.42 times 10^-5$], [0.67],
    [-0.25 V, 30 s], [17.2], [0.66], [$1.12 times 10^-4$], [0.93],
    [-0.25 V, 60 s], [28.2], [0.71], [$1.14 times 10^-4$], [0.88],
    table.hline(stroke: 1.5pt),
  ),
  caption: [EIS equivalent circuit fit parameters of PDA/GCE under different doping conditions. The undoped PDA was fitted with a $R"(QR)"W_"gen"$ model (generalized Warburg), reflecting a porous, accessible film with efficient charge transfer. All doped conditions required an $R"(Q(RW))"L$ model incorporating an inductor ($L$) and Warburg element ($W$), consistent with the formation of a densified, diffusion-limited interface after cross-linking.],
  kind: table,
  supplement: [Table],
) <tab_eis_fit>

#figure(
  image("../figures/res_afm-ito.pdf", width: 80%),
  caption: [AFM characterization of the bare ITO substrate. (A) Large-area 2D surface topography mapping over a 50 µm × 50 µm scan area. (B) Height distribution analysis relative to the glass substrate. (C) High-resolution 3D surface topography rendering over a 4 µm × 4 µm scan area, showing Sa = 3.218 nm and Sq = 3.988 nm.],
) <fig_appendix_ito>

#figure(
  table(
    columns: (1.5fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    table.hline(stroke: 1.5pt),
    table.header(
      table.cell(rowspan: 2, align: left + horizon)[*Sample*],
      table.cell(colspan: 3, align: center + horizon)[#underline([*Z₁ (film surface)*])],
      table.cell(colspan: 3, align: center + horizon)[#underline([*Z₂ (substrate/aggregates)*])],
      table.cell(rowspan: 2, align: center + horizon)[*Active (nm)*],
      [Peak (nm)], [Median (nm)], [FWHM (nm)],
      [Peak (nm)], [Median (nm)], [FWHM (nm)],
    ),
    table.hline(stroke: 0.5pt),
    [ITO], [25.15], [28.71], [20.66], [177.71], [182.02], [24.41], [---],
    [PDA (normal)], [16.76], [16.61], [15.07], [193.20], [189.09], [29.34], [~24],
    [PDA (protonated)], [18.78], [22.04], [10.92], [194.07], [186.82], [156.05], [~23],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Height distribution analysis of ITO and PDA films. $Z_1$ and $Z_2$ denote the low-height (film surface) and high-height (substrate/aggregate features) zones respectively. Active layer thickness is derived from $Z_2$ peak minus $Z_1$ peak.],
  kind: table,
  supplement: [Table],
) <tab_height_distribution>

#figure(
  image("../figures/res_uv-vis.pdf", width: 80%),
  caption: [UV-Vis transmittance spectra of normal and proton-doped PDA films showing high optical transparency across the visible spectrum.],
) <fig_uv_vis_appendix>

#pagebreak()

// ==========================================
// Appendix B: Unstable Device Configurations
// ==========================================
#let letter = "B"
#set figure(numbering: (n) => [#letter.#n])
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)

== Appendix B

#figure(
  image("../figures/appendix_iv-dc-cu-c(n),cu-ta(n),cu-ta(q).pdf", width: 100%),
  caption: [Bipolar DC I-V sweeps of unoptimized device configurations. (A) Cu/C/PDA (normal)/ITO, cycles 1, 5, and 10 showing low leakage current (<=0.2 µA) with no threshold switching. (B) Cu/Ta/PDA (normal)/ITO, cycles 1, 4, and 7 showing progressive current suppression toward an insulating state. (C) Cu/Ta/PDA (protonated)/ITO, cycles 1 and 10 exhibiting volatile threshold switching, followed by a hard short at cycle 11.],
) <fig_appendix_iv_configs>

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (col, row) => if col < 1 { left + horizon } else { center + horizon },
    table.hline(stroke: 1.5pt),
    table.header(
      table.cell(colspan: 6, align: center)[*A. Voltage Sweep ($t_r = 250$ ns, 9 µs pulse width)*]
    ),
    table.hline(stroke: 0.5pt),
    [*Voltage (V)*], [*$I_"spike"$ (mA)*], [*$G_"spike"$ ($G_0$)*], [*$I_"plateau"$ (mA)*], [*$G_"plateau"$ ($G_0$)*], [*$E_"transient"$ (nJ)*],
    table.hline(stroke: 0.3pt),
    [2.75 V], [5.82], [27.3], [1.487], [6.98], [2.00],
    [2.25 V], [4.84], [27.7], [0.751], [4.31], [1.36],
    [1.75 V], [3.80], [28.0], [0.235], [1.73], [0.84],
    [1.25 V], [2.73], [28.2], [0.070], [0.72], [0.45],
    table.hline(stroke: 1.0pt),
    table.header(
      table.cell(colspan: 6, align: center)[*B. Rise-Time Sweep ($V = 2.0$ V, 9 µs pulse width)*]
    ),
    table.hline(stroke: 0.5pt),
    [*Rise Time (µs)*], [*$I_"spike"$ (mA)*], [*$G_"spike"$ ($G_0$)*], [*$I_"plateau"$ (mA)*], [*$G_"plateau"$ ($G_0$)*], [*$E_"transient"$ (nJ)*],
    table.hline(stroke: 0.3pt),
    [0.25 µs], [3.89], [25.1], [0.434], [2.80], [1.00],
    [0.50 µs], [2.68], [17.3], [0.437], [2.82], [0.94],
    [1.00 µs], [1.82], [11.8], [0.436], [2.81], [1.57],
    [3.00 µs], [0.90], [5.8], [0.445], [2.87], [2.36],
    [5.00 µs], [0.73], [4.7], [0.488], [3.15], [2.62],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Transient peak conductance ($G_"spike" = I_"spike" / V$), steady-state plateau conductance ($G_"plateau" = I_"plateau" / V$), and active transient energy ($E_"transient"$). $G_"spike"$ at 250 ns rise time is dominated by capacitive displacement, whereas $G_"plateau"$ reflects the steady-state resistive conduction state.],
  kind: table,
  supplement: [Table],
) <tab_conductance_stp>

#pagebreak()

// ==========================================
// Appendix C: AI Tools Disclosure
// ==========================================
#let letter = "C"
#set figure(numbering: (n) => [#letter.#n])
#counter(figure.where(kind: image)).update(0)
#counter(figure.where(kind: table)).update(0)

== Appendix C

All AI-assisted work in this thesis was conducted through the OpenCode CLI (opencode-go, July 2026) using three language models including DeepSeek-v4-Flash, DeepSeek-v4-Pro, and Qwen 3.7 Plus. These models were accessed via the same agent framework and used interchangeably depending on task complexity, with the flash variant handling routine retrieval and editing tasks, the pro variant managing complex analytical workflows, and Qwen supporting creative reasoning and literature exploration.

For literature review and knowledge retrieval, a local hybrid RAG (Retrieval-Augmented Generation) pipeline was built following the general architecture described in Karpathy's guidelines for building a wiki-scale RAG system. Research papers were retrieved from Zotero, converted to structured markdown via docling, and indexed into a hybrid search database combining BM25 keyword matching, dense vector embeddings (all-MiniLM-L6-v2, 384-dim), and a knowledge graph of entity relations. Queries against this index returned ranked passages with source citations, enabling systematic verification of every citation against its original paper. This workflow was used to detect potential misattributions, confirm that numerical claims matched their cited sources, and retrieve relevant literature for comparison and discussion. All findings were reviewed and validated by the author against the primary sources before incorporation into the thesis.

For writing and language support, AI agents operated under strict boundary rules defined in the project's agent configuration files. These rules prohibited AI from generating content autonomously. Every paragraph required explicit author input (skeleton, data points, and direction) before any drafting, and all outputs were subject to mandatory self-scan for banned phrases, booster adjectives, em-dashes, and explanatory colons before delivery. The AI was strictly prohibited from hallucinating, inventing citations, or creating unsupported claims. Its role was limited to expressing the author's ideas in clear, direct, scientifically precise language, performing grammar correction, and flagging potential inconsistencies. Every suggested change was reviewed and either accepted or rejected by the author. No AI-generated prose was incorporated without explicit author approval. AI agents also assisted with Typst formatting and figure arrangement based on the author's layout requirements, ensuring consistent document styling across all sections.

For data analysis, AI-assisted scripts supported three areas: (1) EIS Nyquist plot fitting using the open-source impedance.py library with appropriate equivalent circuit models; (2) XPS peak deconvolution with mixed GL(30) and LA(1.4,1.4,100) lineshapes, where component positions, widths, and areas were constrained within chemically meaningful ranges; and (3) conductance analysis from pulse transient data, where peak currents and voltages were converted to quantum conductance units ($G_0 = 2e^2/h$) for filament characterization. All fitting parameters, plots, and numerical outputs were independently verified by the author against raw measurement data. The complete agent definitions, skill libraries, and analysis scripts are available at https://github.com/taixuann/thesis-ai-tools.
