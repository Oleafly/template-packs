#import "../../macros/environments.typ": *

== Theorem-like environments

The environment module provides boxed, labelable mathematical environments.

#definition(title: [Demo definition])[
A demonstration environment is an example block used to verify styling and references.
] <def:appendix-demo>

#theorem(title: [Demo theorem])[
Every demonstrated macro has a visible rendering in this appendix.
] <thm:appendix-demo>

#lemma(title: [Demo lemma])[
The theorem, lemma, proposition, and corollary environments share one theorem counter.
]

#proposition(title: [Demo proposition])[
A proposition uses the same theorem-family style as the theorem and lemma.
]

#corollary(title: [Demo corollary])[
The corollary follows from the demo theorem.
]

#example(title: [Demo example])[
References work normally: see @def:appendix-demo and @thm:appendix-demo.
]

#remark(title: [Demo remark])[
Definitions, examples, and remarks use separate counters.
]

#proof(title: [of @thm:appendix-demo])[
Each block above is rendered directly in the compiled document. Therefore the macros are demonstrated. 
]

#proof(title: [without QED], qed: none)[
The optional `qed` argument can suppress the closing symbol.
]
