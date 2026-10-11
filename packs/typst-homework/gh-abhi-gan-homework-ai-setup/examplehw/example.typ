#import "../template.typ": *
#show: homework.with(
  course: "course name",
  hw: 1,
  name: "Stan Ford",
  due: "01/01/2000",
)

#problem(title: "Example of a Proof")[
  Problem Description. ex: Prove that <>.

  #proof[
    proof body.

    Typst uses a latex-like syntax for math:
    $ norm(A)_p = max_(norm(x)_p=1) (A x) $

    You can display a vectors like
    // https://typst.app/docs/reference/math/vec/
    $
      vec(a, b, c) dot vec(1, 2, 3)
      = a + 2b + 3c
    $

    You can display matrices like
    // https://typst.app/docs/reference/math/mat/
    $
      mat(
        1, 2, dots, 10;
        2, 2, dots 10;
        dots.v, dots.v, dots.down, dots.v;
        10, 10, dots, 10;
      )
    $

  ]
]

#problem(title: "Example of an Incomplete Proof")[
  Problem Description. ex: Prove that <>.

  #proof[
    #wip()
    Proof that I haven't finished yet.
  ]
]
