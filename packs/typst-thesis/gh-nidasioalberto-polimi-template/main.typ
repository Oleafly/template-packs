#import "src/lib.typ": *
#show: polimi_thesis

//-----------------------------------------------------------------------------
// Acronyms
//-----------------------------------------------------------------------------

#import "@preview/glossarium:0.5.8": *
#let acronyms_list = (
  (
    key: "DEIB",
    long: "Department of Electronics, Information and Bioengineering",
  ),
)
#show: make-glossary
#register-glossary(acronyms_list)

//-----------------------------------------------------------------------------
// Front matter
//-----------------------------------------------------------------------------

#show: start_front_matter

= Abstract

Here goes the Abstract in English of your thesis followed by a list of keywords. The Abstract is a concise summary of the content of the thesis (single page of text) and a guide to the most important contributions included in your thesis. The Abstract is the very last thing you write. It should be a self-contained text and should be clear to someone who hasn't (yet) read the whole manuscript. The Abstract should contain the answers to the main scientific questions that have been addressed in your thesis. It needs to summarize the adopted motivations and the adopted methodological approach as well as the findings of your work and their relevance and impact. The Abstract is the part appearing in the record of your thesis inside POLITesi, the Digital Archive of PhD and Master Theses (Laurea Magistrale) of Politecnico di Milano. The Abstract will be followed by a list of four to six keywords. Keywords are a tool to help indexers and search engines to find relevant documents. To be relevant and effective, keywords must be chosen carefully. They should represent the content of your work and be specific to your field or sub-field. Keywords may be a single word or two to four words.

*Keywords*: Here the keywords of your thesis

= Sommario

Qui va l'Abstract in lingua italiana della tesi seguito dalla lista di parole chiave.

*Parole chiave*: Qui le parole chiave della tesi

#polimi_outline()

//-----------------------------------------------------------------------------
// Chapters
//-----------------------------------------------------------------------------

#show: start_chapters

= Introduction

This document is intended to be both an example of the Polimi \LaTeX{} template for Master Theses, as well as a short introduction to its use. It is not intended to be a general introduction to \LaTeX{} itself, and the reader is assumed to be familiar with the basics of creating and compiling \LaTeX{} documents (see \cite{oetiker1995not, kottwitz2015latex}).

The cover page of the thesis must contain all the relevant information: title of the thesis, name of the Study Programme and School, name of the author, student ID number, name of the supervisor, name(s) of the co-supervisor(s) (if any), academic year. The above information are provided by filling all the entries in the command \verb|\puttitle{}| in the title page section of this template.

Be sure to select a title that is meaningful. It should contain important keywords to be identified by indexer. Keep the title as concise as possible and comprehensible even to people who are not experts in your field. The title has to be chosen at the end of your work so that it accurately captures the main subject of the manuscript.

Since a thesis might be a substantial document, it is convenient to break it into chapters. You can create a new chapter as done in this template by simply using the following command followed by the body text.

```typc
= Title of the chapter
```

Especially for long manuscripts, it is recommended to give each chapter its own file. In this case, you write your chapter in a separated `chapter_n.typ` file and then include it in the main file with the following command

```typc
#include "chapter_n.typ"
```

It is recommended to give a label to each chapter by using the command

```typc
= Title of the chapter <chapter_name>
```
where the argument is just a text string that you'll use to reference that part as follows: Chapter @chapter_one contains #upper[an introduction to] ....

// If necessary, an unnumbered chapter can be created by

// ```
// \chapter*{Title of the unnumbered chapter}
// ```

// TODO: Apply this automatically, ensuring that every heading of lvl 1 starts at a new page
#pagebreak()

#doc_state.update("chapters")
#counter(heading).update(0)

= Chapter One <chapter_one>

In this chapter additional useful information are reported.

== Sections and subsections <section_name>

Chapters are typically subdivided into sections and subsections, and, optionally, subsubsections, paragraphs and subparagraphs. All can have a title, but only sections and subsections are numbered. A new section is created by the command

```typc
== Title of the section
```

Sections can be nested easily by using multiple `=`.

```typc
=== Title of the subsection
```

== Equations <eqs>

This section gives some examples of writing mathematical equations in your thesis.

Maxwell's equations read:
$
  cases(
                                      nabla dot bold(D) & = rho \
    nabla times bold(E) + (partial bold(B))/(partial t) & = bold(0) \
                                      nabla dot bold(B) & = 0 \
    nabla times bold(H) - (partial bold(D))/(partial t) & = bold(J)
  )
$ <maxwell>

@maxwell is automatically labeled. Remember that Equations have to be numbered only if they are referenced in the text.

@maxwell_multilabels show again Maxwell's equations without brace:

$
                                    nabla dot bold(D) & = rho \
  nabla times bold(E) + (partial bold(B))/(partial t) & = bold(0) \
                                    nabla dot bold(B) & = 0 \
  nabla times bold(H) - (partial bold(D))/(partial t) & = bold(J)
$ <maxwell_multilabels>

== Figures, Tables and Algorithms

