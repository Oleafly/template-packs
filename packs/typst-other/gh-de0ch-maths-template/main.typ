#import "libs/template.typ": *
#show: thmrules
#import "@preview/xarrow:0.4.0": xarrow, xarrowSquiggly, xarrowTwoHead


#show: project.with(
  title: "Project Title",
  authors: (
    "Deyao",
  ),

  date: datetime.today().display("[day padding:none] [month repr:long] [year]"),
)



#outline(indent: auto)

= Heading


#definition("Simplicial object")[
  Let $[n]$ denote the linearly ordered set ${0, 1, 2, ..., n}$. Let $Delta$ be the category where objects are $[n]$ for all natural numbers $n$ (including 0) and morphisms are (non-strictly) order preserving maps. More concretely, for any morphism $p: [n] -> [m]$, $p(i) <= p(j)$ if $i<=j$. A *simplicial object in $cal(A)$* is a functor $Delta^"op" -> cal(A)$, where $cal(A)$ is some category.
]<simplicial-object>


#proposition[
  $
    d_j compose d_i &= d_i compose d_(j-1)  "if" i < j \
    s_j compose s_i &= s_i compose s_(j+1)  "if" i <= j \
    s_j compose d_i &= cases(
      d_i compose s_(j-1) & "if" i < j,
      id & "if" i = j "or" i = j + 1,
      d_(i-1) compose s_j & "if" i > j + 1
    )

  $
]

#proof[
  Omitted because we can straightforwardly verify the identities.
]
These identities are full in the following sense.

#proposition[
  Given any map $f: [m] -> [n]$, there is a way to unique write it as a composition of face and degeneracy map in the following form
  $ f = d_(i_1) compose ... compose d_(i_k) compose s_(j_1) compose ... compose s_(j_l) $
  where $i_1 <= i_2 <= ... <= i_k$ and $j_1 <= j_2 <= ... <= j_l$. It is unique in the sense that if there is another way to write 
  $ f = d_(i'_1) compose ... compose d_(i'_k') compose s_(j'_1) compose ... compose s_(j'_l') $

  Then $k = k'$, $l = l'$, and $i_m = i'_m$ for all $1 <= m <= k$ and $j_n = j'_n$ for all $1 <= n <= l$.

  Furthermore, given any composition of face and degeneracy maps, we can turn it into the unique form with a series of steps where each steps involves substituting one side of the simplicial identities for the other.
]<unique-decomposition>

#proof[
  We first prove the face maps are unique, which we do by induction on $k$, which we assert is the number of elements in $[n]$ that is not in the image of $f$. For convenience, we let the base case $k = -1$ be the statement that there is a unique surjective map $delta$ such that $f = delta$. It holds obviously.

  Suppose the statement holds for $k = q$, then for $k = q+1$, we let $i_(q+1)$ be the largest number in $[n]$ that is not in the image of $f$. We let 
  $
  f': [m] &-> [n-1] \
  x &mapsto cases(
    f(x) & "if" f(x) < i_(q+1),
    f(x) - 1 & "if" f(x) > i_(q+1)
  )
  $

  Then the existence of the decomposition follows inductively. The uniqueness also follows inductvely. Suppose there is another sequence in the decomposition, $j_0 < j_1 <... < j_k'$, then $k' = q+1$ and $delta' = delta$ follows inductively. Then $j_(q+1) = i_(q+1)$ the decomposition tell us that the largest number in $[n]$ that is not in the image of $f$ is $j_(q+1)$, so $j_(q+1) = i_(q+1)$.

  Then a similar inductive argument shows we can write any surjective map as a composition of face maps in a unique way.
]

#notation[
  Given a simplicial set $K$, we write $K(d_i^n)$ as $partial_i^n$ and $K(s_i^n)$ as $sigma_i^n$. Also, if it is clear from context what $n$ is (because it's clear what the domain and codomain is, we will drop the subscript $n$ and simply write $partial_i$ and $sigma_i$.

  Also, since we will almost never use face maps on $Delta$ directly, we will still use $d$ to denote the usual boundary map on chain complexes. 
]

#construction[
  Given a semisimplicial object $A'$, we can construction a simplicial object $A$ as follows:
  - For each $n >= 0$, let 
  $ 
  A_n = plus.o.big_([n] arrow.r.twohead [k]) A'_k 
  $

  Where $[n] arrow.r.twohead [k]$ denotes a epimorphism from $[n]$ to $[k]$ in $Delta$, the direct sum is taken over all epimorphisms for all $0 <= k <= n$. To facilitate the discussion, let's label each summand by the corresponding epimorphism, like $A'_([n] arrow.r.twohead [k])$. This is just $A'_k$, but it tells the reader how to embed it into $A_n$ should a construction require it. 

  For each morphism $f: [m] -> [n]$ in $Delta$,  we examine what $A_([n] arrow.r.twohead [k])$ maps to under the induced map.
  
  We compose precompose $[n] arrow.r.twohead [k]$ with $f$ into a function $g$. That is we form #box[$g: [m] ->^f [n] arrow.r.twohead [k]$], then we invoke @unique-decomposition to write it as 

  $
    g: [m] arrow.r.twohead^eta [m'] ->^epsilon [k]
  $

where $eta$ is epic and $epsilon$ is monic.

We then send $A_([n] arrow.r.twohead [k])$ to $A_([m] arrow.r.twohead [m'])$ with $A'(epsilon)$. Since $[n] arrow.r.twohead [k]$ was arbitrary, we have defined a morphism $ A(f): A_n = plus.o.big_([n] arrow.r.twohead [k]) A'_k -> A_m $

We need to verify that it is indeed a functor from $Delta^"op"$ to $cal(A)$ by verifying it respects composition. This is straightforward but tedious, so we omit it here.

]<semisimplicial-to-simplicial>


#remark[
  Some remark
]



#corollary[
  Let $S$ be a ring, $N$ be a right $S$-module, $M$ be a left $S$-module, and $P_* -> M$ be a flat resolution of $M$. Then 

  $
    Tor_*^S (N, M) approx.eq H_* (N times.o_S P_*)
  $
]

#theorem[
  Let $S$ be a ring, and let $M$ and $N$ be left $S$-modules. Let $P_* -> M$ be a projective resolution of $M$. Then there are canonical isomorphisms:

  $
  Ext^n_S (N, M) approx.eq H^n (hom_S (P_*, M))
  $
]


#bibliography("bib.bib", style: "chicago-author-date", full: true)