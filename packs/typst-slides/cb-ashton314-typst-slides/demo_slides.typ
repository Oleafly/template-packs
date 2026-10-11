#import "@preview/cetz:0.5.1"

#import "theme.typ": *
#show: nss-theme.with(palette: light-palette)

#cover-slide(
    title: [Property-Based Testing],
    subtitle: [Better testing for humans and agents],
    author: [Ashton Wiersdorf ◊ Angel Studios ◊ 2026]
)

== Let's write a sorting algorithm

```elixir
def hasty_sort([]), do: []
def hasty_sort(lst) do
  [pivot | rst] = lst
  left = Enum.filter(rst, & &1 < pivot)
  right = Enum.filter(rst, & &1 > pivot)
  hasty_sort(left) ++ [pivot] ++ hasty_sort(right)
end
 ```

== Testing our function


```elixir
test "sorted list OK" do
  assert [1, 2, 3, 4] == PbtDemo.hasty_sort([1, 2, 3, 4])
end
```

#pause
```elixir
test "sorts 4 elements" do
  assert [1, 2, 3, 4] == PbtDemo.hasty_sort([3, 2, 4, 1])
end
```

#pause

Our tests pass!

#statement-slide[Is the implementation correct?]

== #hide[]

```elixir
def hasty_sort([]), do: []
def hasty_sort(lst) do
  [pivot | rst] = lst
  left = Enum.filter(rst, & &1 < pivot)
  right = Enum.filter(rst, & &1 > pivot)
  hasty_sort(left) ++ [pivot] ++ hasty_sort(right)
end
 ```

#statement-slide[Why didn't we catch this with our tests?]

== #hide[]

Code:

```elixir
def hasty_sort([]), do: []
def hasty_sort(lst) do
  [pivot | rst] = lst
  left = Enum.filter(rst, & &1 < pivot)
  right = Enum.filter(rst, & &1 > pivot)
  hasty_sort(left) ++ [pivot] ++ hasty_sort(right)
end
```

Tests:

```elixir
  assert [1, 2, 3, 4] == PbtDemo.hasty_sort([1, 2, 3, 4])
  assert [1, 2, 3, 4] == PbtDemo.hasty_sort([3, 2, 4, 1])
 ```

#statement-slide[Testing exercises only a _few_ paths]

== Testing exercises only a _few_ paths

#let domain-diagram = align(center)[
#cetz.canvas({
  import cetz.draw: *

    circle((0, 0), radius: 100pt, name: "domain-universe")
    content((name: "domain-universe", anchor: "north"), [Domain], anchor: "south", padding: 0.5)
    circle((15, 0), radius: 100pt, name: "range-universe")
    content((name: "range-universe", anchor: "north"), [Range], anchor: "south", padding: 0.5)

    // internal circles and labels
    circle((1, 0), radius: (50pt, 75pt), fill: nord-palette.green)
    line((1,0), (-1, -5), stroke: (paint: nord-palette.green, thickness: 4pt))
    content((), text([Acceptable inputs], size: 20pt), anchor: "north", padding: 5pt)
    circle((14, 0), radius: (50pt, 75pt), fill: nord-palette.orange)
    line((14,0), (15, -5), stroke: (paint: nord-palette.orange, thickness: 4pt))
    content((), text([Acceptable outputs], size: 20pt), anchor: "north", padding: 5pt)

    // Function transformation
    circle((0.5,0.5), radius: 3pt, fill: nord-palette.nord2, name: "dpoint1")
    circle((1.5,-0.9), radius: 3pt, fill: nord-palette.nord2, name: "dpoint2")
    circle((1.2, 1.3), radius: 3pt, fill: nord-palette.nord2, name: "dpoint3")

    circle((14.8,0.6), radius: 3pt, fill: nord-palette.nord2, name: "rpoint1")
    circle((13.2,-1.2), radius: 3pt, fill: nord-palette.nord2, name: "rpoint2")
    circle((13.5, 1.7), radius: 3pt, fill: nord-palette.nord2, name: "rpoint3")

    line("dpoint1", "rpoint1")
    line("dpoint2", "rpoint2")
    line("dpoint3", "rpoint3")
})
]

