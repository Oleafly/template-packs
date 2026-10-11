#import "rtthesis.typ": *

// PDF document metadata
#set document(
  title: "Investigations of a Problem",
  author: "Lisa Student",
  date: datetime.today(),
)

#show: rtthesis.with(
  title: [Investigations of a Problem],
  // subtitle: [An interesting subtitle], // optional
  issn: [`LiTH-ISY-EX--YY/NNNN--SE`],
  authors: ("Lisa Student",), // more authors possible
  supervisors: (
    ("Doktorand Si", isy),
    ("Ingenjör Så", "Company"),
  ),
  examiner: ("Lena Lärare", isy),
  acknowledgements: [
    Vi tycker alla har varit så himla goa hela den här långa och tuffa tiden i
    våra liv.
    #align(end)[_Linköping, månad år#linebreak()Författaren_]
  ],
  liu-logo: image("figures/liu/primary-black.svg", width: 72mm),
  font: (
    serif: "KpRoman",
    sans: "Liberation Sans",
  ),
  s5-on-a4: false,
)

#heading(numbering: none)[Notation]

Some terms and definitions

= Introduction

Typst@madje2022typst!

#figure(image("figures/liu/primary-black.svg", width: 3cm), caption: [LiU logotype.])

Inline math: $1 + 1 = 2$.

Block-level math:

$
  integral_0^1 e^x med upright(d)x = med ?
$

#figure(
  table(
    columns: 2,
    [1], [0],
    [0], [1],
  ),
  caption: [Small table.],
)

== Aims and goals

And aims and goals.

#lorem(400)

== Research questions

== Delimitations

= Background

Optional. Used if the introduction becomes too long without it.

#figure(
  caption: [Some totally reasonable C++ code.],
  rect([
    ```cpp
    template <unsigned N>
    struct Fibonacci {
      static const unsigned value{
        Fibonacci<N-1>::value + Fibonacci<N-2>::value
      };
    };

    template <>
    struct Fibonacci<0> {
      static const unsigned value{0};
    };

    template <>
    struct Fibonacci<1> {
      static const unsigned value{1};
    };

    ```
  ]),
)

= Related works

Alternative chapter names possible. Ask the supervisor/examiner.

= Method

(Or as part of introduction)

= Results

As factual and objective as possible.

= Discussion

(Or as part of conclusion)

Refer to relevant sources.

== Results

== Method

== In a wider context

Ethical and societal aspects.

= Conclusions

(Or as part of discussion)

@app1

Conclusions to the research questions. Possibly, future work.

#bibliography(style: "ieee", "references.bib")

#show: appendix

= First appendix <app1>

The first appendix.

== Subheading
