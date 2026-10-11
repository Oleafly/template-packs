// ! external
#import "notes.typ": *
#import "shortcuts.typ": *

#import "@preview/cetz:0.2.2"

// ! configuration
#show: doc => conf(
  course_code: "MATH455",
  course_title: "Analysis 4",
  subtitle: "Abstract Metric, Topological Spaces; Functional Analysis.",
  semester: "Winter 2025",
  professor: "Prof. Jessica Lin",
  doc
)

#set align(left)

#pagebreak()

= Analysis 4
== Convolution and Mollifiers

#definition("Convolution")[
  $
  (f ast g) (x) :=  integral_(RR^d) f(x - y) g(y) dif y = integral_(RR^d) f(y) g(x - y) dif y.
  $
]

#proposition("Properties of Convolution")[\
  a. $(f ast g) ast h = f ast (g ast h)$ (convolution is associative)\
  b. Let $tau_z f(x) := f(x - z)$ be the $z$-translate of $x$ which centers $f$ at $z$. Then, $
  tau_z (f ast g) = (tau_z f) ast g = f ast (tau_z g).
  $\
  c. $"supp"(f ast g) subset.eq overline({x + y | x in "supp"(f), y in "supp"(g)})$.
]

#proof[
  (a) Assuming all the necessary integrals are finite, we can change order of integration, $
  ((f ast g) ast h )(x) &= (integral f(y) g(x - y) dif y) ast h(x) \ 
  &= integral integral f(y) g(x - z - y) dif y \, h(z) dif z \
  &= integral integral f(y) g(x - y - z) h(z) dif z dif y  wide (y' = x - y )\ 
  &= integral integral f(x - y') g(y' - z) h(z) dif z dif y' \ 
  &= integral f(x - y')  (g convolve h)(y') dif y' = (f convolve (g convolve h)) (x).
  $

  (b) For the first equality, $
tau_z (f ast g) (x) &= tau_z integral f(x - y) g(y) dif y \ 
    &= integral f(x - z - y) g(y) dif y \
    &= integral (tau_z f(x - y)) g(y) dif y = ((tau_z f) convolve g)(x).
  $ The second follows from a change of variables in the second line.

  (c) We'll show that $A^c subset.eq ("supp"(f ast g))^c$ where $A$ the set as defined in the proposition. Let $x in A^c$, then if $y in "supp"(g)$, $x - y in.not "supp"(f)$ so $f(x - y) = 0$; else if $y in.not "supp"(g)$ it must be $g(y) = 0$. So, if $x in A^c$, it must be that $
  integral f(x - y) g(y) dif y = integral_("supp"(g)) underbrace(f(x - y), = 0)g(y)  dif y+ integral_("supp"(g)^c) f(x - y) underbrace(g(y), = 0) dif y  = 0.
  $
]

We've been rather loose with finiteness of the convolutions so far. To establish this, we need the following result.

#theorem("Young's Inequality")[
  Let $f in L^1 (RR^d), g in L^p (RR^d)$ for any $p in [1, infinity]$. Then, $
  norm(f ast g)_p <= norm(f)_1 norm(g)_p,
  $ hence $f ast g in L^p (RR^d)$.
]

#proof[
Suppose first $p = infinity$, then $
(f ast g)(x) = integral f(y) g(x - y) dif y <= norm(g)_infinity integral abs(f(y)) dif y = norm(g)_infinity norm(f)_1,
$ for every $x in RR^d$, so passing to the $L^infinity$-norm, $
norm(f ast g)_infinity <= norm(f)_1 norm(g)_infinity.
$

