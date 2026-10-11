#import "../prelude.typ": *

   CONCLUSIONS CHAPTER - WRITING GUIDE (paragraph by paragraph)

   P1. Problem & solution recap
        - Briefly restate the original problem and your solution in one or two sentences.
        - Example (hardware):
              "We addressed the lack of a unified hardware library for comparing multiple number representations by delivering a parameterizable Chisel library with a shared test-and-benchmark framework."
        - Example (software):
              "We solved the missing reproducible evaluation of diverse number representations in scientific-computing projects by providing a Scala-based library integrated into a Jenkins CI pipeline."

   P2. Key results summary
        - Highlight the 2-4 most important quantitative or qualitative outcomes of your evaluation
          (no new details, just the take-away numbers).
        - Example (hardware):
              "Posit-8 gave the highest Fmax and lowest LUT usage across DSP kernels; posit-16 offered a noticeable accuracy gain with < 10 % area overhead."
        - Example (software):
              "Posit-16 yielded the best balance of error, runtime, and energy for climate-advection and n-body kernels; the unum-like format excelled for LU decomposition where dynamic range is critical."

   P3. Comparison with existing work
        - Explain how your results and approach improve upon or differ from the related work discussed
          in the background chapter.
        - Example (hardware):
              "Unlike FloPoCo, which focuses mainly on IEEE-754 formats, our library supports posit and
               unum-like formats and provides a common benchmark suite for fair cross-format comparison."
        - Example (software):
              "Compared to general-purpose libraries such as NumPy, our solution adds automated testing,
               CI integration, and a ready-made benchmark suite, enabling rapid experimentation in large teams."

   P4. Limitations
        - Acknowledge any threats to validity, assumptions, or constraints that affect the
          generalizability of your findings.
        - Example (hardware):
              "Results are based on synthesis for a single Artix-7 FPGA; power numbers are estimates
               from XPE, not silicon measurements."
        - Example (software):
              "Benchmarks use synthetic kernels; real scientific applications may involve different I/O
               patterns or mixed-precision workflows that could shift the trade-offs."

   P5. Future work
        - Propose concrete, feasible extensions that build directly on your thesis (keep this list
          shorter than the conclusions).
        - Example (hardware):
              "Future work could integrate the library into a full SoC with a RISC-V core, explore
               posit-32 for higher-dynamic-range kernels, and automate on-chip power measurement."
        - Example (software):
              "Future work could add stochastic-rounding support, extend the benchmark suite to include
               machine-learning inference kernels, and provide a GitHub-Action template for broader CI adoption."

   P6. Closing take-away
        - End with one memorable sentence that captures the core contribution and its impact.
        - Example (hardware):
              "This work gives hardware designers a practical, reproducible way to select the most
               efficient number representation for their accelerators."
        - Example (software):
              "This work equips scientific-computing teams with a CI-friendly toolbox to experiment
               with and quantify the impact of alternative number representations on correctness and cost."
