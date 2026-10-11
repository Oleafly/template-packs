= A main chapter <chap-firstchap>

#import "../src/lib.typ": algorithm, algorithm-line, corollary, definition, lemma, note, observation, proof, proofof, proposition, theorem

== Introduction

You might have a per-chapter mini-intro, possibly tying in to the relevant part
of the general intro.

== A section

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut purus elit,
vestibulum ut, placerat ac, adipiscing vitae, felis. Curabitur dictum gravida
mauris. Nam arcu libero, nonummy eget, consectetuer id, vulputate a, magna.
Donec vehicula augue eu neque. Pellentesque habitant morbi tristique senectus et
netus et malesuada fames ac turpis egestas. Mauris ut leo. Cras viverra metus
rhoncus sem. Nulla et lectus vestibulum urna fringilla ultrices. Phasellus eu
tellus sit amet tortor gravida placerat. Integer sapien est, iaculis in, pretium
quis, viverra ac, nunc. Praesent eget sem vel leo ultrices bibendum. Aenean
faucibus. Morbi dolor nulla, malesuada eu, pulvinar at, mollis ac, nulla.
Curabitur auctor semper nulla. Donec varius orci eget risus. Duis nibh mi,
congue eu, accumsan eleifend, sagittis quis, diam. Duis eget orci sit amet orci
dignissim rutrum.

Let's cite a source: @Yao1977. And now, let's introduce a numbered equation. It
will use the symbol c, which is one of the entries in the "Notation and
Abbreviations" list. The equation will be in display math mode, using Typst's
math block syntax.

$ e = m c^2 $ <eq-emc2>

#note(title: [Notes])[
  Are you seeing a problem with the equation numbering? In mixed Hebrew and
  English documents, bidirectional layout can occasionally expose issues in
  numbering or punctuation. Please make sure you are using an up-to-date Typst
  version and compiling with the repository's font path. Recent Typst versions
  handle the numbering shown here correctly. If you still see odd ordering in a
  local PDF viewer, first rebuild the document from scratch, then check that the
  Hebrew segment is compiled with `text(lang: "he", dir: rtl)` and that the
  English segment keeps its left-to-right defaults. It is also worth verifying
  the final assembled PDF rather than only the intermediate segment PDFs, since
  the Hebrew pages are reversed during the build step.
]

Alternatively, we can use a displayed equation with a label:

$ f(x) = sum_(i=0)^infinity a_i x^i $ <eq-power-series>

Equation @eq-power-series is a typical power series.

Typst labels are attached directly to the equation, figure, heading, or other
element they follow. A later reference such as @eq-power-series therefore stays
valid even if you move this paragraph, insert a figure, or split the chapter
into another source file. For a thesis-sized project this is usually easier to
maintain than hand-written numbers: the template controls the numbering format,
while the chapter text only names the labeled item.

In @sec-thm-like below, we will state some theorems.

== Results... and theorem-like environments <sec-thm-like>

What's so special about the theorem-like environments used here? There are
several reusable helpers in this Typst template for defining them consistently.
They provide theorem, lemma, corollary, proposition, definition, note,
observation, and proof blocks with the same visual style as the original sample:
bold labels for theorem-like statements, italic labels for notes and proofs,
chapter-level theorem/corollary numbering, and section-level numbering for
definitions, lemmata, propositions, and observations. The helpers in
`src/lib.typ` are intentionally small Typst functions, so you can copy one,
adjust its name or counter, and keep the result local to your thesis without
taking on a large package dependency. In Typst, the main practical questions are
how to share counters between related helpers and how to keep references stable
after text moves around. This template handles the demonstrated cases with
ordinary counters and figure references: theorem and corollary share one
chapter-level counter, while definition, lemma, proposition, and observation
share a section-level counter. That gives the same reader-facing result as the
LaTeX sample while keeping the implementation easy to audit.

Another important difference is that Typst does not need a separate theorem
package to get this appearance. The template functions emit ordinary content,
step the relevant counter at the point where the statement is placed, and then
format the label from the current chapter or section number. That keeps the
source compact while still making the resulting PDF look like the Technion
LaTeX example. If you want a richer theorem system later, you can replace these
helpers with a package or a more elaborate local module, but the visible
contract should remain the same: concise labels, predictable counters, and
readable statements that do not look like boxed callouts.

This section deliberately keeps the source calls short. A statement such as
`#theorem[...]` should read like part of the mathematical prose, while the
template decides how the label is numbered and whether the body is italic or
roman. That is also useful in a bilingual thesis: the page direction and font
choices can change around the content, while the statement helpers keep the
same semantic role throughout the project.

#theorem[
  This is the first numbered theorem in this thesis.
] <thm-first>

And we can refer to it using Typst references in ordinary text: Theorem 3.1, or
write the surrounding word yourself when you need a specific capitalization.

#corollary[
  There are no lemmata appearing before theorems in this thesis.
] <cor-first>

