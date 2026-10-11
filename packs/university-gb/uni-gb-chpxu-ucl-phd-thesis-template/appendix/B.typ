#import "../ucl-thesis.typ": *
#show: appendix
= <app:b>
// You may get a complaint about references not showing up if you're referring to
// labels in other typst documents - this is a known scoping issue
// but the link should still work
This @app:b refers to @app:a.

Here is an equation:
$
  x = frac(-b, 2a) pm frac(sqrt(b^2 - 4 a c), 2a)
$ <eqn:quadform>

It is @eqn:quadform
