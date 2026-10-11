// File: chapter-one.typ
// Author: Franco Cordeiro
// Description: Contains template for a chapter.

#import "../definitions.typ": *

= Chapter 1 <sec:chapter-one>
#cite(<tmp>)

== Introduction <sec-one-intro>

== Section 1<sec:sec-one>
#braced-equations(
  centering: true,
  at-left: $b_k =$,
  labels: ("eq:eq1", "eq:eq2", "eq:eq3"),
  ($b_(k-1),$, $"if " ell = 1$),
  ($b_k,$, $"if " 1 < ell lt.eq chi_k$),
  ($b_(k+1),$, $"if " ell > chi_k$),
)

== Section 2<sec:sec-two>

#theorem[
  In a system with ...
] <the:the1>

#proof[
  By #ref(<eq:eq1>) ...
] <prf:prf1>

== Conclusions <sec:chapter-conclusion>
