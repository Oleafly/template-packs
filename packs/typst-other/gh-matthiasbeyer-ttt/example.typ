#import "ttt.typ": *

#set text(lang: "en")

#show: ttt.with(
  author: "Matthias Beyer",
  class: [Computer Science],
  subject: [Trees],
  date: datetime(year: 2024, month: 03, day: 19),
  bibliography: bibliography("refs.bib"),
)

= Text

== External links

`ttt` adds a small maroon circle to external (outgoing) links
#link("https://github.com/matthiasbeyer/ttt")[like so].

This acts as a hint for the reader so that they know that a specific text is a
hyperlink. This is far better than #underline[underlining a hyperlink] or making
it a #text(fill: blue)[different color].

If you want to disable this behavior then you can do so by setting the
concerning option to `false`:

```typst
#show: ttt.with(
  external-link-circle: false
)
```

== Blockquotes

`ttt` also exports a `blockquote` function which can be used to create
blockquotes. The function has one argument: `body` of the type content and can
be used like so:

```typst
#blockquote[
  A wizard is never late, Frodo Baggins. Nor is he early. He arrives precisely when he means to.
]
```

The above code will render the following:

#blockquote[
    A wizard is never late, Frodo Baggins. Nor is he early. He arrives
    precisely when he means to. -- Gandalf
]

== Small- and all caps

`ttt` also exports functions for styling text in small caps and uppercase,
namely: `smallcaps` and `upper` respectively.

These functions will overwrite the standard
#link("https://typst.app/docs/reference/text/smallcaps/")[`smallcaps`] and
#link("https://typst.app/docs/reference/text/upper/")[`upper`] functions that
Typst itself provides. This behavior is intentional as the functions that `ttt`
exports fit in better with the rest of the template's styling.

Here is how Typst's own #std-smallcaps[smallcaps] and #std-upper[upper] look
compared to the `ttt`'s variants:\
#hide[Here is how Typst's own ] #smallcaps[smallcaps] and #upper[upper]

They both look similar, the only difference being that `ttt` uses more spacing
between individual characters.

If you prefer Typst's default spacing then you can still use it by prefixing
`std-` to the functions: ```typst #std-smallcaps()``` and ```typst
#std-upper()```.

== Tables

In order to increase the focus on table content, we minimize the table's borders
by using thin gray lines instead of thick black ones. Additionally, we use small
taps for the header row. Take a look at the table below:

#let unit(u) = math.display(math.upright(u))
#let si-table = table(
  columns: 3,
  table.header[Quantity][Symbol][Unit],
  [length], [$l$], [#unit("m")],
  [mass], [$m$], [#unit("kg")],
  [time], [$t$], [#unit("s")],
  [electric current], [$I$], [#unit("A")],
  [temperature], [$T$], [#unit("K")],
  [amount of substance], [$n$], [#unit("mol")],
  [luminous intensity], [$I_v$], [#unit("cd")],
)

#figure(caption: [`ttt`'s styling], si-table)

For comparison, this is how the same table would look with Typst's default styling:

#[
  #set table(inset: 5pt, stroke: 1pt + black)
  #show table.cell.where(y: 0): it => {
    v(0.5em)
    h(0.5em) + it.body.text + h(0.5em)
    v(0.5em)
  }
  #figure(caption: [Typst's default styling], si-table)
]

= Code

#let snip(cap) = figure(caption: cap)[
```rust
fn main() {
    let user = ("Adrian", 38);
    println!("User {} is {} years old", user.0, user.1);

    // tuples within tuples
    let employee = (("Adrian", 38), "die Mobiliar");
    println!("User {} is {} years old and works for {}", employee.0.0, employee.0.1, employee.1);
}
```
]

Here is `code` looks:
#snip("Code snippet")

= Some text

Now lets have some lorem.

== Subheading

#lorem(400)
