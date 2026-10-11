= Literature Review

This chapter provides a comprehensive review of the literature relevant to the design, analysis, and optimization of Type-4 composite pressure vessels. It covers the fundamental principles of composite mechanics, failure analysis, and the application of metaheuristic optimization techniques in this domain.

== Classical Lamination Theory (CLT)

The structural behavior of the composite overwrap is typically modeled using Classical Lamination Theory (CLT). CLT treats the vessel wall as a stack of orthotropic plies, where the properties of the entire laminate are derived from the properties of individual unidirectional layers.

The stress-strain relationship for a single orthotropic ply in the principal material coordinates ($1,2$) is given by:

$ vec(sigma)_12 = [Q] vec(epsilon)_12 $

Where $[Q]$ is the reduced stiffness matrix defined by the material's elastic moduli ($E_1, E_2$), shear modulus ($G_{12}$), and Poisson's ratio ($nu_{12}$). Since the winding angle $\\theta$ varies for each layer, these properties are transformed into the global coordinate system ($x,y$) using the transformation matrix $[T]$:

$ [overline(Q)] = [T]^(-1) [Q] [T]^(-T) $

The global stiffness of the laminate is then described by the $A$, $B$, and $D$ matrices, which relate the resultant forces ($N$) and moments ($M$) to the mid-plane strains ($epsilon^0$) and curvatures ($kappa$):

$ mat(N; M) = mat(A, B; B, D) mat(epsilon^0; kappa) $

For a cylindrical pressure vessel under internal pressure $P$, the resultant forces are derived from the thin-shell assumption:
$ N_x = (P R) / 2, quad N_y = P R $
where $R$ is the vessel radius. This analytical framework allows for the rapid evaluation of stresses in every layer of the laminate.
