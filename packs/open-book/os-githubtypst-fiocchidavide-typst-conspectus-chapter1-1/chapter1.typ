= Probability background

Notice that none of the equations below carry a single `#h(0pt)`: operator
spacing is set per-symbol in `spacing.typ`. The default there tightens the
relations, binaries, and bars — including the conditioning bar $p(x | y)$ and
the double bar $"KL"(p ‖ q)$. Punctuation like the colon in $f : A -> B$ keeps
its normal spacing until you opt in. Write ordinary Typst math and it stays dense.

$ EE[A X + b] = A EE[X] + b, quad EE[X + Y] = EE[X] + EE[Y] $
$ "Cov"[X, Y] &= EE[(X - EE[X])(Y - EE[Y])^T] \
  &= EE[X Y^T] - EE[X] EE[Y]^T $
$ "Var"[A X + b] = A "Var"[X] A^T, quad "Var"[X] = "Cov"[X, X] $

Change of variables for a diffeomorphism $g$, with $Y = g(X)$:
$ p_Y (y) = p_X (g^(-1)(y)) dot abs(det(D g^(-1)(y))) $

== Gaussians

$ cal(N)(x; mu, Sigma) = (exp(-1/2 (x - mu)^T Sigma^(-1) (x - mu))) / sqrt((2 pi)^n det(Sigma)) $

For index sets $A, B$, conditioning stays Gaussian,
$X_A | X_B = x_B tilde cal(N)(mu_(A|B), Sigma_(A|B))$ where
$ mu_(A|B) &= mu_A + Sigma_(A B) Sigma_(B B)^(-1) (x_B - mu_B) \
  Sigma_(A|B) &= Sigma_(A A) - Sigma_(A B) Sigma_(B B)^(-1) Sigma_(B A) $

Affine maps and sums of independent Gaussians:
$ A X + b tilde cal(N)(A mu + b, A Sigma A^T) \
  X + X' tilde cal(N)(mu + mu', Sigma + Sigma') $

== Information theory

Surprise, entropy, and cross-entropy:
$ S[u] = -log(u), quad H[p] = EE_(x tilde p)[S[p(x)]] \
  H[p, q] = H[p] + "KL"(p || q) $

KL divergence and Gibbs' inequality:
$ "KL"(p || q) = EE_(theta tilde p)[log p(theta) / q(theta)] >= 0 \
  "KL"(p || q) = 0 <=> p = q "a.s." $

_Information never hurts:_ $H[X | Y] <= H[X]$, and mutual information
$ 0 <= I(X; Y) &= H[X] - H[X | Y] \
  &= H[X] + H[Y] - H[X, Y] = I(Y; X) $