Suppose now $p = 1$. Then, $
norm(f ast g)_1 = integral abs(integral f(x - y) g(y) dif y) dif x.
$ Let $F(x, y) = f(x - y) g(y)$, then for almost every $y in RR^d$, $
integral abs(F(x, y)) dif x &= integral abs(g(y)) abs(f(x - y)) dif x \
&=  abs(g(y)) integral abs(f(x - y)) dif x\
&= abs(g(y)) norm(f)_1.
$ Applying Tonelli's Theorem, we have then $
integral.double abs(F(x, y)) dif y dif x &= integral.double abs(F(x, y)) dif x dif y = integral abs(g(y)) norm(f)_1 dif y = norm(f)_1 norm(g)_1,
$ (so really $F in L^1 (RR^d) times L^1 (RR^d)$), hence all together $
norm(f convolve g)_1 = integral abs(integral F(x, y) dif y) dif x <= integral.double abs(F(x, y)) dif y dif x = norm(f)_1 norm(g)_1.
$
#remark[
  It also follows that for a.e. $x in RR^d$, $integral abs(F(x, y)) dif y < infinity$, i.e. $integral abs(f(x - y) g(y)) dif y < infinity$. Moreover, since if $g in L^p (Omega)$ then $abs(g)^p in L^1 (Omega)$, a similar argument gives that for almost every $x in RR^d$, $ integral abs(f(x - y)) abs(g(y))^p dif y < infinity$.
]
Suppose now $1 < p < infinity$. For a.e. $x in RR^d$, $integral abs(g(y))^p abs(f(x - y)) dif y < infinity$, so $g in L^p (RR^d)$ implies for a.e. $x in RR^d$, $|g(dot)|^p abs(f(x - dot)) in L^1 (RR^d)$ as a function of $dot$. This further implies $g(y) f^(1/p) (x - y) in L^p (RR^d, dif y)$. Also, if $f in L^1 (RR^d)$, then $f^(1/q) in L^q (RR^d)$. All together then, $
integral abs(f(x - y)) abs(g(y)) dif y &= integral overbrace(abs(f^(1/q) (x - y)), q)underbrace(abs(f^(1/p) (x - y)) abs(g(y)) dif y, p) \ 
"Holder's" wide &<= (integral abs(f(x - y)) dif y)^(1/q) (integral abs(f(x - y)) abs(g(y))^p dif y)^(1/p),
$ hence, raising both sides to the $p$, $
abs((f convolve g )(x))^p <= norm(f)_1^(p/q) dot (abs(f) convolve abs(g)^p)(x)
$ and integrating both sides $
integral abs((f ast g) (x))^p dif x <= norm(f)_1^(p/q) integral (underbrace(abs(f), in L^1 (RR^d)) ast underbrace(abs(g)^p, in L^1 (RR^d))) (x) dif x.
$ Hence, we can bound the right-hand term using the previous case for $p = 1$, and find $
integral abs((f ast g) (x))^p dif x &<= norm(f)_1^(p/q) norm(f)_1 norm(g^p)_1 \
&= norm(f)_1^(p/q + 1) norm(g)_p^p \ 
&= norm(f)_1^((p + q)/q) norm(g)_p^p \ 
((p + q)/q = p) wide &= norm(f)_1^p norm(g)_p^p,
$ so raising both sides to $1/p$, we conclude $
norm(f ast g)_p <= norm(f)_1 norm(g)_p.
$
]

#proposition[
  If $f in L^1 (RR^d)$ and $g in C^1 (RR^d)$ with $abs(partial_(x_i) g)in L^infinity (RR^d)$ for $i = 1, dots, d$, then $(f ast g) in C^1 (RR^d)$ and moreover $
  partial_(x_i) (f ast g) = f ast (partial_x_i g).
  $
]

#remark[
  There are many different conditions we can place on $f, g$ to make this true; most basically, we need $abs((partial_i g) ast f) < infinity$.
]

#proof[
$
(partial)/(partial x_i) (integral f(y) g(x - y) dif y) &= integral underbrace(f(y), in L^1 (RR^d)) underbrace(partial_i g(x - y), in L^infinity (RR^d)) dif y < infinity,
$ citing the previous theorem for the finiteness; the dominated convergence theorem allows us to pass the derivative inside.
]

#remark[This also follows for the gradient; namely $gradient (f ast g) = f ast (gradient g)$ with a component-wise convolution.]

Consider the function $
rho(x) = cases( C exp(-1/(1 - abs(x)^2)) & "if" abs(x) <= 1, 0 & "o.w."),
$ where $C  = C(d)$ a constant such that $integral_(RR^d) rho(x) dif x = 1$. Then, note that $rho in C^infinity_c (RR^d)$ (infinitely differentiable with compact support). Let now $
rho_(epsilon) (x) := 1/(epsilon^d) rho(x/epsilon).
$ Notice that $rho_epsilon (x)$ is supported on $B(0, epsilon)$, but $
integral_(RR^d) rho_epsilon (x) dif x = 1/(epsilon^d) integral_(RR^d) rho(x/epsilon) dif x = 1/epsilon^d dot epsilon^d dot integral_(RR^d) rho(y) dif y = 1,
$ for every $epsilon$, by making a change of variables $y = x/epsilon$. We'll be interested in the convolution $
f_epsilon (x) := (rho_epsilon convolve f) (x)
$ for some function $f$. $rho_epsilon$ is often called a "convolution kernel". In particular, it is a "good kernel", namely has the properties:
- $integral_(RR^d) rho_epsilon (y) dif y = 1$;
- $integral_(RR^d) abs(rho_epsilon (y)) dif y <= M$ for some finite $M$;
- $forall delta > 0$, $integral_({abs(y) > delta}) abs(rho_epsilon (y)) dif y ->_(epsilon -> 0) 0.$

The second condition is trivially satisfied in this case since our kernel is nonnegative. The last also follows easily since $rho_epsilon$ has compact support; more generally, this imposes rapid decay conditions on the tails of good kernels.

