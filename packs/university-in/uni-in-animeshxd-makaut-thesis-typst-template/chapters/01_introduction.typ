= Introduction
== secondary <1st>
#lorem(40)
ref to 2nd @2nd
== secondary <2nd>
#lorem(40)
ref to 1st @1st
and image ref @logoa
== Citations works?
#lorem(10)
test by @test and
letex ref @original
#pagebreak()
#figure(
  image("../assets/makaut-logo.jpg"),
  caption: [A logo],
) <logoa>

#v(1cm)

#figure(
  table(
    columns: 2,
    [*Amount*], [*Ingredient*],
    [360g], [Baking flour],
    [250g], [Butter (room temp.)],
    [150g], [Brown sugar],
    [100g], [Cane sugar],
    [100g], [70% cocoa chocolate],
    [100g], [35-40% cocoa chocolate],
    [2], [Eggs],
    [Pinch], [Salt],
    [Drizzle], [Vanilla extract],
  ),
  caption: "a table",
) <table>

== test method
$ A = pi r^2 $\
$ "area" = pi dot "radius"^2 $\
$ cal(A) :=
    { x in RR | x "is natural" } $ \
#let x = 5
$ #x < 17 $



#pagebreak()
