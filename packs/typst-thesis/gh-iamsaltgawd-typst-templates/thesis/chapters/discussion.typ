#import "../prelude.typ": *

   DISCUSSION CHAPTER - WRITING GUIDE (paragraph by paragraph)

   P1. Summary of key findings
        - Briefly recap the most important quantitative or qualitative outcomes
          of your evaluation (no new numbers, just a high-level summary).
        - Example (hardware):
              "Our evaluation showed that the posit-8 format consistently delivers
               the highest clock frequency and lowest LUT usage across DSP kernels,
               while posit-16 offers a modest accuracy improvement with a small
               area overhead."
        - Example (software):
              "The software evaluation revealed that posit-16 provides the best
               balance of numerical error, runtime, and energy consumption for
               the climate-advection and n-body kernels, whereas the unum-like
               format excels for the LU-decomposition kernel where dynamic range
               is critical."

   P2. Interpretation of results
        - Explain why you observed those outcomes, linking them to the underlying
          characteristics of the number representations (precision, range,
          encoding efficiency, etc.).
        - Example (hardware):
              "Posit-8's tapered accuracy and compact encoding reduce the amount
               of logic needed for arithmetic, whereas posit-16's larger fraction
               gives an extra bit of precision without a proportional increase
               in routing complexity."
        - Example (software):
              "Posit-16's use-of-regime encoding yields efficient representation
               of numbers near unity, which are common in scientific kernels,
               while the unum-like format's variable-size exponent avoids
               overflow/underflow in the LU decomposition's large intermediate
               values."

   P3. Comparison with existing work
        - Relate your findings to the related work discussed in the background
          chapter: do you confirm, extend, or contradict previous claims?
        - Example (hardware):
              "These results agree with earlier FloPoCo studies that posit-8
               achieves lower area than IEEE-754 for low-precision DSP[web:119],
               and they extend the observation to a broader set of kernels and
               to the posit-16 format."
        - Example (software):
              "Our findings corroborate recent HPC work that posit-based
               arithmetic can reduce time-to-solution in turbulent-flow
               simulations[web:121], and they add the insight that a CI-integrated
               library makes such experiments repeatable across large teams."

   P4. Implications for the domain
        - Discuss how the results affect practitioners or researchers in your
          broader domain (e.g., hardware designers, scientific-computing teams).
        - Example (hardware):
              "For hardware accelerators, the data suggest that posit-8 should be
               the default choice for throughput-oriented DSP blocks, while
               posit-16 is worth considering when a few extra LUTs are available
               and higher fidelity is needed."
        - Example (software):
              "Scientific-computing teams can now plug the number-representation
               library into their Jenkins pipelines and instantly see the
               trade-off between precision, runtime, and energy, enabling
               data-driven format selection for climate-modeling, n-body
               simulations, or linear-algebra workloads."

   P5. Limitations
        - Identify any threats to validity, assumptions, or constraints that
          could affect the generalizability of your results.
        - Example (hardware):
              "Our synthesis targets a single Artix-7 FPGA; results may differ on
               newer Ultrascale+ or ASIC technologies. The power numbers are
               estimates from XPE, not measured on silicon."
        - Example (software):
              "Benchmark kernels are synthetic proxies; real scientific
               applications may involve different memory access patterns or
               mixed-precision workflows that could shift the trade-offs."

   P6. Future work
        - Propose concrete, feasible extensions that build on your thesis
          (e.g., new formats, larger benchmarks, hardware-software co-design).
        - Example (hardware):
              "Future work could integrate the library into a full SoC with a
               RISC-V core, explore posit-32 for higher-dynamic-range kernels,
               and automate power measurement via on-chip sensors."
        - Example (software):
              "Future work could add support for stochastic rounding, extend the
               benchmark suite to include machine-learning inference kernels,
               and provide a GitHub Action template for broader CI adoption."