Since $rho_(epsilon) in C_c^infinity (RR^d)$, for "reasonable" $f$, $f_epsilon = rho_epsilon convolve f in C^infinity (RR^d)$ by the previous proposition. In fact, we'll see that in many contexts $f_epsilon -> f$ as $epsilon -> 0$ in some notion of convergence. So, $f_epsilon$ provides a good, now smooth, approximation to $f$.

#proposition[
  Suppose $f in L^infinity (RR^d)$ and $f_epsilon$ is well-defined. Then, if $f$ is continuous at $x$, then $f_(epsilon) (x) -> f(x)$ as $epsilon -> 0$. 
  
  If $f in C(RR^d)$, then $f_epsilon -> f$ uniformly on compact sets.
]

#proof[
 $f$ continuous at $x$ gives that for every $eta > 0$ there exists a $delta > 0$ such that $abs(f(y) - f(x))< eta$  whenver $abs(x - y) < delta$. Then $
 abs(f_epsilon (x) - f(x)) &= abs(integral rho_epsilon (y) f(x - y) dif y - f(x) underbrace(integral rho_epsilon (y) dif y, = 1)) \ 
 &= abs(integral rho_epsilon (y) (f(x - y) - f(x)) dif y) \ 
 &<= integral_({abs(y) <= delta}) abs(f(x  - y) - f(x)) abs(rho_epsilon (y)) dif y + integral_({abs(y) > delta}) abs(f(x - y) - f(x)) abs(rho_epsilon (y)) dif y \ 
 (#stack(spacing: .3em, text(size: 8pt, "cnty in first argument"),[#text(size: 8pt, [$L^infinity$-bound in second])]))
   wide & <= integral_({abs(y) <= delta}) eta abs(rho_epsilon (y)) dif y + 2 norm(f)_infinity integral_(abs(y) > delta) abs(rho_epsilon (y)) dif y \ 
   & <= eta dot M + 2 norm(f)_infinity integral_({abs(y)> delta}) abs(rho_epsilon)
 $ for $epsilon -> 0$, by using the second property of good kernels for the first bound. By the last property, the right-most term $->0$ as $epsilon -> 0$; moreover, then, $
 lim_(epsilon -> 0) abs(f_epsilon (x) - f(x)) <= C eta 
 $ for some $C$ and every $eta > 0$, and thus $f_epsilon (x) -> f(x)$ as $epsilon -> 0$.

 Now, if $f in C(RR^d)$ fix a subset $K subset.eq RR^d$ compact. Hence, $norm(f)_(L^infinity (K)) <infinity$ and $f$ uniformly continuous on $K$ since $K$ compact; so the modulus of continuity is uniform for all $x in K$, so for $delta > 0$ and for every $x in K$, $
 integral_({abs(y) <= delta}) abs(f(x - y) - f(x)) abs(rho_epsilon (y)) dif y <= C eta.
 $ Also, using the bound on $f$, we may write the second integral in the argument above as $
 integral_(epsilon > abs(y) > delta) abs(f(x - y) - f(x)) abs(rho_epsilon (y)) dif y <= norm(f)_(L^infinity (K + B_epsilon)) integral_({abs(y) > delta}) abs(rho_epsilon (y)) dif y ->_(epsilon -> 0) 0
 $ where we take $K$ slighly larger as $K + B_epsilon$, which is still compact. So, since this held for all $x in K$, $
 max_(x in K) abs(f_epsilon (x) - f(x)) ->_(epsilon -> 0) 0.
 $

 _Note that we proved the first for general good kernels but the second only in our constructed one_.
]

#remark[
  This pointwise convergence result is why "good kernels" are called "approximations to the identity".
]

#remark[
  If $f in C_c (RR^d)$, then $"supp"(f_epsilon) subset.eq overline("supp" (f) + B(0, epsilon))$; so, $f_epsilon$ is compactly supported if $f$ is. Hence in this case $f_epsilon -> f$ uniformly on $RR^d$. More generally, there are many different restrictions one can place on the last claim, such as compact support of $f$, uniform continuity of $f$, compact support of the kernel, lack of compact support for the kernel but an $L^infinity$ bound on $f$, etc. In practice, the proofs are all the same, with different bounds; namely one finds something of the form $
  |f_epsilon (x) - f(x)| <= underbrace(integral_(|y| < delta) (dots), #stack(spacing: .2em, "small by", "(uniform) continuity")) + underbrace(integral_(|y| >= delta) (dots), #stack(spacing: .2em, "small by", "compact support, etc"))
  $
]

#theorem("Weierstrass Approximation Theorem")[
Let $[a, b] subset.eq RR$ and let $f in C([a, b])$. Then for every $eta > 0$, there exists a polynomial $P_N (x)$ of degree $N$ such that $
  norm(P_N - f)_(L^infinity ([a, b])) < eta.
$ That is, polynomials are dense in $C([a, b])$.
]

