= IV/ RESULTS AND DISCUSSION
#show figure.where(kind: table): set figure.caption(position: top)


== 1/ Electrochemical and Spectroscopic Validation

#figure(
  image("../figures/res_ito-deposition-doping.pdf", width: 100%),
  caption: [Electrochemical deposition and doping dynamics of PDA on ITO. (A) CV electrochemical deposition of PDA on ITO (10 cycles), and (B) CA proton-doping transient at +0.25 V for 60 s.],
) <fig_cv_ca_deposition>

For device fabrication, the electrodeposition of the PDA film on patterned ITO substrates was controlled using CV at a scan rate of 20 mV/s (@fig_cv_ca_deposition\A), where 10 cycles facilitated layer-by-layer growth via progressive reduction of the faradaic oxidation current after each cycle @kund_physicochemical_2021. Following deposition, the film underwent CA proton-doping at +0.25 V for 60 s to stabilize the proton-doped state (@fig_cv_ca_deposition\B). Prior to settling on this specific doping protocol, however, it was necessary to optimize the electrochemical parameters by first investigating the pH-dependent charge-permselectivity of the PDA film on a GCE using CV (@fig_echem_ph_cv). At pH 3.0, protonation of the amine groups to $-"NH"_3^+$ (+16 mV) electrostatically attracts the anionic redox probe ($["Fe"("CN")_6]^(3-)$/$["Fe"("CN")_6]^(4-)$) to yield a well-defined reversible redox couple @yu_pdop_2010, whereas progressive deprotonation at pH 6.65 and 11.15 suppresses the faradaic current due to electrostatic repulsion.

While static pH 3.0 immersion protonates amine groups to establish positive surface charge (+16 mV) @yu_pdop_2010 @kund_physicochemical_2021, the subsequent CA treatment at +0.25 V in the acidic KCl/HCl buffer drives electrochemically assisted structural reorganization and cross-linking of the polymer matrix. Anodic polarization promotes the oxidation of phenolic hydroxyls to carbonyls while incorporating charge-balancing chloride counter-anions ($"Cl"^-$) into the cationic protonated network @gao_ion_2014. Subsequent vacuum annealing at 75 °C overnight removes residual moisture, yielding a clean, dry, protonated polymer matrix with retained counter-anions for stable memristive switching @zhouNaturalBiomaterialbasedMemristor2022. To establish the optimal CA parameters, a matrix of potentials (from -0.25 V to +0.25 V) and durations (10 s to 60 s) was investigated and validated using EIS (@fig_appendix_eis_sweep, @tab_eis_fit).

#figure(
  image("../figures/res_ph-effects.pdf", width: 100%),
  caption: [EIS and CV characterization of the PDA film under different proton-doped conditions. (A) Nyquist plot fitting of the PDA film under different doping conditions, and (B) CV characterization of bare PDA, post-reduction at -0.25 V (60 s), and post-protonation at +0.25 V (60 s).],
) <fig_ph_effects>

Prior to doping, the pristine PDA film exhibits a low charge-transfer resistance ($R_"ct"$) of 1.14 $"k"Omega$ (@fig_ph_effects\A), attributed to electrostatic attraction between the protonated PDA ($-"NH"_3^+$, pH 3, zeta potential +16 mV @yu_pdop_2010) and the anionic $["Fe"("CN")_6]^(3-)$/$["Fe"("CN")_6]^(4-)$ redox probe. This value is consistent with literature reports for electropolymerized PDA at acidic pH (approximately 0.5 $"k"Omega$ at pH 2.9 @kund_physicochemical_2021), confirming efficient electron transfer at the pristine interface. Applying an oxidation potential of +0.25 V for 60 s drives a substantial increase in $R_"ct"$ to 65.6 $"k"Omega$, a ~58-fold rise, as the film converts to the proton-doped state and undergoes cross-linking densification. Reduction at -0.25 V for 60 s yields an intermediate $R_"ct"$ of 28.2 $"k"Omega$, corresponding to the reduced control state. Shorter CA durations (10 s to 30 s) represent an incomplete transition phase with fluctuating, intermediate resistances. A CA duration of 60 s at +0.25 V was adopted in this study to achieve a well-defined protonated state for subsequent memristive switching.

