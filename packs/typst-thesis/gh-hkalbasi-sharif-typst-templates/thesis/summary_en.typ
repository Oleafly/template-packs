#align(center)[
  *Abstract*
]

#v(40pt)

A decompiler is a tool that attempts to reverse machine code back into human-readable source code. This inverse translation process is inherently difficult because high-level information, such as variable names, data types, and logical structures, is lost during compilation. While Large Language Models (LLMs) show significant promise for recovering this "human-like" information, they suffer from a critical flaw: hallucination. An LLM cannot guarantee that its generated code is semantically equivalent to the original machine code, which poses an unacceptable risk.

This thesis presents a novel decompiler with a layered architecture specifically designed to solve this problem. Instead of having an LLM generate code directly, our method uses the LLM as an agent that suggests a series of pre-defined, high-level operations to improve the code's readability. The core contribution is that every operation suggested by the LLM is algorithmically verified to ensure it strictly preserves the program's behavior before it is applied.

This hybrid approach successfully combines the pattern-recognition strengths of LLMs for enhancing readability with the correctness guarantees of formal methods. By doing so, it prevents hallucinations and ensures the final, human-readable code is semantically equivalent to the machine code input.

*Keywords:* Decompilers, Large Language Models, Program Analysis, Semantic Equivalence, Formal Verification
