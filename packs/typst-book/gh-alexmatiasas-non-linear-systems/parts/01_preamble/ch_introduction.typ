// Chapter 1: Introduction to Non-Linear Systems
// Sample chapter demonstrating the template

#import "../../style/functions.typ": (
  theorem, lemma, proposition, corollary, proof,
  python-block, rust-block, terminal-output,
  book-figure, make-equation
)

#heading(level: 1)[Introduction to Non-Linear Systems]

== What are Non-Linear Systems?

Non-linear systems are mathematical systems where the output is not directly proportional to the input. Unlike linear systems that follow the principle of superposition, non-linear systems exhibit complex behaviors such as chaos, bifurcations, and limit cycles.

=== Mathematical Definition

A system is non-linear if it does not satisfy the superposition principle:

$ f(a x + b y) = a f(x) + b f(y) $

where $ f $ is the system function, $ a $ and $ b $ are constants, and $ x $ and $ y $ are inputs.

== The Navier-Stokes Equations

The Navier-Stokes equations describe the motion of viscous fluid substances. These equations model a wide range of phenomena:

- Weather patterns
- Ocean currents
- Airfoil aerodynamics
- Blood flow in vessels

The incompressible Navier-Stokes equations are:

$ (partial u)/(partial t) + (u . nabla) u = - (1/rho) nabla p + nu nabla^2 u + f $

and the continuity equation:

$ nabla . u = 0 $

where:
- $ u $ is the velocity vector
- $ p $ is the pressure
- $ rho $ is the density
- $ nu $ is the kinematic viscosity
- $ f $ is external force

== Example: Python Simulation

Let's show a simple Python simulation:

#python-block[
```python
import numpy as np
import matplotlib.pyplot as plt

def van_der_pol(x, mu=1.0):
    return np.array([x[1], mu * (1 - x[0]**2) * x[1] - x[0]])

t = np.linspace(0, 20, 1000)
x0 = [2.0, 0.0]
dt = 0.01
x = np.zeros((len(t), 2))
x[0] = x0

for i in range(1, len(t)):
    x[i] = x[i-1] + dt * van_der_pol(x[i-1])

plt.plot(x[:, 0], x[:, 1])
plt.show()
```], caption: [Van der Pol oscillator]

#terminal-output[plt show]

== Key Theorems

#theorem[
  Let $ f: RR^n -> RR^n $ be a smooth vector field. If $ x^* $ is an equilibrium point where $ f(x^*) = 0 $, then the stability of $ x^* $ is determined by the eigenvalues of the Jacobian matrix $ D f(x^*) $.
]

#lemma[
  For a Hamiltonian system with $ n $ degrees of freedom, the energy $ H $ is a conserved quantity: $ (d H)/(d t) = 0 $ along trajectories.
]

#proposition[
  The Lorenz system exhibits chaotic behavior for parameter values $ sigma = 10 $, $ rho = 28 $, $ beta = 8/3 $.
]

#proof[
  The proof follows from analyzing the Lyapunov exponents of the system.
]

== Summary

In this chapter we have:
1. Defined non-linear systems
2. Introduced the Navier-Stokes equations
3. Shown code examples
4. Presented key theorems