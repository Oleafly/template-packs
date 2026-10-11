// #import "@preview/cs61c-examst:0.1.0": *
#import "../../src/lib.typ": *

= Potpourri

#part(points: 3)[
  Consider an 8-bit floating point format that follows the IEEE-754 standard, with 1 sign bit, 4 exponent bits (with a standard bias of -7), and 3 mantissa bits.

  What is the minimum distance between any two denormalized numbers in this floating point format? Express your answer as a power of 2.

  #answer-box()[3]
]

#part(points: 3)[
  Consider the following multi-threaded code block.
  ```py
  int32_t a = 0;
  int32_t b = 2;

  #pragma omp parallel {
    while (b > 0) {
      a = a + b;
      #pragma omp critical {
        b = b - 1;
      }
    }
  }
  ```

  If we run this code with two threads, what is the largest possible value of `a` after both threads finish execution?

  Note that the expression `a = a + b` is equivalent to four instructions: load the value of `a`, load the value of `b`, sum `a` and `b`, and then store the result in `a`.

  #answer-box()[3]
]

#part(points: 2)[
  Select all true statements about the manager-worker framework.

  #multi-select(
    cols: 1,
    rows: 4,
    none-above: auto,
    correct()[If one program crashes, the others keep going.],
    correct()[Programs communicate by sending messages between each other.],
    correct()[The manager-worker framework splits a problem into independent subtasks and tries to minimize communication between programs.],
    [The manager is able to assign a task to a worker before the worker is ready.],
  )
]