#proof[
  Extend $f$ to be continuous with compact support on all of $RR$ in whatever convenient way, such that $"supp"(f) subset.eq [-M, M]$ for some sufficiently large $M > 0$. Consider now $
  K_epsilon (x) := 1/(sqrt(epsilon)) e^(- (pi x^2)/epsilon),
  $  noting that $
  integral_(-infinity)^infinity K_epsilon (x) dif x = integral_(-infinity)^infinity 1/(sqrt(epsilon)) e^(- (pi x^2)/epsilon) dif x = 1,
  $ which is clear by a change of variables $y = sqrt(2 pi)/(sqrt(epsilon)) x$. As a consequence, $integral_(-infinity)^infinity abs(K_epsilon (x)) dif x = 1 < infinity$, since $K_epsilon >= 0$. Finally, $
  integral_(abs(x) > delta) abs(K_epsilon (x)) dif x &= integral_(abs(x) > delta)1/(sqrt(pi)) e^(-(pi x^2)/epsilon) dif x \ 
  &= integral_(abs(y) > sqrt(2 pi)/(sqrt(epsilon)) delta) e^(-(y^2)/2)/(sqrt(2 pi)) dif y \ 
  #text(size: 9pt, [since $abs(y) >= 1$ here for suff. small $epsilon$]) wide & <=  integral_(abs(y) > sqrt(2 pi)/(sqrt(epsilon)) delta) abs(y)/(sqrt(2 pi)) e^(-(y^2)/2)/(sqrt(2 pi)) dif y \
  &<= C  e^(-(y^2)/2)#vbar(2em)_(thin sqrt(2 pi)/(sqrt(epsilon)) delta)^(thin infinity) ->_(epsilon -> 0) 0.
  $  So, $K_epsilon$ is a good kernel, and so $(f ast K_epsilon) (epsilon) ->_(epsilon -> 0) f$ uniformly in $[a, b]$ by our last remark. In particular, for $eta>0$ there is some $epsilon_0 > 0$, $
  norm((f ast K_epsilon_0) - f)_(L^infinity ([a, b])) < eta/2.
  $ We claim now that there is a polynomial $P_N$ such that $norm(P_N - (f ast K_epsilon_0))_(L^infinity ([ a, b])) < eta/2$. Recall that $e^x = sum_(n=0)^infinity (x^n)/(n!)$, which converges uniformly on compact sets. So, there exists a polynomial $S_N$ (from truncating this sum) such that $norm(K_epsilon_0 - S_N)_(L^infinity ([-M, M])) < eta/(4 norm(f)_infinity M)$. Thus, $
  abs(f ast K_epsilon_0 (x) - f ast S_n (x)) &<=  abs(integral f(x - y) (K_epsilon_0 (y) - S_N (y)) dif y) \
  "supp"(f) subset [-M, M] wide &<=integral_(-M)^M abs(f(x - y)) abs(K_epsilon_0 (y) - S_N (y)) dif y \ 
  &<= 2 M norm(f)_infinity eta/(4 M norm(f)_infinity) =  eta/2,
  $ for every $x$. Let $P_N (x) = (f ast S_n) (x)$, which we see to be a polynomial.
]

#theorem[
  Let $f in L^p (RR^d)$ with $p in [1, infinity)$. Then $f_epsilon ->_(L^p (RR^d)) f$.
]
#proof[
  Since $f in L^p (RR^d)$, for every $eta > 0$ there is a $tilde(f) in C_c (RR^d)$ such that $norm(f - tilde(f))_p < eta$. Since $tilde(f) in C_c (RR^d)$, by the previous theorem dealing with mollifiers and uniform convergence, $tilde(f)_epsilon -> tilde(f)$ uniformly. In particular, we have $norm(tilde(f)_epsilon - tilde(f))_p ->_(p) 0$, hence $
  norm(f - f_epsilon)_p <= norm(f_epsilon - tilde(f)_epsilon)_p + norm(tilde(f)_epsilon - tilde(f))_p + norm(tilde(f) - f)_p.
  $ We've dealt with the second two bounds. For the first, $
  norm(f_epsilon - tilde(f)_epsilon)_p &= norm((f - tilde(f)) convolve rho_epsilon)_p \
  ("Young's") wide &<= norm(rho_epsilon)_1 norm(f - tilde(f))_p = norm(f - tilde(f))_p,
  $ so $
  norm(f - f_epsilon)_p <= 2 norm(f - tilde(f))_p + norm(tilde(f)_epsilon - tilde(f))_p < 3 eta.
  $
]

#corollary[
  $C_c^infinity (RR^d)$ dense in $L^p (RR^d)$.
]
#proof[
  We showed $tilde(f)_epsilon$ approximates $f$ in $L^p (RR^d)$, and by construction $tilde(f)_epsilon$ is smooth with compact support.
]