#import "../src/lib.typ": *

#show: hcs-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  config-info(
    title: [Modern Systems & Binary Security],
    subtitle: [Hands-on Seminar & Workshop Series],
    author: [Dr. Alice Chen & Bob Smith],
    institution: [HCS Research Lab],
    date: [Fall 2026],
  ),
)

// --- Cover Slide ---
#title-slide(
  tags: ([Security], [Workshop], [Fall 2026]),
)

// --- Seminar Roadmap ---
#outline-slide()

// ==========================================
= Foundations & Memory Models
// ==========================================

== Why Memory Safety Matters

Modern systems programming balances performance with safety guarantees:

- *Control Flow Integrity*: Preventing arbitrary code execution through gadgets.
- *Spatial & Temporal Safety*: Eliminating out-of-bounds access and use-after-free bugs.
- *Verification Pipelines*: Formal checking and automated fuzzing.

#v(0.5em)

#split[
  #stat-card("70%", "Vulnerabilities", subtext: [Rooted in memory safety flaws], color: hcs-navy)
][
  #stat-card("< 5ms", "Overhead", subtext: [With hardware-assisted CFI], color: hcs-blue)
][
  #stat-card("100%", "Coverage", subtext: [Targeted in modern CI/CD suites], color: hcs-cyan-deep)
]

#note("Emphasize the 70% stat from Microsoft/Google chromium security reports.")

== Key Architectural Concepts

#split[
  #cblock(title: [Concept: Virtual Address Space], type: "info")[
    Each process enjoys an isolated view of memory:
    - User space: text, data, BSS, heap, stack.
    - Kernel space: mapped to higher half (in 64-bit systems).
    - Page tables translate virtual addresses to physical frames.
  ]
][
  #cblock(title: [Takeaway: Zero-Trust Boundaries], type: "tip")[
    Treat every crossing between privilege domains as untrusted:
    - Validate all syscall arguments.
    - Enforce $W xor X$ (Data Execution Prevention).
    - Enable ASLR to randomize base addresses.
  ]
]

// ==========================================
= Hands-on Vulnerability Lab
// ==========================================

== Buffer Overflow Mechanics

A classic stack frame vulnerability occurs when input bounds are ignored:

```c
void vulnerable_function(char *user_input) {
    char local_buffer[64];
    // Unsafe string copy without length checking
    strcpy(local_buffer, user_input);
}
```

#v(0.3em)

#quote-block(
  [Software security is not about building walls; it is about eliminating the cracks within the foundation.],
  author: [Systems Security Handbook],
)

== Hands-on Exercise

#exercise-box(
  title: [Lab 1: Stack Canaries Analysis],
  time: "15 min",
  difficulty: "Hands-on",
  points: "25",
)[
  Analyze the compiled binary in `lab1/target`:

  #step("1", title: [Inspect Security Mitigations])[
    Run `checksec --file=target` to observe whether canary and NX are active.
  ]

  #step("2", title: [Decompile and Locate Frame Pointer])[
    Disassemble `target` and locate the offset between `local_buffer` and the canary value.
  ]

  #step("3", title: [Craft Payload])[
    Write a short Python script using `pwntools` to demonstrate bounds preservation.
  ]
]

// ==========================================
= Advanced Defenses & Wrap-up
// ==========================================

== Defense Comparison

Comparing mitigation strategies across complexity and performance trade-offs:

#split[
  #cblock(title: [Stack Canaries], type: "info")[
    - Inexpensive compiler instrumentation
    - Detects linear stack overflows
    - Terminates process immediately on mismatch
  ]
][
  #cblock(title: [Shadow Stacks (CET)], type: "exercise")[
    - Hardware-enforced return address protection
    - Separate protected memory page
    - Near-zero execution overhead
  ]
][
  #cblock(title: [Static Analysis], type: "warning")[
    - Catches issues pre-compilation
    - False positives require triage
    - Essential part of modern pull requests
  ]
]

// --- Dark Standout Focus Slide ---
#focus-slide(title: [Interactive Break & Q&A])[
  Take 10 minutes to run the exploit script.

  #v(0.5em)
  #text(size: 0.75em, fill: hcs-cyan)[
    github.com/hcs-workshop/lab-exercises
  ]
]

== Seminar Summary & Next Steps

#split[
  #cblock(title: [What We Covered], type: "tip")[
    + Memory layout & virtual address mechanics
    + Buffer overflow vulnerability pathways
    + Compiler & hardware defenses (Canaries, CET, ASLR)
    + Practical auditing methodology
  ]
][
  #cblock(title: [Seminar Resources], type: "cute")[
    - Lab code & solutions on GitHub
    - Join the HCS community discussion server
    - Office hours: Thursdays 16:00 - 18:00
    - Feedback form: `forms.hcs.ac.id/feedback`
  ]
]

#v(0.8em)
#align(center)[
  #text(size: 1.1em, weight: "bold", fill: hcs-navy)[Thank you for attending!] #h(0.5em)
  #badge("HCS Seminar 2026", fill: hcs-slate-light, color: hcs-navy)
]
