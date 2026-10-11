#import "../prelude.typ": *

   INTRODUCTION WRITING GUIDE (paragraph by paragraph)

   P1. Domain
        - Describe the broad field of the thesis, why it matters,
          and which aspects are important.
        - Example (hardware): "Computer architecture is the foundation of all computing systems; advances in arithmetic units directly affect the performance, energy efficiency, and applicability of modern accelerators."
        - Example (software): "Scientific computing underpins discoveries in physics, chemistry, climate modelling, and engineering; the fidelity and cost of numerical simulations determine how quickly science can progress."

   P2. Context
        - Zoom in on the specific setting where the problem appears and explain its relevance to the broader domain.
        - Example (hardware): "Within computer architecture, the choice of number representation (fixed-point, floating-point, posit, etc.) determines the trade-off between accuracy, silicon area, and power consumption in hardware accelerators."
        - Example (software): "In scientific-computing workflows, number-representation libraries are called repeatedly inside kernels; their precision and runtime influence the overall reliability and turnaround time of large simulations."

   P3. Problem
        - State clearly the gap or deficiency that motivates your work.
        - Example (hardware): "There is currently no unified hardware library that offers multiple number representations together with a common benchmark suite, making fair comparison and reuse across projects difficult."
        - Example (software): "Existing software libraries provide many number formats but lack integrated automated testing and continuous-integration support, which hinders reproducible evaluation in large scientific-computing projects."

   P4-P6. Importance (2-3 paragraphs)
        - Explain why solving the problem matters, using concrete impacts and, if possible, literature examples.
        - Example hardware paragraph 4 (accuracy & performance):
              "An inappropriate number format can introduce unacceptable error in signal-processing pipelines or waste precious silicon area on under-utilized functional units."
        - Example hardware paragraph 5 (energy & cost):
              "Reducing the bit-width or adopting a more efficient format lowers dynamic power and static leakage, directly decreasing the energy per operation and the overall chip cost."
        - Example hardware paragraph 6 (literature/example):
              "Recent work on neural-network accelerators shows that switching from IEEE-754 float to posits can improve inference accuracy by up to 15 % while cutting energy by 20 %." [web:119]

        - Example software paragraph 4 (precision & reliability):
              "In climate-model simulations, floating-point rounding errors can accumulate and mask real physical signals, leading to misleading predictions."
        - Example software paragraph 5 (runtime & resources):
              "More compact representations reduce memory bandwidth and cache pressure, shortening kernel execution and allowing larger problem sizes on the same hardware."
        - Example software paragraph 6 (literature/example):
              "Studies in high-performance computing demonstrate that posit-based arithmetic can cut the time-to-solution of turbulent-flow simulations by ~10 % without sacrificing scientific validity." [web:121]

   P7-P8. Alternative solutions (2 paragraphs)
        - Briefly discuss what already exists and what it lacks concerning your goal.
        - Example hardware paragraph 7:
              "FloPoCo provides a rich set of floating-point cores but focuses mainly on IEEE-754 and related formats, offering limited support for posit or unum."
        - Example hardware paragraph 8:
              "Several open-source Chisel libraries implement individual formats (e.g., a fixed-point package) but they do not share a common test harness, making cross-format benchmarking ad-hoc."
        - Example software paragraph 7:
              "General-purpose libraries such as NumPy (Python) and the Julia standard library supply many number formats, yet they are not coupled to automated CI pipelines, so developers must run correctness and benchmark tests manually."
        - Example software paragraph 8:
              "Some research prototypes (e.g., a posit package for Julia) provide the arithmetic but lack integration with build systems like Jenkins, which limits their usability in large, collaborative scientific-computing projects."

   P9. Solution
        - Describe what you built or contributed in one concise paragraph.
        - Example (hardware):
              "We present a parameterizable Chisel library that implements fixed-point, floating-point, posit, and unum formats, together with a shared test-and-benchmark framework that can be instantiated for any target FPGA or ASIC."
        - Example (software):
              "We provide a Scala-based software library that encapsulates the same set of number representations and is wired into a Jenkins CI pipeline; the pipeline automatically compiles, runs correctness tests, and collects performance metrics for each format on demand."

   P10. Experiment overview (optional, 1 paragraph)
        - Briefly mention the kinds of benchmarks or experiments you will run to evaluate the solution.
        - Example (hardware):
              "To assess the library we synthesize designs for a mid-range FPGA and run a suite of DSP kernels (FIR filter, matrix multiply, CORDIC) measuring area, maximum frequency, and error versus a high-precision software reference."
        - Example (software):
              "We evaluate the software library using three representative scientific-computing kernels: a climate-model advection step, an n-body gravitational simulation, and a dense linear-algebra benchmark, reporting runtime, energy (via RAPL), and numerical error."

   P11. Contributions
        - List 2-4 concrete contributions of the thesis in prose.
        - Example (hardware):
              "The thesis contributes: (i) a reusable Chisel number-representation library; (ii) a common benchmark framework for fair cross-format comparison; (iii) quantitative evaluation of format trade-offs on FPGA targets; and (iv) guidance for hardware designers on selecting formats for accelerator design."
        - Example (software):
              "The thesis contributes: (i) a Scala software library with multiple number representations; (ii) a Jenkins-based CI workflow that automates testing and benchmarking; (iii) empirical results showing accuracy-runtime-energy trade-offs for scientific kernels; and (iv) a reusable template for integrating numerical experiments into CI pipelines."

   P12. Thesis structure
        - One sentence per chapter summarizing what the reader will find.
        - Example (hardware):
              "Chapter 2 reviews the theoretical foundations of number representation and related work; Chapter 3 presents the high-level architecture of the library and benchmark framework; Chapter 4 details the implementation choices and Chisel code generation; Chapter 5 describes the experimental setup and results; Chapter 6 discusses the implications for accelerator design; and Chapter 7 concludes with summary and future work."
        - Example (software):
              "Chapter 2 covers the background on scientific computing, number representations, and CI concepts; Chapter 3 outlines the proposed software architecture and Jenkins pipeline; Chapter 4 explains the implementation details and build configuration; Chapter 5 presents the evaluation kernels, metrics, and results; Chapter 6 discusses the impact on scientific-computing workflows; and Chapter 7 concludes with a summary and outlook."
