#import "classnotes.typ": *

#show: classnote.with(
  title: "Arrays and Functions",
  subtitle: "Discussing Arrays and Functions through Code Snippets and Outcome-Based Education (OBE) Framework",
  faculty: "Dr. A. Sharma",
  program: "B.Tech Computer Science & Engineering",
  semester: 2,
  dept_short: "CSE",
  dept: "Computer Science & Engineering",
  subject: "Programming for Problem Solving",
  code: "ESCS201",
  academic_year: "2026-2027",
  date: "August 3, 2026",
  accent: rgb("#1e3a8a"),
  font_style: "sans", // Options: "sans" or "serif"
)

= Outcome-Based Education (OBE) Framework

== 1. Course Outcomes (COs)

#course-outcomes(
  title: "Course Outcomes for Module 2: Arrays & Memory Management",
  cos: (
    (
      code: "CO1",
      desc: "Understand foundational concepts of linear data structures and contiguous memory allocation in C/C++.",
      bloom: "L2 - Understand",
      po: "PO1"
    ),
    (
      code: "CO2",
      desc: "Apply pointer arithmetic and dynamic memory allocation routines (malloc/free) to manage memory efficiently.",
      bloom: "L3 - Apply",
      po: "PO2"
    ),
    (
      code: "CO3",
      desc: "Analyze and compare time and space complexities of array manipulation algorithms (Search & Insertion).",
      bloom: "L4 - Analyze",
      po: "PO3"
    ),
    (
      code: "CO4",
      desc: "Design and implement modular functions handling single and multi-dimensional array operations.",
      bloom: "L6 - Create",
      po: "PO4"
    ),
  )
)

== 2. CO-PO Articulation Matrix

#co-po-matrix(
  cos: ("CO1", "CO2", "CO3", "CO4"),
  pos: ("PO1", "PO2", "PO3", "PO4", "PO5", "PO6"),
  mapping: (
    (3, 2, 1, "-", "-", "-"),
    (3, 3, 2, 1, "-", "-"),
    (2, 3, 3, 2, 1, "-"),
    (2, 2, 3, 3, 2, 1),
  )
)

== 3. Cognitive Domain Reference

#bloom-legend()

= 1. Introduction to Arrays #obe-tag(co: "CO1", bloom: "L2")

An *array* is a contiguous collection of elements of the same data type stored sequentially in memory. Arrays allow constant-time $O(1)$ index-based random access.

#definition(term: "Array")[
  An array is a fixed-size, homogeneous data structure that stores elements in contiguous memory locations.
]

#callout(type: "tip", title: "Best Practice")[
  Always ensure that array access stays within bounds `[0, size - 1]` to avoid undefined behavior or segmentation faults in languages like C/C++.
]

#keypoint[
  Array indices start at `0` in zero-indexed languages. The address of element `arr[i]` is computed as:
  $ text("Address")("arr"[i]) = text("Base Address") + i times text("sizeof")(text("element")) $
]

== Code Example: Dynamic vs Static Allocation #obe-tag(co: "CO2", bloom: "L3")

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int n = 5;
    // Dynamic memory allocation for array
    int *arr = (int *)malloc(n * sizeof(int));
    if (arr == NULL) return 1;

    for (int i = 0; i < n; i++) {
        arr[i] = (i + 1) * 10;
        printf("arr[%d] = %d\n", i, arr[i]);
    }

    free(arr);
    return 0;
}
```

= 2. Time Complexity & Theoretical Foundations #obe-tag(co: "CO3", bloom: "L4")

#theorem(title: "Time Complexity of Linear Search")[
  Given an un-ordered array of size $N$, searching for a target element using Linear Search requires $O(N)$ comparisons in the worst case.
]

#proof[
  In the worst-case scenario, the target element is located at the last index $N-1$ or is not present in the array at all. The algorithm must inspect every element from index $0$ up to $N-1$, performing exactly $N$ comparisons. Thus, the time complexity is $cal(O)(N)$.
]

#corollary(title: "Sorted Array Search")[
  If the array is sorted, Binary Search reduces the search time complexity to $cal(O)(log N)$.
]

#example(title: "Array Access Efficiency")[
  Consider a 1D array `int arr[1000]`. Accessing `arr[42]` takes $cal(O)(1)$ time because the memory address is calculated directly via pointer arithmetic.
]

= 3. Summary Comparison

#table(
  columns: (1.5fr, 1fr, 1fr, 2fr),
  [Operation], [Static Array], [Dynamic Array], [Notes],
  [Index Access], [$O(1)$], [$O(1)$], [Direct pointer offset calculation],
  [Insertion at End], [$O(1)^*$], [$O(1)$ amortized], [Requires space check for static],
  [Search (Unsorted)], [$O(N)$], [$O(N)$], [Requires full linear scan],
  [Search (Sorted)], [$O(log N)$], [$O(log N)$], [Binary search algorithm]
)

#callout(type: "warning", title: "Memory Allocation Note")[
  Un-freed dynamic allocations result in memory leaks. Always pair `malloc()` / `calloc()` with `free()`.
]

#todo("Add section on multi-dimensional array mapping functions in column-major vs row-major order.")

= 4. OBE Practice Questions & Assessments

#question(
  [What is the primary advantage of arrays over linked lists regarding memory locality?],
  answer: [Arrays store elements in contiguous memory locations, which maximizes CPU cache hit ratios due to spatial locality of reference.],
  co: "CO1",
  bloom: "L2 - Understand",
  po: "PO1",
  points: 5
)

#question(
  [Explain why passing a large array to a function in C by value is inefficient.],
  answer: [Passing by value copies the entire array contents onto the call stack, causing $O(N)$ memory copy overhead. Passing by reference (pointer) passes only the 8-byte memory address.],
  co: "CO2",
  bloom: "L3 - Apply",
  po: "PO2",
  points: 5
)

#obe-question(
  [Write a modular C function `reverseArray(int *arr, int size)` to reverse an array in-place without using auxiliary memory, and trace its performance on an array of size $N=6$.],
  co: "CO4",
  bloom: "L6 - Create",
  po: "PO4",
  points: 10,
  rubric: [
    - *Correct Function Signature & In-Place Swap Logic:* 5 Marks
    - *Pointer / Index Boundary Checks:* 3 Marks
    - *Execution Trace on N=6 Example:* 2 Marks
  ],
  answer: [
    ```c
    void reverseArray(int *arr, int size) {
        int start = 0, end = size - 1;
        while (start < end) {
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++; end--;
        }
    }
    ```
  ]
)

== Quick Self-Check Q&A

#qna(items: (
  (
    question: "What is the time complexity of inserting an element at the beginning of an array?",
    answer: "O(N) because all existing elements must be shifted one index to the right."
  ),
  (
    question: "What does `sizeof(arr) / sizeof(arr[0])` evaluate to for a statically allocated array?",
    answer: "It evaluates to the total number of elements in the static array."
  )
))

= 5. OBE Outcome Coverage Summary

#obe-summary(
  items: (
    (co: "CO1", desc: "Understand contiguous memory & data structure basics", bloom: "L2", questions: 1, marks: 5),
    (co: "CO2", desc: "Apply dynamic memory allocation & pointer routines", bloom: "L3", questions: 1, marks: 5),
    (co: "CO3", desc: "Analyze searching algorithms and runtime complexity", bloom: "L4", questions: 1, marks: 0),
    (co: "CO4", desc: "Design & implement in-place modular array routines", bloom: "L6", questions: 1, marks: 10),
  )
)