Films deposited by CV consist primarily of loose oligomers, as the rapid sweep provides insufficient time for Michael addition and Schiff base reactions to proceed appreciably @schindlerMechanisticInsightsElectrochemical2019. The 60 s CA bias drives intermolecular amine-quinone condensation @alfieri_chemistry_2018, cross-linking the oligomeric network into a denser structure and reducing the pore size below 0.6 nm, which blocks the penetration of $["Fe"("CN")_6]^(3-)$/$["Fe"("CN")_6]^(4-)$ redox probes (@fig_ph_effects\B) and is consistent with the ion permeability behavior of cross-linked PDA films @gao_ion_2014. The CV curves in @fig_ph_effects\B are consistent with the EIS trends. The -0.25 V treated film ($R_"ct"$ = 28.2 kΩ) shows higher redox peak currents than the +0.25 V treated film ($R_"ct"$ = 65.6 kΩ), reflecting the lower charge-transfer resistance of the reduced state. The XPS N 1s spectra (presented below) confirm the chemical basis for this densification. The imine (C=N-) component, the product of Schiff base condensation between quinone carbonyls and amine groups, increases from 19.54% to 29.71%, while the amine (-NH-) fraction decreases from 77.56% to 64.58%, consistent with cross-link formation.

#figure(
  image("../figures/res_afm.pdf", width: 100%),
  caption: [AFM characterization of normal and protonated PDA films. (A, D) Large-area 2D surface topography mapping over a 50 µm × 50 µm scan area. (B, E) Height distribution profiles of normal and protonated PDA films relative to the glass substrate. (C, F) High-resolution 3D surface topography renderings over a 4 µm × 4 µm scan area.],
) <fig_afm>

Height distribution analysis over the full 50 µm × 50 µm scanned area (@tab_height_distribution) confirms film thicknesses of approximately 23 nm for both normal and protonated films, with the protonated film exhibiting a narrower height distribution (FWHM: 10.92 vs 15.07 nm) and reduced surface roughness ($S_a = 2.683$ nm, $S_q = 3.403$ nm vs $S_a = 3.35$ nm, $S_q = 4.097$ nm for normal PDA). The roughness of both films is at the lower end of reported values for electropolymerized PDA (3.6–6.1 nm on Au @stocklePreciseControlPolydopamine2014 @kund_physicochemical_2021), and the bare ITO substrate (@fig_appendix_ito) shows an average roughness of Sa = 3.218 nm and Sq = 3.988 nm (scanned over a 4 µm × 4 µm area), indicating a thin, conformal coating that fills substrate valleys without introducing additional topographic features. To probe the vibrational structural changes induced by this chemical and morphological transformation, SERS was performed on the normal and proton-doped PDA films (@fig_raman).

#figure(
  image("../figures/res_raman.pdf", width: 80%),
  caption: [Deconvoluted SERS spectra of normal PDA and proton-doped PDA using 50–60 nm Au nanoparticles after ITO subtraction (785 nm laser, 10% power, 20 s acquisition, 3 accumulations), showing the D-band, C-O stretching, N-H bending, and G-band components. Fitting quality (RMS/noise): normal PDA = 1.14; proton-doped PDA = 1.06.],
) <fig_raman>

