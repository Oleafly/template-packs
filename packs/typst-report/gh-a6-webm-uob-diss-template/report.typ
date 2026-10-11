#import "lib.typ": uob

#show: uob.with(
  author: "Amin Donald",
  degree: "MEng",
  title: [Huh Whuh],
  unit: "COMS30045",
  subtitle: [And even a fancy subtitle],
)

= Abstract

This section should give an overview of the project context, aims and
objectives, and main contributions (e.g., deliverables) and achievements.  The
goal is to ensure the reader is clear about what the topic is, what you have
done within this topic, _and_ what your view of the outcome is.

The former aspects should be guided by your specification: essentially 
this section is a (very) short version of what is typically the first 
chapter. If your project is experimental in nature, this should include 
a clear research hypothesis.  This will obviously differ significantly
for each project, but an example might be as follows:

#quote()[
  My research hypothesis is that a suitable genetic algorithm will yield
  more accurate results (when applied to the standard ACME data set) than 
  the algorithm proposed by Jones and Smith, while also executing in less
  time.
]

The latter aspects should (ideally) be presented as a concise, factual 
bullet point list.  Again the points will differ for each project, but 
an might be as follows:


#quote()[
- I spent $120$ hours collecting material on and learning about the 
  Java garbage-collection sub-system. 
- I wrote a total of $5000$ lines of source code, comprising a Linux 
  device driver for a robot (in C) and a GUI (in Java) that is 
  used to control it.
- I designed a new algorithm for computing the non-linear mapping 
  from A-space to B-space using a genetic algorithm, see page $17$.
- I implemented a version of the algorithm proposed by Jones and 
  Smith in [6], see page $12$, corrected a mistake in it, and 
  compared the results with several alternatives.
]

#set page(
  footer: context [
    #line(length: 100%)
    #v(1pt)
    #align(center)[
      #counter(page).display("1")
    ]
  ],
)
#counter(page).update(1)

test