Figures, tables and algorithms have to contain a caption that describe their content, and have to be properly reffered in the text.

=== Fugures

For including pictures in your text you can use \texttt{TikZ} for high-quality hand-made figures, or just include them as usual with the command

```typc
#image("filename.xxx")
```

Supported formats are `png`, `jpg`, `gif` and `svg`.

#align(center, figure(
  block(inset: 1cm, image(width: 25%, "images/logo.svg")),
  caption: [Caption of the Figure to appear in the List fo Figures.],
)) <quadtree>

// Thanks to the \texttt{\textbackslash subfloat} command, a single figure, such as Figure~\ref{fig:quadtree}, can contain multiple sub-figures with their own caption and label, e.g. \color{black} Figure~\ref{fig:polimi_logo1} and Figure~\ref{fig:polimi_logo2}.

#figure(
  grid(
    columns: (50%, 50%),
    align: bottom,
    [#figure(
      image(height: 3.5cm, "images/logo.svg"),
      caption: [One PoliMi logo.],
    ) <polimi_logo>],
    [#figure(
      image(height: 2.05cm, "images/logo_2.svg"),
      caption: [Another PoliMi logo.],
    ) <polimi_logo_2>],
  ),
  caption: [This is a very long caption you don't want to appear in the List of Figures.],
) <quad_tree_2>

=== Tables

Within `#table` you can create very fancy tables as the one shown in @table_example.

#figure(
  [
    #text(weight: "bold")[Title of Table (optional)],
    #table(
      columns: 4,
      stroke: 0.25pt,
      fill: (_, y) => if y == 0 { blue_poli.lighten(60%) } else { none },
      table.header([], [*column 1*], [*column 2*], [*column 3*]),
      [*row 1*], [1], [2], [3],
      [*row 2*], [$alpha$], [$beta$], [$gamma$],
      [*row 3*], [alpha], [beta], [gamma],
    )
  ],
  caption: [Caption of the Table to appear in the List of Tables.],
) <table_example>

// You can also consider to highlight selected columns or rows in order to make tables more readable. Moreover, with the use of \texttt{table*} and the option \texttt{bp} it is possible to align them at the bottom of the page. One example is presented in Table~\ref{table:exampleC}.

// \begin{table}[H]
// \centering
//     \begin{tabular}{|p{3em} | c | c | c | c | c | c|}
//     \hline
// %    \rowcolor{bluepoli!40}
//      & \textbf{column1} & \textbf{column2} & \textbf{column3} & \textbf{column4} & \textbf{column5} & \textbf{column6} \T\B \\
//     \hline \hline
//     \textbf{row1} & 1 & 2 & 3 & 4 & 5 & 6 \T\B\\
//     \textbf{row2} & a & b & c & d & e & f \T\B\\
//     \textbf{row3} & $\alpha$ & $\beta$ & $\gamma$ & $\delta$ & $\phi$ & $\omega$ \T\B\\
//     \textbf{row4} & alpha & beta & gamma & delta & phi & omega \B\\
//     \hline
//     \end{tabular}
//     \\[10pt]
//     \caption{Highlighting the columns}
//     \label{table:exampleC}
// \end{table}

// \begin{table}[H]
// \centering
//     \begin{tabular}{|p{3em} c c c c c c|}
//     \hline
// %    \rowcolor{bluepoli!40}
//      & \textbf{column1} & \textbf{column2} & \textbf{column3} & \textbf{column4} & \textbf{column5} & \textbf{column6} \T\B \\
//     \hline \hline
//     \textbf{row1} & 1 & 2 & 3 & 4 & 5 & 6 \T\B\\
//     \hline
//     \textbf{row2} & a & b & c & d & e & f \T\B\\
//     \hline
//     \textbf{row3} & $\alpha$ & $\beta$ & $\gamma$ & $\delta$ & $\phi$ & $\omega$ \T\B\\
//     \hline
//     \textbf{row4} & alpha & beta & gamma & delta & phi & omega \B\\
//     \hline
//     \end{tabular}
//     \\[10pt]
//     \caption{Highlighting the rows}
//     \label{table:exampleR}
// \end{table}

// \subsection{Algorithms}
// \label{subsec:algorithms}

// Pseudo-algorithms can be written in \LaTeX{} with the \texttt{algorithm} and \texttt{algorithmic} packages.
// An example is shown in Algorithm~\ref{alg:var}.
// \begin{algorithm}[H]
//     \label{alg:example}
//     \caption{Name of the Algorithm}
//     \label{alg:var}
//     \label{protocol1}
//     \begin{algorithmic}[1]
//     \STATE Initial instructions
//     \FOR{$for-condition$}
//     \STATE{Some instructions}
//     \IF{$if-condition$}
//     \STATE{Some other instructions}
//     \ENDIF
//     \ENDFOR
//     \WHILE{$while-condition$}
//     \STATE{Some further instructions}
//     \ENDWHILE
//     \STATE Final instructions
//     \end{algorithmic}
// \end{algorithm}