#theorem(numbered: false)[
  This is the second theorem, unnumbered.
]

#theorem(numbered: false, title: [(@Knuth1973[Theorem 2])])[
  This is an unnumbered theorem cited from elsewhere. The quick brown fox jumps
  over the lazy dog... and it was Knuth's dog.
]

#note[
  This is a note environment. The quick brown fox jumps over the lazy dog. The
  quick brown fox jumps over the lazy dog.
]

#definition[
  A _quick brown fox_ is a fox which is not only fast and agile but is also
  characterized by brown fur. Such foxes sometimes tend to jump over lazy dogs.
]

#lemma[
  This is a lemma. The quick brown fox jumps over the lazy dog. The quick brown
  fox jumps over the lazy dog.
]

Even though Lemma 3.3.2 and Definition 3.3.1 share the same counter, when
referring to them, their names are used explicitly.

Here's a proof of the lemma:

#proof[
  Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi
  auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae,
  ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula
  aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit
  mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis
  natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
  Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque
  cursus luctus mauris. It's common to conclude proofs with a QED symbol -- typically a full or an
  empty black square. In this Typst template the proof helper appends it for
  you. You will see the result as a black square at the end of this proof
  environment.
]

Now here's a proof of Theorem 3.1 using the `proofof` environment.

#proofof([Theorem 3.1])[
  Nulla malesuada porttitor diam. Donec felis erat, congue non, volutpat at,
  tincidunt tristique, libero. Vivamus viverra fermentum felis. Donec nonummy
  pellentesque ante. Phasellus adipiscing semper elit. Proin fermentum massa ac
  quam. Sed diam turpis, molestie vitae, placerat a, molestie nec, leo. Maecenas
  lacinia. Nam ipsum ligula, eleifend at, accumsan nec, suscipit a, ipsum. Morbi
  blandit ligula feugiat magna. Nunc eleifend consequat lorem. Sed lacinia nulla
  vitae enim. Pellentesque tincidunt purus vel magna. Integer non enim. Praesent
  euismod nunc eu purus. Donec bibendum quam in tellus. Nullam cursus pulvinar
  lectus. Donec et mi. Nam vulputate metus eu enim. Vestibulum pellentesque felis
  eu massa.
]

#note[
  If you customize proof blocks, check proofs ending with display math and make
  sure the QED symbol still appears where you expect it.
]

#proposition[
  This is a proposition environment. The quick brown fox jumps over the lazy dog.
  The quick brown fox jumps over the lazy dog.
] <prop-first>

#observation[
  The moon revolves around the earth.
] <obs-first>

There are several other theorem-like helpers, of various kinds, imported from
`src/lib.typ`; and naturally you can add or modify these as you see fit.
For example, you may want proof sketches, examples, exercises, claims, or
remarks to be styled like the blocks above but numbered separately. In Typst,
the usual approach is to keep the visual wrapper as a function and feed it the
body of the statement. That keeps the chapter source readable while giving you
full control over the text that appears in references and captions. If a future
version of this template grows a richer theorem module, the same chapter text
can continue to call small helpers rather than expose the layout machinery
inline.
When you adapt these helpers, try to keep the user-facing source close to the
mathematical text: a short call such as `#lemma[...]` is easier to scan than a
long styled block repeated throughout the chapter. Put numbering,
font choices, spacing, and QED behavior in the template, then keep each chapter
focused on statements and proofs. This also makes it easier to compare the
English and Hebrew parts of the thesis, since the same helper can be used in
both directions while the page setup controls the surrounding writing direction
and binding side.

#pagebreak()

=== A subsection

We've started a subsection. Here is a reference to another chapter: @chap-prelims
-- realized with Typst's reference syntax. You can write the surrounding word
yourself when you need a specific capitalization or phrasing.

#algorithm(caption: [A nice algorithm])[
  #algorithm-line(1)[#strong[for] $n$ times #strong[do]]
  #algorithm-line(2)[Do something.]
  #algorithm-line(3)[Do something else.]
  #algorithm-line(4)[#strong[end for]]
  #algorithm-line(5)[And do one last thing.]
] <alg-first>

For algorithms like @alg-first, this Typst template provides a small algorithm
helper so the caption, numbering, and body style match the rest of the thesis.
If your algorithm needs richer pseudocode, you can still keep it inside the same
floating algorithm wrapper.

=== A second subsection

In this subsection we'll have a figure. Remember that Typst can place figures a
little before or after where they are defined, according to the placement choice
and depending on the flow of the rest of the text.
In the sample project, image assets live under `graphics/`, and the figure call
uses the PDF version of the drawing directly.

#figure(
  image("../graphics/mygraphic1.pdf"),
  caption: [Two circles and a wavy line.],
)

Let's also have, to conclude this subsection, another use of a term from
"Notation and Abbreviations", which we first used earlier in @chap-prelims.
Here it is: DIY. This will ensure it appears on multiple pages; but its entry
will only mention the first appearance, not this one.
