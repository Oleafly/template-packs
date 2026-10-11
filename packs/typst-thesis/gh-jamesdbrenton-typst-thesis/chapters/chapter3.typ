= My third chapter

== First section of the third chapter

And now I begin my third chapter here ...

And now to cite some more people @Rea85 @Ancey1996.

=== First subsection in the first section

... and some more.

=== Second subsection in the first section

... and some more ...

==== First subsub section in the second subsection

... and some more in the first subsub section.

== The layout of formal tables

This section has been adapted from "Publication quality tables", by Simon
Fear.

The layout of a table has been established over centuries of experience and
should only be altered in extraordinary circumstances.

+ Never, ever use vertical rules (lines).
+ Never use double rules.

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(),
    table.header([], [*Case 1*], [*Case 2*], [*Case 3*]),
    table.hline(),
    [Alpha], [12.3], [45.6], [78.9],
    [Beta], [1.23], [4.56], [7.89],
    [Gamma], [0.12], [0.34], [0.56],
    table.hline(),
  ),
  caption: [A simple, rule-light table in the spirit of Simon Fear's
    "Publication quality tables in LaTeX".],
)
