#import "../prelude.typ": *

   EVALUATION CHAPTER - WRITING GUIDE (paragraph by paragraph)

   P1. Evaluation strategy
        - Explain how you will evaluate whether the solution addresses the original problem.
        - List the qualities you will measure (accuracy, performance, energy, area, usability, etc.) and why they matter.
        - Example (hardware):
              "To assess whether the Chisel library provides a fair basis for comparing number representations, we measure functional correctness (bit-exact match with a high-precision software reference), resource usage (LUT/FF count, DSP-slice usage, BRAM), maximum clock frequency (Fmax) from synthesis, and estimated power from the Xilinx Power Estimator."
        - Example (software):
              "To evaluate the software library we verify numerical correctness (error versus a 128-bit decimal reference), runtime (wall-clock time per kernel), energy consumption (via Intel RAPL), and memory footprint (peak RSS)."

   P2. Benchmarks & metrics
        - Describe the benchmark suite you use, what each benchmark represents, and which metrics you collect for each.
        - Example (hardware):
              "We use a suite of DSP kernels: FIR filter (64-tap), 2-D 8x8 DCT, matrix-vector multiply (64-bit inputs), and a CORDIC-based phase-rotation block. For each kernel we record: area (LUT+FF), DSP-slice usage, BRAM, Fmax (MHz), and estimated dynamic power (mW)."
        - Example (software):
              "We evaluate three representative scientific-computing kernels: climate-model advection step, n-body gravitational simulation, and dense linear-algebra kernel. For each kernel we collect: mean absolute error (vs. 128-bit decimal reference), median runtime (seconds) over 30 runs, average socket power (watts) from RAPL, and peak resident memory (MiB)."

   P3. Experimental setup
        - Detail the hardware, software, and environmental conditions under which the benchmarks run.
        - Include versions, configurations, and any steps taken to ensure fairness.
        - Example (hardware):
              "All designs are synthesized for a Xilinx Artix-7 XC7A200T FPGA (speedgrade -2) using Vivado 2023.2. Target clock is 200 MHz; we enforce a uniform IO-standard (LVCMOS18) and disable unnecessary optimizations (-no bufg). Power estimates are generated with the Xilinx Power Estimator (XPE) using default activity factors (0.1 for registers, 0.2 for logic)."
        - Example (software):
              "Benchmarks run on an Intel Core i7-12700K (Linux 6.8, Ubuntu 24.04) with Intel RAPL enabled for socket-level power measurement. The JVM is OpenJDK 17.0.12; sbt version is 1.9.8. Each benchmark is executed in a fresh Docker container (Ubuntu 22.04, OpenJDK 17) to isolate the build environment, while the benchmark binary itself runs on the host to access RAPL. We pin the CPU frequency to the base turbo boost (3.6 GHz) and disable hyper-threading to reduce variance."

   P4. Results
        - Present the outcome of each benchmark, preferably in tables or figures, and give a short, plain-language interpretation of what the numbers mean.
        - You may split this into sub-paragraphs or sub-sections per benchmark.
        - Example (hardware):
              "Table 1 shows the synthesis results for the FIR filter: the posit-8 adder uses 112 LUTs and achieves a Fmax of 340 MHz, while the IEEE-754 binary32 adder needs 158 LUTs and tops out at 285 MHz. The posit-8 version therefore saves ≈ 30 % area and allows ≈ 20 % higher clock speed. Similar trends appear across the DCT and matrix-vector kernels, with posit-8 consistently delivering the best area-frequency product."
              "Figure 2 plots estimated power versus accuracy (mean absolute error) for the CORDIC kernel; the posit-16 operating point lies on the lower-left corner, indicating lower power and lower error than binary32 at the same workload."
        - Example (software):
              "Table 2 summarizes the climate-advection kernel: the posit-16 implementation incurs a mean absolute error of 1.2 x 10⁻⁴ (vs. 3.5 x 10⁻⁴ for binary32) while running in 0.84 s (binary32: 0.96 s) and drawing 42 W average socket power (binary32: 48 W). This translates to a ≈ 12 % reduction in error, ≈ 13 % faster execution, and ≈ 13 % lower power."
              "Figure 3 shows the energy-vs-error trade-off for the n-body benchmark; the unum-like format dominates the Pareto frontier, delivering the lowest error for a given energy budget."

   P5. Data analysis
        - Interpret the patterns across benchmarks. Discuss trade-offs, outliers, and what the results imply for the choice of number representation in different scenarios.
        - Example (hardware):
              "Across all four DSP kernels, the posit-8 format consistently yields the highest Fmax and lowest LUT count, making it attractive for throughput-oriented designs. The posit-16 format, while slightly larger, provides a noticeable accuracy gain (≈ 1 bit extra precision) at a modest area cost (< 10 % increase). The IEEE-754 binary32 format is never optimal on either axis for these kernels, suggesting it is over-engineered for the targeted precision range."
        - Example (software):
              "For memory-bound kernels (climate advection, n-body) the compact posit-8 and posit-16 formats win because they reduce memory bandwidth and cache pressure, leading to lower runtime and energy. For compute-intensive kernels with high dynamic range (LU decomposition), the unum-like format 's ability to represent very large and very small numbers without overflow/underflow gives it an accuracy edge, even though it uses more bits."

   P6. Evaluation conclusion
        - Summarize what the evaluation tells you about the original problem and how your solution addresses it.
        - Link back to the research question or goal stated in the background chapter.
        - Example (hardware):
              "The evaluation confirms that a parameterizable hardware library enables fair, reproducible comparison of number representations. Posit-8 emerges as the best choice for low-latency, low-area accelerator kernels, while posit-16 offers a useful accuracy boost when a few extra LUTs are affordable. This answers our research question: which format(s) give the best accuracy-area-power trade-off for accelerator kernels?"
        - Example (software):
              "The evaluation shows that our Jenkins-integrated software library lets scientific-computing teams swap number representations with a single configuration change and instantly see the impact on correctness, runtime, and energy. Posit-16 provides the best balance for the kernels we tested, confirming that a CI-friendly library can accelerate experimentation with alternative formats in large-scale projects."
