#import "/template/lib.typ": *

#show: assignment.with(
  title: "Hello World in C",
  number: "Assignment 01",
  kind: "Lab",
)

= Aim

Write and explain a C program that prints a greeting.

= Program

The full source, with syntax highlighting and line numbers:

#code(read("hello.c"), file: "hello.c")

= Explanation

The loop that does the work is lines 6 to 8:

#code(read("hello.c"), file: "hello.c", lines: (6, 8))

Line 5 declares the name, and #raw("printf") on line 7 writes each greeting to
standard output.

= Output

```text
Hello, World! (0)
Hello, World! (1)
Hello, World! (2)
```
