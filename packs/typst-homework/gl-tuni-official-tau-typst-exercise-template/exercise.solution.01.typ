
#import "template.typ": part

#part(1)
The total distance traveled by the object is found out by
integrating the absolute value of the velocity function
over the travel duration. Since @fig.p1.speed shows that
$v$ is positive for the whole travel duration, we can
ignore the absolute value signs and simply write
$
  d
  &=
  integral_0^2
  v(t)
  dif t
  =
  integral_0^2
  2 cos(t) + 3
  dif t
  =
  [
    2
    sin(t)
    +
    3 t
    +
    C
  ]_0^2
  \
  &=
  2 sin(2)
  +
  3 times 2
  -
  2 sin(0)
  -
  3 times 0
  \
  &=
  2 sin(2) + 6
$ <eq.p1.distance>
meters.

#part(2) Again, we can ignore the absolute value signs and plug in
$C = 2 "m"$ into the anti-derivative shown in the derivation @eq.p1.distance. Our position is then
$
  p = 2 sin(2) + 6 + 2 = 2 sin(2) + 8
$
meters.