// \vspace{5mm}

// == Theorems, propositions and lists}

// \subsection{Theorems}
// Theorems have to be formatted as:
// \begin{theorem}
// \label{a_theorem}
// Write here your theorem.
// \end{theorem}
// \textit{Proof.} If useful you can report here the proof.

// \subsection{Propositions}
// Propositions have to be formatted as:
// \begin{proposition}
// Write here your proposition.
// \end{proposition}

// \subsection{Lists}
// How to  insert itemized lists:
// \begin{itemize}
//     \item first item;
//     \item second item.
// \end{itemize}
// How to insert numbered lists:
// \begin{enumerate}
//     \item first item;
//     \item second item.
// \end{enumerate}

// == Use of copyrighted material}

// Each student is responsible for obtaining copyright permissions, if necessary, to include published material in the thesis.
// This applies typically to third-party material published by someone else.

// == Plagiarism}

// You have to be sure to respect the rules on Copyright and avoid an involuntary plagiarism.
// It is allowed to take other persons' ideas only if the author and his original work are clearly mentioned.
// As stated in the Code of Ethics and Conduct, Politecnico di Milano \textit{promotes the integrity of research,
// condemns manipulation and the infringement of intellectual property}, and gives opportunity to all those
// who carry out research activities to have an adequate training on ethical conduct and integrity while doing research.
// To be sure to respect the copyright rules, read the guides on Copyright legislation and citation styles available
// at:
// ```
// https://www.biblio.polimi.it/en/tools/courses-and-tutorials
// ```
// You can also attend the courses which are periodically organized on "Bibliographic citations and bibliography management".

// == Bibliography and citations}
// Your thesis must contain a suitable Bibliography which lists all the sources consulted on developing the work.
// The list of references is placed at the end of the manuscript after the chapter containing the conclusions.
// We suggest to use the BibTeX package and save the bibliographic references  in the file \verb|Thesis_bibliography.bib|.
// This is indeed a database containing all the information about the references. To cite in your manuscript, use the \verb|\cite{}| command as follows:
// \\
// \textit{Here is how you cite bibliography entries: \cite{knuth74}, or multiple ones at once: \cite{knuth92,lamport94}}.
// \\
// The bibliography and list of references are generated automatically by running BibTeX \cite{bibtex}.

// \chapter{Conclusions and future developments}
// \label{ch:conclusions}%
// A final chapter containing the main conclusions of your research/study
// and possible future developments of your work have to be inserted in this chapter.

// %-------------------------------------------------------------------------
// %	BIBLIOGRAPHY
// %-------------------------------------------------------------------------

// \addtocontents{toc}{\vspace{2em}} % Add a gap in the Contents, for aesthetics
// \bibliography{Thesis_bibliography} % The references information are stored in the file named "Thesis_bibliography.bib"

// %-------------------------------------------------------------------------
// %	APPENDICES
// %-------------------------------------------------------------------------

// \cleardoublepage
// \addtocontents{toc}{\vspace{2em}} % Add a gap in the Contents, for aesthetics
// \appendix
// \chapter{Appendix A}
// If you need to include an appendix to support the research in your thesis, you can place it at the end of the manuscript.
// An appendix contains supplementary material (figures, tables, data, codes, mathematical proofs, surveys, \dots)
// which supplement the main results contained in the previous chapters.

// \chapter{Appendix B}
// It may be necessary to include another appendix to better organize the presentation of supplementary material.


// % LIST OF FIGURES
// \listoffigures

// % LIST OF TABLES
// \listoftables

// % LIST OF SYMBOLS
// % Write out the List of Symbols in this page
// \chapter*{List of Symbols} % You have to include a chapter for your list of symbols (
// \begin{table}[H]
//     \centering
//     \begin{tabular}{lll}
//         \textbf{Variable} & \textbf{Description} & \textbf{SI unit} \\\hline\\[-9px]
//         $\bm{u}$ & solid displacement & m \\[2px]
//         $\bm{u}_f$ & fluid displacement & m \\[2px]
//     \end{tabular}
// \end{table}

// % ACKNOWLEDGEMENTS
// \chapter*{Acknowledgements}
// Here you might want to acknowledge someone.

// \cleardoublepage

// \end{document}

//-----------------------------------------------------------------------------
// Back matter
//-----------------------------------------------------------------------------

#show: start_back_matter
#polimi_outline(title: "List of Figures", target: figure.where(kind: image))
#polimi_outline(title: "List of Tables", target: figure.where(kind: table))

= List of Acronyms
#print-glossary(
  acronyms_list,
  user-print-gloss: (entry, ..) => {
    if count-refs(entry.key) != 0 {
      [#text(weight: "bold", entry.short) #entry.long #entry.description]
      box(width: 1fr, repeat([. \u{0009} \u{0009}]))
      default-print-back-references(entry)
    }
  },
  // user-print-reference: (..kwargs) => {
  //   block(above: 10pt, default-print-reference(..kwargs))
  // },
)

= Ringraziamenti

Qui i miei ringraziamenti
