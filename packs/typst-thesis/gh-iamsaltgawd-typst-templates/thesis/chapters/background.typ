#import "../prelude.typ": *

   BACKGROUND / THEORETICAL FOUNDATION – WRITING GUIDE (paragraph by paragraph)

   P1. Domain
        - Describe the broad field of the thesis, why it matters,
          and which aspects are important.
        - Example (hardware): "Computer architecture is the foundation of all computing systems; advances in arithmetic units directly affect the performance, energy efficiency, and applicability of modern accelerators."
        - Example (software): "Scientific computing underpins discoveries in physics, chemistry, climate modelling, and engineering; the fidelity and cost of numerical simulations determine how quickly science can progress."

   P2. Context
        - Zoom in on the specific setting where the problem appears and explain its relevance to the broader domain.
        - Example (hardware): "Within computer architecture, the choice of number representation (fixed-point, floating-point, posit, etc.) determines the trade-off between accuracy, silicon area, and power consumption in hardware accelerators."
        - Example (software): "In scientific-computing workflows, number-representation libraries are called repeatedly inside kernels; their precision and runtime influence the overall reliability and turnaround time of large simulations."

   P3. Problem and Motivation
        - State clearly the gap or deficiency that motivates your work and why solving it is important.
        - Example (hardware):
              "There is currently no unified hardware library that offers multiple number representations together with a common benchmark suite, making fair comparison and reuse across projects difficult."
              "This gap forces designers to re-implement basic operators for each format, increasing development time and hindering reproducible evaluation."
        - Example (software):
              "Existing software libraries provide many number formats but lack integrated automated testing and continuous-integration support, which hinders reproducible evaluation in large scientific-computing projects."
              "Consequently, developers must manually run correctness and benchmark tests, slowing down experimentation and increasing the risk of inconsistent results."

   P4. Related Work
        - Discuss existing solutions (libraries, tools, architectures) and point out their limitations with respect to your goal.
        - Example hardware paragraph 1:
              "FloPoCo provides a rich set of floating-point cores but focuses mainly on IEEE-754 and related formats, offering limited support for posit or unum."
        - Example hardware paragraph 2:
              "Several open-source Chisel libraries implement individual formats (e.g., a fixed-point package) but they do not share a common test harness, making cross-format benchmarking ad-hoc."
        - Example hardware paragraph 3:
              "Recent proposals for programmable arithmetic units (e.g., POSH) demonstrate flexibility but lack a standardized evaluation framework."
        - Example software paragraph 1:
              "General-purpose libraries such as NumPy (Python) and the Julia standard library supply many number formats, yet they are not coupled to automated CI pipelines, so developers must run correctness and benchmark tests manually."
        - Example software paragraph 2:
              "Some research prototypes (e.g., a posit package for Julia) provide the arithmetic but lack integration with build systems like Jenkins, which limits their usability in large, collaborative scientific-computing projects."
        - Example software paragraph 3:
              "Workflow tools like GitHub Actions or GitLab CI can run tests, but they do not provide a ready-made library of number representations for direct reuse."

   P5. Research Question / Goal
        - State the main question or engineering goal that your thesis will answer.
        - Example (hardware):
              "Which number-representation format(s) give the best trade-off between accuracy, area, and power for a given class of accelerator kernels?"
        - Example (software):
              "How can we provide a reusable, CI-integrated software library that lets scientific-computing teams evaluate and compare diverse number representations with minimal manual effort?"

   P6. Thesis Contributions
        - Summarize the main contributions of the thesis in prose (2-4 items).
        - Example (hardware):
              "The thesis contributes: (i) a reusable Chisel number-representation library; (ii) a common benchmark framework for fair cross-format comparison; (iii) quantitative evaluation of format trade-offs on FPGA targets; and (iv) guidance for hardware designers on selecting formats for accelerator design."
        - Example (software):
              "The thesis contributes: (i) a Scala software library with multiple number representations; (ii) a Jenkins-based CI workflow that automates testing and benchmarking; (iii) empirical results showing accuracy-runtime-energy trade-offs for scientific kernels; and (iv) a reusable template for integrating numerical experiments into CI pipelines."

   Replace each block below (the text between _[ and ]_) with your own paragraph(s) following the order above.