The spectra in the 1200–1700 cm⁻¹ region were deconvoluted into four Lorentzian bands including the D-band (1296–1348 cm⁻¹), the C-O stretching (1406 cm⁻¹), the indole N-H bending mode (1480–1496 cm⁻¹), and the G-band (1577–1592 cm⁻¹) @alfieri_chemistry_2018. For the normal PDA film, the G-band dominates at 1577 cm⁻¹ with a weak D-band at 1296 cm⁻¹ ($I_D$/$I_G$ $= 0.31$), indicating a relatively ordered, indole-rich aromatic network. After CA doping, the G-band blue-shifts to 1592 cm⁻¹ with increased width, consistent with enhanced C=O contribution from incorporated quinone groups @lee_laserinduced_2020, while the D-band up-shifts to 1348 cm⁻¹ ($I_D$/$I_G$ $= 0.71$), indicating quinone-induced disorder. The N-H mode shifts from 1496 cm⁻¹ to 1480 cm⁻¹, and a C-O stretching feature emerges at 1406 cm⁻¹ in the doped state, both consistent with indole-to-quinone conversion. For context, Lee et al. reported $I_D$/$I_G$ $< 0.5$ for pristine PDA @lee_laserinduced_2020; the normal film's ratio of 0.31 reflects the more ordered structure attainable by electropolymerization, while the doped ratio of 0.71 indicates substantial disorder from quinone incorporation. However, the SERS spectral fits are noise-limited (RMS/noise = 1.06–1.14), and quantitative chemical state assignment requires a more surface-sensitive technique. To confirm the molecular-level chemical transformation, XPS was performed on the C 1s, O 1s, and N 1s core levels.

#figure(
  image("../figures/res_xps.pdf", width: 100%),
  caption: [High-resolution XPS spectra of the normal and proton-doped PDA films. (A) C 1s, (B) O 1s, and (C) N 1s core-level spectra showing the chemical states of the normal and protonated state.],
) <fig_xps>

High-resolution XPS was performed on the core levels of C 1s, O 1s, and N 1s, with peak deconvolution executed using mixed lineshape profiles (@fig_xps; @tab_xps_summary). In the O 1s spectral region, the quinone carbonyl (C=O) contribution at 531.40 eV (Normal) and 531.00 eV (Proton-doped) increases from 46.0% to 74.0% post-protonation, while the phenolic hydroxyl (C-O/O-H) contribution decreases from 51.8% to 21.6%, tracking the substantial oxidation of catechol to quinone functional groups @yang_electrochemical_2015. This redox conversion is further supported by the C 1s region, where the decrease in the C-N component (from 22.06% to 12.65%) is accompanied by an increase in the carbonyl C=O component (from 6.67% to 9.81%) and the emergence of a $pi$-$pi^*$ shake-up satellite at 290.1 eV, representing the structural rearrangement of the carbon backbone as the polymer matrix transitions to an oxidized state @yang_electrochemical_2015.

