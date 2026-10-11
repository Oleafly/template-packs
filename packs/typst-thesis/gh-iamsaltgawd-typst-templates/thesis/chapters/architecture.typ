#import "../prelude.typ": *

   ARCHITECTURE CHAPTER - WRITING GUIDE (paragraph by paragraph)

   P1. Solution overview
        - Describe the overall system you are proposing in one or two sentences.
        - State what it does, who uses it, and where it runs.
        - Example (hardware):
              "We propose a parameterizable Chisel library that implements multiple number-representation formats together with a shared test-and-benchmark framework, targeting FPGA-based accelerators."
        - Example (software):
              "We propose a Scala-based software library integrated into a Jenkins CI pipeline that provides the same set of number representations and automatically runs correctness and performance benchmarks for scientific-computing workloads."

   P2. Functional decomposition
        - Break the solution into major functional blocks (black boxes).
        - For each block, state its responsibility and what it exposes (interfaces, APIs, ports).
        - Do NOT describe internal algorithms yet.
        - Example (hardware):
              "The library consists of:
                • Arithmetic cores (add, multiply, divide, sqrt) for each supported format;
                • Conversion utilities (between formats and to/from IEEE-754);
                • Test harness that drives the cores with stimulus vectors and checks results against a reference model;
                • Benchmark controller that configures the cores, collects area/frequency/power reports from synthesis tools."
        - Example (software):
              "The software solution comprises:
                • Number-representation module (immutable data classes + arithmetic ops for each format);
                • Test suite (unit tests using ScalaCheck / JUnit that compare results against a high-precision decimal reference);
                • Benchmark module (runs representative kernels, measures wall-clock time, energy via RAPL, and memory usage);
                • Jenkins pipeline (checks out code, builds the library, runs the test suite, executes the benchmark module, and publishes results)."

   P3. Interfaces & communication
        - Explain how the blocks talk to each other (buses, function calls, messages, data files, etc.) and what contracts they obey.
        - Example (hardware):
              "Arithmetic cores expose a parameterized Chisel interface (generic data-width, ready/valid handshake). The test harness drives each core via this interface and compares the output to a software reference model using scoreboard-style checking. The benchmark controller writes configuration registers on the cores and reads back performance counters from the synthesis tool’s reports."
        - Example (software):
              "The number-representation module offers a pure-functional API (methods like `add`, `mul`, `toDouble`). The test suite calls this API directly in Scala. The benchmark module invokes the same API inside the scientific kernels and logs timing/energy data. Jenkins orchestrates everything via shell steps that invoke `sbt test` and `sbt run`."

   P4. Non-functional considerations
        - Discuss any quality attributes you considered when designing the architecture (e.g., modularity, extensibility, resource usage, latency, fault tolerance, reproducibility).
        - Example (hardware):
              "Modularity lets us add a new number format by creating a new arithmetic core without touching existing ones. The design targets low latency (single-cycle where possible) and area efficiency (parameterizable width). The test harness ensures functional correctness before any synthesis, and the benchmark controller enables repeatable power/area estimation across formats."
        - Example (software):
              "The architecture emphasizes reproducibility (same source, same JVM, same Docker image), extensibility (new formats are added by extending the trait and adding test cases), and performance transparency (benchmark results are stored as JSON artifacts for later comparison). Fault isolation is achieved because each test runs in its own JVM process."

   P5. Mapping to implementation & evaluation (optional, 1 paragraph)
        - Briefly note how the architectural blocks will be realized in the implementation chapter and what experiments will validate them in the evaluation chapter.
        - Example (hardware):
              "In Chapter 4 we will show the Chisel code for each arithmetic core and the test-harness Scala code; in Chapter 5 we will synthesize the cores on a Xilinx Artix-7 FPGA and report area, Fmax, and power for a set of DSP kernels."
        - Example (software):
              "In Chapter 4 we detail the Scala implementation of the number-representation traits and the Jenkinsfile; in Chapter 5 we run the library against three scientific kernels (climate advection, n-body, dense linear algebra) and present runtime, error, and energy numbers."

   P6. Diagram (optional)
        - If you like, you can insert a simple block diagram here (using cetz, fletcher, or just an ASCII-art placeholder) to visualize the blocks and their interfaces.
        - Example (hardware):
              *[You may replace this comment with a figure generated by cetz or fletcher showing the arithmetic cores, test harness, and benchmark controller.]*
        - Example (software):
              *[You may replace this comment with a figure showing the Scala library, test suite, benchmark module, and Jenkins pipeline.]*
