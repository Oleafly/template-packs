
#import "template.typ": part

#import "@preview/lilaq:0.6.0" as lq

#let xs = lq.linspace(0, 2)

An object travels along a path at a speed of $v(t) = 2 cos(t) + 3 "m" / "s"$
with $t in [0,2] "seconds"$. A graph of the object's speed is displayed in @fig.p1.speed.

#figure(
  lq.diagram(
    xlabel: $t ("s")$,
    ylabel: $v ("m"/"s")$,
    lq.plot(
      xs,
      xs.map(x => 2*calc.cos(x) + 3),
    )
  ),
  caption: [A plot of the velocity $v=v(t)$ of an object as a function of time $t$.]
) <fig.p1.speed>

Compute

#part(1) the total distance $d$ traveled by the object and

#part(2) the position $p$ of the object along the
path after the travel duration, when its starting point is
$2 "m"$ from the path start point at $t=0$.