#figure(
  table(
    columns: (1.2fr, 1.8fr, 1fr, 1fr, 1fr, 1fr),
    align: (col, row) => if col < 2 { left + horizon } else { center + horizon },
    table.hline(stroke: 1.5pt),
    table.header(
      table.cell(rowspan: 2, align: left + horizon)[*Region*],
      table.cell(rowspan: 2, align: left + horizon)[*Component*],
      table.cell(colspan: 2, align: center + horizon)[#underline([*Normal*])],
      table.cell(colspan: 2, align: center + horizon)[#underline([*Protonated*])],
      [BE (eV)], [Area (%)],
      [BE (eV)], [Area (%)],
    ),
    table.hline(stroke: 0.5pt),
    [C 1s], [C-C / C=C], [284.72], [61.25], [284.60], [68.13],
    [], [C-N], [285.72], [22.06], [285.60], [12.65],
    [], [C-O], [286.42], [7.77], [286.40], [6.73],
    [], [C=O], [287.92], [6.67], [287.80], [9.81],
    [], [$pi$-$pi^*$], [290.22], [2.24], [290.10], [2.68],
    table.hline(stroke: 0.4pt),

    [N 1s], [C=N-], [398.80], [19.54], [399.40], [29.71],
    [], [-NH-], [400.00], [77.56], [400.10], [64.58],
    [], [NH#sub[3]#super[+]], [401.50], [2.90], [402.10], [5.71],
    table.hline(stroke: 0.4pt),

    [O 1s], [C-O / O-H], [532.80], [51.8], [532.70], [21.6],
    [], [C=O], [531.40], [46.0], [531.00], [74.0],
    [], [O-C=O / H#sub[2]O], [535.40], [2.3], [534.00], [4.4],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Deconvolution results (BE (eV) and Area%) for XPS C 1s, O 1s, and N 1s regions of the PDA film],
  kind: table,
  supplement: [Table],
) <tab_xps_summary>


In the N 1s region, the imine (C=N-) component at 398.80 eV (Normal) and 399.40 eV (Proton-doped) increases from 19.54% to 29.71% upon proton-doping @zangmeister_characterization_2013, which in polydopamine chemistry corresponds to the nitrogen state in cyclized indole-quinone or indoledione-type intermediate structures, thereby confirming that CA proton-doping drives the chemical oxidation of cyclized indolic units within the polymer network. The amine (-NH-) component dominates both states at 77.56% (Normal) and 64.58% (Proton-doped), while the protonated amine ($-"NH"_3^+$) component remains a minor fraction at 2.90% and 5.71%, with binding energies shifting from 401.50 eV to 402.10 eV post-protonation, consistent with a modified chemical environment and PCET capability. Catechol hydroxyl groups are oxidized to quinone carbonyls (O 1s), the carbon backbone rearranges with loss of C-N character and gain of C=O and $pi$-$pi^*$ satellite intensity (C 1s), and the nitrogen framework shifts toward imine-rich indole-quinone species while retaining a persistent protonated amine component (N 1s). The SERS observation of G-band blue-shift and increased $I_D$/$I_G$ is consistent with this quinone-enrichment and backbone-disordering picture, providing independent vibrational evidence that converges with the XPS chemical state analysis. UV-Vis transmittance measurements (@fig_uv_vis_appendix) of the normal and proton-doped PDA films reveal optical transparency with a minor absorption feature near ~290 nm attributed to the $pi$-$pi^*$ transition of the aromatic catechol and indole units in the PDA backbone @zhouNaturalBiomaterialbasedMemristor2022.

== 2/ DC Resistive Switching Characteristics

#figure(
  image("../figures/om_crossbar.pdf", width: 80%),
  caption: [Optical micrograph of the fabricated 6 x 6 crossbar array. The overlap defines a junction area of 200 µm x 200 µm.],
) <fig_device_structure>

The active Cu/C/PDA (protonated)/ITO stack was integrated into a 6 × 6 crossbar array (36 devices, @fig_device_structure). The Cu/C/PDA (protonated)/ITO stack exhibits stable volatile threshold switching over 500 consecutive DC sweeps (@fig_iv_configs_600cycle\A), with spontaneous relaxation to the HRS upon bias removal. Comparison against existing polydopamine-based memristive devices (@tab_endurance_compare) shows that the threshold voltage of 0.56 V is lower than the programming voltages reported for Al/PDA/Al (2.1 V) @yunUnravelingRolePolydopamines2022, Al/PDA-PPy3Ir/ITO (-1.0 V) @gongInSituSurfaceModification2022, and FTO/PDA-12M/Ag (3.3 V) @zhouNaturalBiomaterialbasedMemristor2022, and comparable to Ag/PDA/Au (0.3 V) @zhongElectropolymerizedDopaminebasedMemristors2025, while endurance presents a more pronounced difference where reported PDA-based devices are typically limited to 50–300 sweeps versus 500 consecutive cycles (@tab_endurance_compare), placing it at the upper end of reported endurance for organic volatile memristors @zuo_volatile_2023.

#figure(
  image("../figures/res_iv-dc-600cycles.pdf", width: 100%),
  caption: [Bipolar DC switching characteristics of the Cu/C/PDA (protonated)/ITO device. (A) Bipolar DC I-V loops (compliance = 10 µA) showing threshold switching and spontaneous volatile relaxation over 500 cycles (highlighting Cycles 1, 200, and 500) on a representative device. (B) Conduction mechanism analysis on a log-log scale ($log_10 |I|$ vs. $log_10 V$). (C) Cumulative probability plot of $V_"set"$ across device-to-device (measured across 26 devices), sample-to-sample (across 2 samples), and batch-to-batch (across 4 batches) levels. (D) $V_"set"$ distribution histogram centered at 0.56 V.],
) <fig_iv_configs_600cycle>

Logarithmic analysis of the HRS charge transport on a log-log scale (@fig_iv_configs_600cycle\B) reveals a sub-Ohmic low-voltage regime (log-log slope 0.17 below 0.3 V) transitioning to an abrupt threshold (slope 21.94). Since this representation is plotted on a log-log scale, these slopes correspond to the power-law exponent. At low bias (< 0.3 V), the slope of 0.17 is highly sub-Ohmic, which is physically inconsistent with both Ohmic conduction (slope of 1) and bulk Space Charge Limited Conduction (SCLC) models (such as Child's law which requires a slope of 2, or trap-limited conduction which requires a slope greater than 2) @chiu_review_2014. Instead, this extremely low slope points to a contact-limited injection barrier or field-dependent hopping conduction under low fields, where current increases slower than linearly with voltage. Furthermore, the steep slope of 21.94 above 0.3 V represents a sudden threshold switching event (set transition) rather than a steady-state bulk conduction exponent, marking the voltage-activated opening of the conductive pathway through the PDA matrix. The $V_"set"$ distribution follows a Gaussian profile centered at 0.56 V (@fig_iv_configs_600cycle\D), and the cumulative probability analysis (@fig_iv_configs_600cycle\C) quantifies variability across three hierarchical levels using Weibull statistics. The shape parameter β, where higher values indicate tighter distributions, is 5.63 (device-to-device), 5.54 (sample-to-sample), and 4.36 (batch-to-batch). These β values exceed 4 across all levels, indicating highly uniform switching compared to typical memristor devices where β values in the range of 1–3 are commonly reported for filamentary switching @roldan_variability_2023. The endurance of 500 DC sweeps is notably higher than typical pure-polymer memristor reports (tens to low hundreds of cycles, @tab_endurance_compare), suggesting a switching mechanism that differs from conventional ionic conduction in the polymer bulk, a hypothesis that pulsed electrical characterization can further test.

== 3/ Pulsed Electrical Characterization

#figure(
  image("../figures/res_endurance-r3-c4.pdf", width: 100%),
  caption: [Pulsed endurance characteristics of one representative Cu/C/PDA (protonated)/ITO device up to $10^6$ cycles ($V_"set" = 2.69$ V, $V_"read" = 0.25$ V). (A) LRS and HRS resistance evolution, and (B) $R_"HRS"$/$R_"LRS"$ ratio histogram centered at $10^3$.],
) <fig_endurance>

Pulsed endurance testing of the Cu/C/PDA (protonated)/ITO device up to $10^6$ cycles is shown in @fig_endurance. The device maintains a stable memory window, with the $R_"HRS"$/$R_"LRS"$ ratio centered at $10^3$ (@fig_endurance\B). This is the first demonstration of $10^6$ pulsed endurance cycles in a PDA-based volatile memristor. Previous organic volatile memristors typically achieve $10^2$ to $10^4$ cycles, and the sole prior electropolymerized PDA report (@tab_endurance_compare) characterized only DC switching without pulsed data @zhongElectropolymerizedDopaminebasedMemristors2025. The $10^6$ cycle endurance approaches the range characteristic of confined-ion or metallic-filament systems @valov_electrochemical_2011, suggesting that the switching mechanism differs from ionic conduction dominant in conventional polymer matrices. A step-like shift in both HRS and LRS near $10^4$ cycles (@fig_endurance\A) coincides with the transition from linear to logarithmic sampling in the measurement protocol, where a brief hardware recovery delay after 9000 cycles allowed partial transient relaxation before sampling resumed.

#figure(
  table(
    columns: (2.0fr, 1.0fr, 0.7fr, 0.8fr, 1.3fr, 0.8fr),
    align: (col, row) => if col < 1 { left + horizon } else if col == 5 { left + horizon } else { center + horizon },
    table.hline(stroke: 1.5pt),
    table.header(
      [*Device Structure*], [*Switching Type*], [$V_"set"$ (V)], [$R_"HRS"$/$R_"LRS"$], [*Endurance*], [*Ref*]
    ),
    table.hline(stroke: 0.5pt),
    [Al/PDA/Al], [Non-volatile], [2.1], [$2.5 times 10^3$], [30 cycles], [@yunUnravelingRolePolydopamines2022],
    [FTO/PDA-12M/Ag],
    [Non-volatile],
    [3.3],
    [$2.5 times 10^4$],
    [50 cycles],
    [@zhouNaturalBiomaterialbasedMemristor2022],
    [Al/PDA-PPy3Ir/ITO],
    [Non-volatile],
    [$-1.0$],
    [$6.3 times 10^3$],
    [200 cycles],
    [@gongInSituSurfaceModification2022],
    [Au/PDA-Ag/Au], [WORM], [1.0 - 1.2], [$>10^4$], [$>10^3$ cycles], [@wang_polydopamine_2020],
    [Ag/PDA/Au],
    [Volatile (TS)],
    [0.3],
    [$>10^3$],
    [300 DC cycles],
    [@zhongElectropolymerizedDopaminebasedMemristors2025],
    [*Cu/C/PDA (protonated)/ITO*],
    [*Volatile (TS)*],
    [*0.56*],
    [*$10^3$*],
    [*$>$500 DC cycles \ $10^6$ pulsed cycles*],
    [*This work*],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Performance comparison of the Cu/C/PDA (protonated)/ITO device against existing polydopamine-based memristive devices in the literature.],
  kind: table,
  supplement: [Table],
) <tab_endurance_compare>
#v(-4pt)
#text(size: 9pt)[
  _Note._ The optimized Cu/C/PDA (protonated)/ITO device combines volatile threshold switching with substantially higher endurance than previously reported PDA-based devices, including both DC and pulsed operation.
]

