#import "/imports.typ": *


= Template Showcase

== Equations

$ y = a dot x + b $ <eq:sample>


The @eq:sample from above can reference these things 

== Figures

=== Images

#figure(image("/assets/rooster.jpg", width: 60%), caption: [A fancy rooster. #text(font: "Cantarell")[Literally me frfr!]]) <fig:image-example>

And of course @fig:image-example can be referenced.

=== Tables

Tables have their caption automatically placed on top instead of at the bottom as seen in @fig:table-example.

#figure(table(rows: 16 * (0.75em,), columns: 16 * (2em,), inset: 0pt,
  ..color.map.rainbow.map(x => box(fill: x, height: 100%, width: 100%))
), caption: [Rainbow colors!]) <fig:table-example>


== Subfigures

#subfigures(
  figure(image("/assets/foggy_forest.jpg"), caption: [
    An image of a foggy forest.
  ]), <a>,
  figure(image("/assets/foggy_trees.jpg"), caption: [
    Another image of a foggy, but more spooky forest.
  ]), <b>,
  columns: (1fr, 1fr),
  align: top,
  caption: [A figure composed of two sub figures.],
  label: <full>,
)

The template uses #link("https://typst.app/universe/package/subpar", `subpar`) for subfigures. The referencing is also handled by the package and thus @a, @b and @full can be referenced accordingly.

== Listings

#figure(```c
#include <stdio.h>

int main(void) {
  uint8_t counter = 0;

  while(true) {
    counter++;

    if(counter >= 128) {
      counter = 0;
    }
  }

  return 0;
}
```, caption: [A simple C program]) <fig:listing-example>

@fig:listing-example also shows the example.

== Changing Fonts

#[
  #set raw(lang :"typc")
  
  You can use the `set text(font: "...")` `show ...: set text(font: "...")` for the whole document with the exception being the header and footer. These use a little helper function to keep things consistent, of which they apply `"Libertinus Sans"`. This font can be edited inside the file `"/template/util.typ"`.
]



== Custom Referencable Stuff

If you have custom elements, that are also referenced, their counter value has to be reset as well, as numbering is per section. An example below, which uses #link("https://typst.app/universe/package/digidraw", `digidraw`), implements a custom figure with the kind `"timing-diagrams"`:

```typst
#import "@preview/digidraw:0.9.3" as dd

#let wave(..args, caption: none) = figure(
  dd.wave(
  ..args
  ),
  caption: caption,
  supplement: [Diagram],
  kind: "timing-diagrams"
)

#wave(
  (signal: (
    (wave: "x12.udx34z.5.x.",data: "Hello This is Digidraw"),)
  ),
  caption: [Use case of a timing diagram.]
) <dd:example>
```

Which results in @dd:example

#import "@preview/digidraw:0.9.3" as dd

#let wave(..args, caption: none) = figure(
  dd.wave(
  ..args
  ),
  caption: caption,
  supplement: [Diagram],
  kind: "timing-diagrams"
)

#wave(
  (signal: (
    (wave: "x12.udx34z|5.x.",data: "Hello This is Digidraw"),
    (wave: "2u115.40..|3.7.",data: "It has some fancy stuff")
  )),
  caption: [Use case of a timing diagram.]
) <dd:example>

To reset the figure numbering after each level 1 section, a `show` rule can be inserted:

```typst
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "timing-diagrams")).update(0)
  it
}
```

*NOTE* that this counter reset will be removed after each #raw(lang: "typst", `#show: thesis.XXXmatter`.text), so it has to be reinserted after every matter change!


== Test

#lorem(100)

== Test

#lorem(100)

== Test

#lorem(100)

=== Test

#lorem(100)

=== Test

#lorem(100)

=== Test

#lorem(100)

=== Test

#lorem(100)

=== Test

#lorem(100)

=== Test

#lorem(100)


= Template Showcase 2

== Equations

$ y = a dot x + b $ <eq:example>


The @eq:example from above can reference these things 

== Figures



=== Images

#figure(image("../assets/foggy_forest.jpg"), caption: [A boat-load of trees engulfed in fog. #text(font: "Cantarell")[Literally me frfr!]]) <fig:image-example2>

And of course @fig:image-example2 can be referenced.

=== Tables

Tables have their caption automatically placed on top instead of at the bottom as seen in @fig:table-example2.

#figure(table(rows: 16 * (0.75em,), columns: 16 * (2em,), inset: 0pt,
  ..color.map.rainbow.map(x => box(fill: x, height: 100%, width: 100%))
), caption: [Rainbow colors!]) <fig:table-example2>


== Subfigures

#subfigures(
  figure(image("../assets/foggy_forest.jpg"), caption: [
    An image of the andromeda galaxy.
  ]), <a2>,
  figure(image("../assets/foggy_trees.jpg"), caption: [
    A sunset illuminating the sky above a mountain range.
  ]), <b2>,
  columns: (1fr, 1fr),
  align: top,
  caption: [A figure composed of two sub figures.],
  label: <full2>,
)

The template uses #link("https://typst.app/universe/package/subpar", `subpar`) for subfigures. The referencing is also handled by the package and thus @a2, @b2 and @full2 can be referenced accordingly.

== Listings

#figure(```c
#include <stdio.h>

int main(void) {
  uint8_t counter = 0;

  while(true) {
    counter++;

    if(counter >= 128) {
      counter = 0;
    }
  }

  return 0;
}
```, caption: [A simple C program]) <fig:listing-example2>

@fig:listing-example2 also shows the example.


== Changing Fonts

#[
  
  You can use the `set text(font: "...")` `show ...: set text(font: "...")` for the whole document with the exception being the header and footer. These use a little helper function to keep things consistent, of which they apply `"Libertinus Sans"`. This font can be edited inside the file `"/template/util.typ"`.
]


== Custom Referencable Stuff

If you have custom elements, that are also referenced, their counter value has to be reset as well, as numbering is per section. An example below, which uses #link("https://typst.app/universe/package/digidraw", `digidraw`), implements a custom figure with the kind `"timing-diagrams"`:

```typst
#import "@preview/digidraw:0.9.3" as dd

#let wave(..args, caption: none) = figure(
  dd.wave(
  ..args
  ),
  caption: caption,
  supplement: [Diagram],
  kind: "timing-diagrams"
)

#wave(
  (signal: (
    (wave: "x12.udx34z.5.x.",data: "Hello This is Digidraw"),)
  ),
  caption: [Use case of a timing diagram.]
) <dd:example2>
```

Which results in @dd:example2

#wave(
  (signal: (
    (wave: "x12.udx34z|5.x.",data: "Hello This is Digidraw"),
    (wave: "2u115.40..|3.7.",data: "It has some fancy stuff")
  )),
  caption: [Use case of a timing diagram.]
) <dd:example2>

To reset the figure numbering after each level 1 section, a `show` rule can be inserted:

```typst
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "timing-diagrams")).update(0)
  it
}
```

*NOTE* that this counter reset will be removed after each #raw(lang: "typst", `#show: thesis.XXXmatter`.text), so it has to be reinserted after every matter change (if it is to be used in other matters):


```typst
#show: thesis.mainmatter
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "timing-diagrams")).update(0)
  it
}
...

#show: thesis.backmatter
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "timing-diagrams")).update(0)
  it
}
...
```

#pagebreak()

== Filler Section

Used to check if the 5 iterations warning is called.

#lorem(100)

== Filler Section

#lorem(100)

== Filler Section

#lorem(100)

== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)

=== Filler Section

#lorem(100)
