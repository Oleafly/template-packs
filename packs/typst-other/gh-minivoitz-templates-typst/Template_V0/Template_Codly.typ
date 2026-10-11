= Template 2 : Codly
Inspired by codly Documentation : https://typst.app/universe/package/codly
#import "@preview/codly:1.3.0": *

#show: codly-init

#import "@preview/codly-languages:0.1.7": *
#codly(languages: codly-languages) // For logos but pretty

#v(1em)
#figure(kind: raw,
  caption: "Hello world in Rust"
)[```rust
fn main() {
println!("Hello, world!");
}
```]<label1>

#v(1em)
```zig
const std = @import("std");

pub fn main() void {
std.debug.print("Hello, world!", .{});
} 
```


#v(1em)

#block(
  width: 12cm,
  inset: (x: 10pt, y: 10pt),
)[
#figure(kind: raw,
  caption: "Hello world in Rust"
)[```rust
fn main() {
println!("Hello, world!");
}
```]<label2>

#v(1em)
```zig
const std = @import("std");

pub fn main() void {
std.debug.print("Hello, world!", .{});
} 
```
]

#v(1em)



== Fill 0x0x
#[
#codly(fill:rgb("#387086"))
```py
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')
```
#codly(fill:none)
]

#v(1em)
== Zebra Fill x0x0
#[
#codly( zebra-fill:
gradient.linear(..color.map.flare))
```py
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')

``` 
]

#v(1em)
== Custom fill xxxx
https://typst.app/docs/reference/visualize/color/ for color ref
#[
#codly(fill:	rgb("#ff35b8"))
#codly( zebra-fill:rgb("#ffffff"))
```py
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')
print('Hello, world!')

``` 
]

#v(1em)
== Number placement
#block(
  width: 12cm,
  inset: (x: 10pt, y: 10pt),
)[
#codly(fill:	rgb("#7be866"),zebra-fill: rgb("#7be866"))


#codly(number-placement: "outside")
```py
print('Hello, world!')
print('Hello, world!')
```  

#codly(number-placement: "inside")
```py
print('Hello, world!')
print('Hello, world!')
``` 
#codly(zebra-fill: none, fill:none)

]
#v(1em)
== skip number
#block(
  width: 8cm,
  inset: (x: 10pt, y: 10pt),
)[
#codly(skips: ((4, 32), ))
```py
print('Hello, world!')
  print('Hello, world!')
      print('Hello, world!')
print('Hello, world!')
```
]


== Annotation

#block(
  width: 8cm,
  inset: (x: 10pt, y: 10pt),
)[
  #codly(
annotations: (
(
start: 2 , end: 5,
content: block(
width: 4em,
rotate(-90deg, reflow: true,
align(center)[Function body])
)
 ),
 ),
 )

```py
def fib(n):
  if n <= 1:
    return n
  else:
    return fib(n - 1) + fib(n - 2)
fib(25)
```
]
== Higlights
#block(
  width: 8cm,
  inset: (x: 10pt, y: 10pt),
)[
 #codly(highlights: (
 (line: 4, start: 2, end: none, fill:
yellow),
 (line: 5, start: 11, end: 20, fill:
green, tag: "  (a)  "),
 (line: 5, start: 27, fill: blue, tag:
"  (b)  "),))
```py
def fib(n):
if n <= 1:
   return n
 else:
   return fib(n - 1) + fib(n - 2)
fib(25)
```
]