#figure(
  image("../figures/res_pulse-stp-decay.pdf", width: 100%),
  caption: [Transient characteristics of the Cu/C/PDA (protonated)/ITO device under varying pulse amplitude and rise/fall time. (A–C) Voltage sweep from 1.25 to 2.75 V with current transients (9 µs width, $t_r = t_f approx 250$ ns), decay times, and peak currents. (D–F) Rise/fall time sweep from 0.25 to 5 µs with current transients (2 V, 9 µs width), decay times, and peak currents.],
) <fig_stp_characteristics>

STP in the Cu/C/PDA (protonated)/ITO device was characterized by the transient current response under varying pulse parameters (@fig_stp_characteristics). Under constant rise and fall times of approximately 250 ns, increasing the pulse amplitude from 1.25 V to 2.75 V causes the peak transient current to increase from 2.73 mA to 5.82 mA (@fig_stp_characteristics\C) and the rise decay time to decrease from 340 ns to 213 ns (@fig_stp_characteristics\B). The peak transient conductance of the device at the end of the 250 ns rise edge ($G_"spike" = I_"spike" / V$) reaches approximately 2.1 mS, corresponding to 27–28 G₀ (G₀ = 2e²/h ≈ 77.5 µS) across applied voltages of 1.25 to 2.75 V (@tab_conductance_stp). This transient peak is dominated by the capacitive displacement current of the macroscopic 200 µm × 200 µm junction. In contrast, the steady-state plateau conductance ($G_"plateau" = I_"plateau" / V$) increases non-linearly from 0.72 G₀ (0.056 mS at 1.25 V) to 6.98 G₀ (0.541 mS at 2.75 V), isolating the intrinsic voltage-activated charge transport pathway from transient capacitive charging. The fall recovery time increases from 321 ns to 363 ns over the same voltage range, indicating the progressively deeper penetration of charge carriers at higher bias and their longer back-diffusion path after pulse removal. Evaluated over the intrinsic switching transient duration using time-resolved numerical integration ($E_"transient" = integral V(t) I(t) dif t$), the active energy consumption is $0.45" nJ"$ at 1.25 V and $2.00" nJ"$ at 2.75 V over the rise transient edge. Across the full active pulse width, total energy consumption reaches $2.13" nJ"$ at 1.25 V and $39.89" nJ"$ at 2.75 V, dominated by steady-state plateau conduction ($I_"plateau" approx 0.07-1.49" mA"$). Post-pulse negative current spikes reflect zero-voltage ($V(t) = 0$) capacitive discharge and contribute zero external active power consumption ($P = V I = 0$). Downsizing the macroscopic 200 µm × 200 µm device architecture to sub-micrometer dimensions and shortening pulse widths to nanosecond durations provide a clear engineering path to scale energy consumption down to the picojoule-to-femtojoule (pJ–fJ) regime. For comparison, a PDA-based spiking neuron was reported at about 10 pJ per spike @zhongElectropolymerizedDopaminebasedMemristors2025, and an atomically thin hBN memristor achieved less than 2 pJ at 120 ps pulses @nibhanupudiUltrafastSwitchingMemristors2024.

