= Quantum Circuit Diagrams <app:circuits>

#import "@preview/quill:0.7.2": *

This appendix demonstrates quantum circuit notation used throughout this report using the Quill package. @fig:grover-iter shows a single Grover iteration circuit, which combines an oracle query with a diffusion operator on a three-qubit register with an ancilla.

#figure(
  quantum-circuit(
    lstick($|0 chevron.r$), $H$, gate($R_z (theta)$), ctrl(1), 1, 1, swap(1), 1, meter(), [\ ],
    lstick($|0 chevron.r$), $H$, 1, targ(), ctrl(1), 1, swap(-1), gate($X$), meter(), [\ ],
    lstick($|0 chevron.r$), $H$, $S$, 1, targ(), ctrl(1), 1, gate($H$), meter(), [\ ],
    lstick($|1 chevron.r$), $X$, $H$, 1, 1, targ(), $H$, $Z$, meter(),
  ),
  caption: [Single Grover iteration on a three-qubit register with ancilla.],
) <fig:grover-iter>

@fig:teleport shows the quantum teleportation protocol: Alice prepares a Bell pair, entangles it with her unknown state $|psi chevron.r$, performs measurements, and transmits classical bits to Bob who reconstructs the state using conditional corrections.

#figure(
  quantum-circuit(
    lstick($|psi chevron.r$, label: "Alice"), 1, 1, ctrl(1), $H$, meter(), setwire(2), ctrl(2, wire-count: 2), [\ ],
    lstick($|0 chevron.r$), $H$, ctrl(1), targ(), 1, meter(), setwire(2), 1, ctrl(1, wire-count: 2), [\ ],
    lstick($|0 chevron.r$, label: "Bob"), 1, targ(), 1, 1, 1, 1, gate($X$), gate($Z$), rstick($|psi chevron.r$),
  ),
  caption: [Quantum teleportation protocol.],
) <fig:teleport>

@fig:qft3 presents the three-qubit Quantum Fourier Transform, a key subroutine in Shor's algorithm and quantum phase estimation. Each qubit undergoes a Hadamard gate followed by controlled phase rotations of decreasing angle.

#figure(
  quantum-circuit(
    lstick($|x_1 chevron.r$), $H$, gate($R_2$, label: (content: "Phase", pos: top)), gate($R_3$), 1, 1, 1, swap(2), rstick($|tilde(x)_1 chevron.r$), [\ ],
    lstick($|x_2 chevron.r$), 1, ctrl(-1), 1, $H$, gate($R_2$), 1, 1, rstick($|tilde(x)_2 chevron.r$), [\ ],
    lstick($|x_3 chevron.r$), 1, 1, ctrl(-2), 1, ctrl(-1), $H$, swap(-2), rstick($|tilde(x)_3 chevron.r$),
  ),
  caption: [Three-qubit Quantum Fourier Transform circuit.],
) <fig:qft3>
