#import "../prelude.typ": *

   ABSTRACT WRITING GUIDE (sentence by sentence)

   1. Domain -one sentence: broad field of the thesis.
        e.g., "This thesis lies in the field of computer architecture and hardware accelerators."
        e.g., "This thesis lies in the field of scientific computing and high-performance numerical methods."

   2. Context -one sentence: specific setting of your work.
        e.g., "We focus on number-representation systems implemented in hardware."
        e.g., "We focus on software libraries for number representations used in large-scale scientific-computing workflows."

   3. Problem -one sentence: the gap or deficiency you address.
        e.g., "Currently there is no unified hardware library that implements multiple number representations with a common benchmark suite."
        e.g., "There is no existing software library that provides diverse number representations together with automated testing and benchmarking."

   4. Importance (optional but recommended) -one sentence: why it matters.
        e.g., "Choosing an appropriate number format can reduce silicon area, lower energy consumption, and improve computational accuracy."
        e.g., "Using the right number format can increase numerical precision, reduce runtime, and lower energy usage."

   5. Solution -one sentence: what you built or contributed.
        e.g., "We present a parameterizable Chisel library that implements fixed-point, floating-point, posit, and unum formats, together with a shared test-and-benchmark framework."
        e.g., "We provide a Scala-based software library integrated into a Jenkins CI pipeline that offers the same set of number representations and automatically runs correctness and performance tests."

   6. Alternative solutions (optional) -one sentence: what exists and what it lacks.
        e.g., "Existing tools such as FloPoCo focus mainly on floating-point and lack support for newer formats like posits."
        e.g., "General-purpose libraries (e.g., NumPy, Julia's standard library) provide many formats but do not enforce automated testing or CI integration for reproducible evaluation."

   7. Key result -one sentence: most important outcome of your evaluation.
        e.g., "In our FPGA experiments, the posit-based multiplier achieved 30% lower error than IEEE-754 at comparable resource usage."
        e.g., "Benchmarking shows that, for a climate-model kernel, the software posit implementation reduces mean absolute error by 25% versus double-precision while keeping runtime within 5%."

   8. Conclusion -one sentence: what your work enables.
        e.g., "The resulting benchmark suite lets hardware designers select number representations based on concrete trade-offs between accuracy, area, and power."
        e.g., "The library and Jenkins workflow give scientific-computing teams an easy way to experiment with alternative number formats and quantify their impact on correctness and cost."

   9. Impact on the field (optional) -one sentence: broader influence.
        e.g., "This can lower production costs for numerical accelerators and encourage wider adoption of efficient, application-specific formats."
        e.g., "It promotes more reproducible scientific software by making number-representation choice a first-class, testable concern in CI pipelines."

   Replace the block below with your 7-9 sentence abstract, following the order above.