When varying the rise transition time from 0.25 µs to 5.00 µs under a constant 2 V pulse (@fig_stp_characteristics\D), the reduced dV/dt minimizes the capacitive displacement spike, causing the peak current to decrease from 3.89 mA down to 0.73 mA (@fig_stp_characteristics\F). While the transient peak conductance $G_"spike"$ decays from 25.1 G₀ to 4.7 G₀ with slower rise times, the steady-state plateau current $I_"plateau"$ remains stable at 0.434–0.488 mA across all rise times, yielding a constant plateau conductance of $G_"plateau" approx 2.80-3.15$ G₀ (0.217–0.244 mS, @tab_conductance_stp) and an active rise-edge transient energy of 1.00 nJ at 0.25 µs up to 2.62 nJ at 5.00 µs. This confirms that the intrinsic resistive state at 2 V is invariant to pulse rise kinetics once capacitive relaxation completes. The transient relaxation timescales range from 213 ns to 461 ns across both sweep conditions (@tab_conductance_stp). These nanosecond-scale decay times are $10^4$ to $10^5$ times faster than typical ionic relaxation in organic mixed ionic-electronic conductors (millisecond range) @paulsen_organic_2019. The observed decay range is well below the lower bound for Cu ECM filament dissolution. Wang et al. @wang_cu_2019 demonstrated that even a single-atom Cu filament dissolves with a minimum lifetime of approximately 10 microseconds, and thicker filaments persist for hundreds of microseconds to milliseconds. Our measured 213-461 ns relaxation is 20-50 times faster than this lower bound, indicating that Cu ECM cannot account for the observed switching. However, in the absence of temperature-dependent electrical measurements (which would determine the activation energy of the conduction path), a definitive identification of the charge transport and relaxation mechanism cannot be established. While the 213–461 ns relaxation decay timescale is consistent with the expected protonic transit time across the thin PDA film via a Grotthuss-type hydrogen-bonded network @kreuer_proton_1996 @agmon_grotthuss_1995, this correlation does not represent a direct proof. Electronic relaxation and transport processes, such as charge trapping/detrapping at interface states, dielectric relaxation, or space-charge dissipation in the organic film, can also operate in the nanosecond regime and could contribute to the observed dynamics. Furthermore, because discrete quantized conductance steps (which typically mark single-atom filament formation/dissolution) were not observed, localized quantum confinement through carbon defects remains a hypothesis rather than a proven fact. The switching is thus hypothesized to involve proton-coupled charge transport within the protonated PDA network.

