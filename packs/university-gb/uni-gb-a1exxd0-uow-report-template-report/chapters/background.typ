= Background <ch:background>

This chapter surveys the theoretical foundations that underpin the interactive verification of quantum learning.

== PAC Learning <sec:pac>

Probably Approximately Correct (PAC) learning formalises the notion of efficient learnability by requiring that a learner, given access to random labelled examples, outputs a hypothesis with low generalisation error with high probability @HAUSSLER199278.

#lorem(200)

#import "../template.typ": definition, theorem, proof

#definition(name: "PAC learnability")[
  A concept class $cal(C)$ over domain $cal(X)$ is _PAC-learnable_ if there exists an algorithm $cal(A)$ and a polynomial $p(dot, dot)$ such that for every $epsilon, delta > 0$, every distribution $cal(D)$ on $cal(X)$, and every target concept $c in cal(C)$, after observing $m >= p(1\/epsilon, 1\/delta)$ i.i.d. examples drawn from $cal(D)$, the algorithm outputs a hypothesis $h$ satisfying
  $ Pr[cal(L)_(cal(D))(h, c) <= epsilon] >= 1 - delta $
  where $cal(L)_(cal(D))$ denotes the generalisation error under $cal(D)$.
]

== Quantum Computation Preliminaries <sec:quantum-prelim>

A quantum state on $n$ qubits is represented as a unit vector $lr(|psi chevron.r) in bb(C)^(2^n)$, and a quantum channel is a completely positive trace-preserving (CPTP) map acting on density operators @king2002capacityquantumdepolarizingchannel. Circuit diagrams for common quantum operations are provided in @app:circuits.

The depolarising channel with noise parameter $p$ acts on a single-qubit state $rho$ as:
$ cal(E)_p (rho) = (1 - p) rho + p / 3 (X rho X + Y rho Y + Z rho Z) $ <eq:depolarising>

#lorem(150)

== Interactive Proof Systems <sec:ip>

An interactive proof system comprises a computationally unbounded prover $P$ and a polynomial-time verifier $V$ who exchange messages over multiple rounds @aharonov2017interactiveproofsquantumcomputations.

#theorem(name: "IP = PSPACE")[
  The class of languages decidable by interactive proof systems with a polynomial-time verifier is exactly $sans("PSPACE")$.
]

#proof[
  The containment $sans("IP") subset.eq sans("PSPACE")$ follows from the fact that the verifier's optimal strategy can be computed in polynomial space; the reverse inclusion $sans("PSPACE") subset.eq sans("IP")$ was established via the sum-check protocol.
]

== Quantum Learning Advantages <sec:quantum-advantage>

Recent work has demonstrated that quantum examples can yield provable learning advantages under cryptographic assumptions, separating quantum PAC learning from its classical counterpart @Rebentrost_2014 @Pirnay_2023.

#lorem(200)