#let domain-with-bug-region = align(center)[
#cetz.canvas({
  import cetz.draw: *

    circle((0, 0), radius: 100pt, name: "domain-universe")
    content((name: "domain-universe", anchor: "north"), [Domain], anchor: "south", padding: 0.5)
    circle((15, 0), radius: 100pt, name: "range-universe")
    content((name: "range-universe", anchor: "north"), [Range], anchor: "south", padding: 0.5)

    // internal circles and labels
    circle((1, 0), radius: (50pt, 75pt), fill: nord-palette.green)
    line((1,0), (-1, -5), stroke: (paint: nord-palette.green, thickness: 4pt))
    content((), text([Acceptable inputs], size: 20pt), anchor: "north", padding: 5pt)
    circle((14, 0), radius: (50pt, 75pt), fill: nord-palette.orange)
    line((14,0), (15, -5), stroke: (paint: nord-palette.orange, thickness: 4pt))
    content((), text([Acceptable outputs], size: 20pt), anchor: "north", padding: 5pt)

    circle((0.2, -1), radius: (15pt, 25pt), fill: nord-palette.red)
    line((0.2,-1), (7, -4), stroke: (paint: nord-palette.red, thickness: 4pt))
    content((), text([Inputs that exercise the bug], size: 20pt, fill: nord-palette.red), anchor: "north", padding: 5pt)

    // Function transformation
    circle((0.5,0.5), radius: 3pt, fill: nord-palette.nord2, name: "dpoint1")
    circle((1.5,-0.9), radius: 3pt, fill: nord-palette.nord2, name: "dpoint2")
    circle((1.2, 1.3), radius: 3pt, fill: nord-palette.nord2, name: "dpoint3")

    circle((14.8,0.6), radius: 3pt, fill: nord-palette.nord2, name: "rpoint1")
    circle((13.2,-1.2), radius: 3pt, fill: nord-palette.nord2, name: "rpoint2")
    circle((13.5, 1.7), radius: 3pt, fill: nord-palette.nord2, name: "rpoint3")

    line("dpoint1", "rpoint1")
    line("dpoint2", "rpoint2")
    line("dpoint3", "rpoint3")
})
]

#alternatives(domain-diagram, domain-with-bug-region)

#statement-slide[Sample points _randomly_ from \ the set of acceptable inputs]

== Random sampling

- Property-based testing generates lots of random, valid inputs to our function.
- We need things that we can check to ensure our function does the right thing with a random input.
    - These are called _properties_.
#pause
- Example properties: output length matches input length, result matches call to ```Elixir Enum.sort/1```

== #hide[]

```elixir
property "matches Enum.sort results" do
  check all lst <- StreamData.list_of(integer()) do
    assert Enum.sort(lst) == PbtDemo.hasty_sort(lst)
  end
end

property "preserves length of input list" do
  check all lst <- StreamData.list_of(integer(), min_length: 3) do
    assert length(lst) == length(PbtDemo.hasty_sort(lst))
  end
end
```

== Practical motivation

- Found a bug in our URL signer: you can tinker with query parameters in a signed URL and have the signature continue to be accepted as valid—very bad.

#pause

- Found a floating-point bug that no one-off test would have found.

#pause

- I could keep running this thing and find more bugs.

== Theoretical motivation

#domain-with-bug-region

== Theoretical motivation

- PBT generates _well formed_ random inputs.
#pause
- These could get large.
#pause
- PBT frameworks will attempt to _shrink_ the input to get to the smallest case they can find that violates the property.

== Using PBT with agents

- See agent description
- Agent makes nice bug reports

== Properties

#table(
    columns: (auto, auto),
    table.header([*Property type*], [*What to ask*]),
    [Round-trip], [Does a paired function undo this one?],
    [Identity], [Is there an input that should change nothing?],
    [Post-condition], [What predicate must every output satisfy?],
    [Ordering/Structural], [Does the output maintain size, order, or shape?],
    [Oracle], [Can I compare against a slower, correct reference?],
    [Totality], [Does it crash on empty, zero, or boundary inputs?],
)

== Exercises

```elixir
def fp_bad_day(x) do
  (x / 1000) * 1000 == x
end

def paddless_encode(str) do
  Base.encode64(str, padding: false)
end
```

== My solutions
```elixir
property "fp_bad_day is always true" do
  check all num1 <- float() do
    assert fp_bad_day(num1)
  end
end

property "encoding round-trip" do
  check all str <- binary(min_length: 12) do
    assert {:ok, ^str} = Base.decode64(paddless_encode(str))
  end
end
```

= PBT in Elixir

== Using ```elixir ExUnitProperties```

- Helps you make random data of _any_ shape.
    - Includes custom data types!
- Automatically will shrink the input data.
- Write `property` as part of your test suite; run with `mix test`.

#block[
#show raw: set text(size: 15pt)
```elixir
use ExUnitProperties
property "never raises on arbitrary binaries" do
  check all(str <- StreamData.string(:printable, max_length: 40)) do
    result = WindowSpec.parse(str)

    assert match?({:ok, %{start: _, end: _}}, result) or
             match?({:error, _}, result)
  end
end
```
]

#big-bullets(
    [Catches different bugs than plain testing],
    [Agents are good at writing PBTs],
    [Integrates with your existing test suite],
)