#figure(
  image("../figures/res_pulse-ppf.pdf", width: 100%),
  caption: [Pulse-train potentiation of the Cu/C/PDA (protonated)/ITO device for 50 consecutive pulses ($V = 2$ V, width = 9 µs, baseline bias = 0.5 V, inter-pulse delay = 500 ns, $t_"rise" = t_"fall" = 500$ ns).],
) <fig_pulse_ppf>

Pulse-train potentiation in @fig_pulse_ppf demonstrates the accumulation of residual conductance when consecutive pulses are applied before full relaxation. The read current during the pulse plateau increases from 0.94418 mA (6.09 G₀ at pulse 1) to 0.97823 mA (6.31 G₀ at pulse 50) under a 500 ns inter-pulse interval, corresponding to a total Synaptic Gain Index ($A_50 / A_1$) of 103.61% (+3.61% cumulative increase). The short-term Paired-Pulse Facilitation index for the first two consecutive pulses ($A_2 / A_1$) is 100.13% (net facilitation $Delta "PPF" = +0.13\%$, from 6.09 G₀ to 6.10 G₀), and the overall conductance accumulation slope is approximately +0.0047 G₀ per pulse. The 500 ns inter-pulse interval is comparable to the transient relaxation decay time (213-461 ns), such that the protonic and electronic charge carriers do not fully redistribute to equilibrium before the next pulse arrives, causing a residual conductance that accumulates with successive stimulation. For comparison, PPF in organic and oxide memristors is typically characterized at inter-pulse intervals of 1-100 ms, with PPF indices of 130-230% and relaxation time constants τ₁ ≈ 10-60 ms and τ₂ ≈ 500-1500 ms @hu_emulating_2013 @ppf_nature_2022. The 500 ns interval used here is 10⁴-10⁵ times shorter than these typical values, and the observed PPF index of approximately 100.13% reflects this regime where individual pulse increments are small due to the fast relaxation dynamics. Under the single condition tested, the gradual conductance increase over 50 pulses is consistent with the accumulation of protonic and electronic charge carriers, where each pulse adds a small population before partial relaxation occurs between pulses at a rate governed by the protonic transit time (213-461 ns).

The hypothesized proton-coupled transport is further supported by bipolar DC I-V sweeps of the three control configurations, which show contrasting behavior. The Cu/C/PDA (normal)/ITO control device (@fig_appendix_iv_configs) remains in a low-conductance state with no threshold switching. Consistent with the XPS deconvolution (@tab_xps_summary), the normal PDA matrix lacks the dense quinone carbonyl network and imine population required to establish the charge transport pathway. Both the electron-accepting quinone sites and the proton-donating amine groups are insufficient to support the switching mechanism @paulsen_organic_2019.

A limitation of the present study is that a control device configuration omitting the carbon layer completely (i.e., direct Cu/PDA/ITO) was not fabricated or characterized. Consequently, the contribution of the C layer cannot be experimentally isolated from that of the active polymer or compared against a barrierless baseline. The proposed role of the amorphous carbon interlayer as a copper diffusion barrier and electrical confinement structure is therefore presented as a reasonable interpretation supported by literature @zhao_breaking_2018 @zhao_resistive_2019, rather than a directly demonstrated experimental conclusion.

From a device engineering perspective, the Ta-containing configurations were also evaluated but proved unsuitable for reliable volatile switching. The Cu/Ta/PDA (normal)/ITO stack shows progressive current suppression over cycles 1, 4, and 7, trending toward an insulating state without activating conduction. This degradation is attributed to the high oxygen affinity of tantalum, which scavenges oxygen from the adjacent PDA film to form an uncontrolled interfacial $"TaO"_x$ layer that blocks charge injection. The doped Cu/Ta/PDA (protonated)/ITO stack initially exhibits volatile threshold switching in cycles 1 and 10 but fails catastrophically at cycle 11 via a hard short rather than gradual degradation. Both Ta-containing configurations therefore demonstrate unstable behavior that degrades within 11 cycles, in contrast to the stable 500-cycle operation of the Cu/C/PDA (protonated)/ITO stack.
