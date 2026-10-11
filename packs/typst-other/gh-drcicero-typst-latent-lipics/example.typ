#import "latent-lipics.typ" : *

#let latex = [L#h(-2pt)#super("A")T#sub("E")X] // not perfect

#show: lipics.with(
  title: [LIPIcs: Instructions for Authors and the #box(`lipics-v2021`) Class],
  authors: (
    (name: "Dagstuhl Publishing",
     //orcid: "https://orcid.org/0000-0002-8672-0265",
     link: "https://www.dagstuhl.de/en/publications/",
     email: "jane.open.access@example.org",
     affiliation: [
      Schloss Dagstuhl – Leibniz-Zentrum für Informatik \
      Oktavie-Allee, 66687 Wadern, Germany]),
  ),
  abstract: [
    This document provides general instructions for authors on how to prepare articles to be submitted to the _Leibniz International Proceedings in Informatics_ series and a description of the typesetting process. All LIPIcs articles are written in #latex using the #latex style class of the series. Starting in 2021, the newest version of this style (`lipics-v2021`) is used for publications. This document presents the functionalities of this style class, along with the instructions for the authors.],
  ccsdesc: [General and reference → Computing standards, RFCs and
guidelines],
  keywords: (latex, "type setting", "style", "changelog", [`lipics-v2021`]),
  supplement: [The style files including a sample document can be found here: \
_Software (Style)_: #link("https://submission.dagstuhl.de/styles/download/lipics/authors", [`https://submission.dagstuhl.de/styles/download/lipics/authors`]) \
_Software (Source Code)_: #link("https://github.com/dagstuhl-publishing/styles/", [`https://github.com/dagstuhl-publishing/styles/`]) \
~~~~archived at #link("https://archive.softwareheritage.org/swh:1:dir:1b66fc29b44e371e68a77879c0fbebefe3cd34f8", [`swh:1:dir:1b66fc29b44e371e68a77879c0fbebefe3cd34f8`])],
//  doi: "",
//  funding: "",
//  acknowledgements: "",
)

= Typesetting instructions – Summary
<sec:typesetting-summary>
LIPIcs – Leibniz International Proceedings in Informatics is a series of open access high-quality conference proceedings
across all fields in informatics established in cooperation with Schloss
Dagstuhl. In order to do justice to the high scientific quality of the
conferences that publish their proceedings in the LIPIcs series, which
is ensured by the thorough review process of the respective events, we
believe that LIPIcs proceedings must have an attractive and consistent
layout matching the standard of the series. Moreover, the quality of the
metadata, the typesetting and the layout must also meet the requirements
of other external parties such as indexing service, DOI registry,
funding agencies, among others. The guidelines contained in this
document serve as the baseline for the authors, editors, and the
publisher to create documents that meet as many different requirements
as possible.

Please comply with the following instructions when preparing your
article for a LIPIcs proceedings volume.

==== Minimum requirements
<minimum-requirements>
- Use pdflatex and an up-to-date LaTeX system.

- Use further LaTeX packages and custom made macros carefully and only
  if required.

- Use the provided sectioning macros: `\section`, `\subsection`,
  `\subsubsection`, `\paragraph`, `\paragraph*`, and `\subparagraph*`.

- Provide suitable graphics of at least 300dpi (preferably in PDF
  format).

- Use BibTeX and keep the standard style (`plainurl`) for the
  bibliography.

- Please try to keep the warnings log as small as possible. Avoid
  overfull `\hboxes` and any kind of warnings/errors with the referenced
  BibTeX entries.

- Use a spellchecker to correct typos.

==== Mandatory metadata macros
<mandatory-metadata-macros>
Please set the values of the metadata macros carefully since the
information parsed from these macros will be passed to publication
servers, catalogues and search engines. Avoid placing macros inside the
metadata macros. The following metadata macros/environments are
mandatory:

- `\title` and, in case of long titles, `\titlerunning`.

- `\author`, one for each author, even if two or more authors have the
  same affiliation.

- `\authorrunning` and `\Copyright` (concatenated author names) \
  The `\author` macros and the `\Copyright` macro should contain full
  author names (especially with regard to the first name), while
  `\authorrunning` should contain abbreviated first names.

- `\ccsdesc` (ACM classification, see
  #link("https://www.acm.org/publications/class-2012")).

- `\keywords` (a comma-separated list of keywords).

- `\relatedversion` (if there is a related version, typically the "full
  version"); please make sure to provide a persistent URL, e. g., at
  arXiv.

- `\begin{abstract}...\end{abstract}` .

==== Please do not …
<please-do-not>
Generally speaking, please do not override the `lipics-v2021`-style
defaults. To be more specific, a short checklist also used by Dagstuhl
Publishing during the final typesetting is given below. In case of
#strong[non-compliance] with these rules Dagstuhl Publishing will remove
the corresponding parts of LaTeX code and #strong[replace it with the
`lipics-v2021` defaults]. In serious cases, we may reject the
LaTeX-source and expect the corresponding author to revise the relevant
parts.

- Do not use a different main font. (For example, the `times` package is
  forbidden.)

- Do not alter the spacing of the `lipics-v2021.cls` style file.

- Do not use `enumitem` and `paralist`. (The `enumerate` package is
  preloaded, so you can use `\begin{enumerate}[(a)]` or the like.)

- Do not use "self-made" sectioning commands (e. g., `\noindent{\bf My`
  `Paragraph}`).

- Do not hide large text blocks using comments or `\iffalse` $dots.h$
  `\fi` constructions.

- Do not use conditional structures to include/exclude content. Instead,
  please provide only the content that should be published – in one file
  – and nothing else.

- Do not wrap figures and tables with text. In particular, the package
  `wrapfig` is not supported.

- Do not change the bibliography style. In particular, do not use
  author-year citations. (The `natbib` package is not supported.)

This is only a summary containing the most relevant details. Please read
the complete document "LIPIcs: Instructions for Authors and the
`lipics-v2021` Class" for all details and don’t hesitate to contact
Dagstuhl Publishing
(#link("mailto:publishing@dagstuhl.de")[mailto:publishing\@dagstuhl.de])
in case of questions or comments:
#link("http://drops.dagstuhl.de/styles/lipics-v2021/lipics-v2021-authors/lipics-v2021-authors-guidelines.pdf")[`http://drops.dagstuhl.de/styles/lipics-v2021/lipics-v2021-authors/lipics-v2021-authors-guidelines.pdf`]

= Lorem ipsum dolor sit amet
<lorem-ipsum-dolor-sit-amet>
Lorem ipsum dolor sit amet, consectetur adipiscing elit @Knuth74. Praesent convallis orci arcu, eu
mollis dolor. Aliquam eleifend suscipit lacinia. Maecenas quam mi, porta
ut lacinia sed, convallis ac dui. Lorem ipsum dolor sit amet,
consectetur adipiscing elit. Suspendisse potenti. Donec eget odio et
magna ullamcorper vehicula ut vitae libero. Maecenas lectus nulla,
auctor nec varius ac, ultricies et turpis. Pellentesque id ante erat. In
hac habitasse platea dictumst. Curabitur a scelerisque odio.
Pellentesque elit risus, posuere quis elementum at, pellentesque ut
diam. Quisque aliquam libero id mi imperdiet quis convallis turpis
eleifend.

<lemma:lorem> Vestibulum sodales dolor et dui cursus iaculis. Nullam
ullamcorper purus vel turpis lobortis eu tempus lorem semper. Proin
facilisis gravida rutrum. Etiam sed sollicitudin lorem. Proin
pellentesque risus at elit hendrerit pharetra. Integer at turpis varius
libero rhoncus fermentum vitae vitae metus.

#emph[Proof.] Cras purus lorem, pulvinar et fermentum sagittis, suscipit
quis magna.

Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet
doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit
amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod
tincidunt ut laoreet dolore magna aliquam erat volutpat.

content...

content...

+ abc abc abc

 ◻

<lemma:curabitur> Nam liber tempor cum soluta nobis eleifend option
congue nihil imperdiet doming id quod mazim placerat facer possim assum.
Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam
nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat
volutpat.

<prop1> This is a proposition

#link(<prop1>)[\[prop1\]] and #link(<prop1>)[\[prop1\]] …

== Curabitur dictum felis id sapien
<curabitur-dictum-felis-id-sapien>
Curabitur dictum #link(<lemma:curabitur>)[\[lemma:curabitur\]] felis id
sapien #link(<lemma:curabitur>)[\[lemma:curabitur\]] mollis ut venenatis
tortor feugiat. Curabitur sed velit diam. Integer aliquam, nunc ac
egestas lacinia, nibh est vehicula nibh, ac auctor velit tellus non
arcu. Vestibulum lacinia ipsum vitae nisi ultrices eget gravida turpis
laoreet. Duis rutrum dapibus ornare. Nulla vehicula vulputate iaculis.
Proin a consequat neque. Donec ut rutrum urna. Morbi scelerisque turpis
sed elit sagittis eu scelerisque quam condimentum. Pellentesque habitant
morbi tristique senectus et netus et malesuada fames ac turpis egestas.
Aenean nec faucibus leo. Cras ut nisl odio, non tincidunt lorem. Integer
purus ligula, venenatis et convallis lacinia, scelerisque at erat. Fusce
risus libero, convallis at fermentum in, dignissim sed sem. Ut dapibus
orci vitae nisl viverra nec adipiscing tortor condimentum
@Dijkstra68a. Donec non suscipit lorem. Nam
sit amet enim vitae nisl accumsan pretium.

```
for i:=maxint to 0 do 
begin 
    j:=square(root(i));
end;
```

== Proin ac fermentum augue
<proin-ac-fermentum-augue>
Proin ac fermentum augue. Nullam bibendum enim sollicitudin tellus
egestas lacinia euismod orci mollis. Nulla facilisi. Vivamus volutpat
venenatis sapien, vitae feugiat arcu fringilla ac. Mauris sapien tortor,
sagittis eget auctor at, vulputate pharetra magna. Sed congue, dui nec
vulputate convallis, sem nunc adipiscing dui, vel venenatis mauris sem
in dui. Praesent a pretium quam. Mauris non mauris sit amet eros rutrum
aliquam id ut sapien. Nulla aliquet fringilla sagittis. Pellentesque eu
metus posuere nunc tincidunt dignissim in tempor dolor. Nulla cursus
aliquet enim. Cras sapien risus, accumsan eu cursus ut, commodo vel
velit. Praesent aliquet consectetur ligula, vitae iaculis ligula
interdum vel. Integer faucibus faucibus felis.

- Ut vitae diam augue.

- Integer lacus ante, pellentesque sed sollicitudin et, pulvinar
  adipiscing sem.

- Maecenas facilisis, leo quis tincidunt egestas, magna ipsum
  condimentum orci, vitae facilisis nibh turpis et elit.

content...

= Pellentesque quis tortor
<pellentesque-quis-tortor>
Nec urna malesuada sollicitudin. Nulla facilisi. Vivamus aliquam tempus
ligula eget ornare. Praesent eget magna ut turpis mattis cursus. Aliquam
vel condimentum orci. Nunc congue, libero in gravida convallis
@HopcroftPV75, orci nibh sodales quam, id egestas
felis mi nec nisi. Suspendisse tincidunt, est ac vestibulum posuere,
justo odio bibendum urna, rutrum bibendum dolor sem nec tellus.

Sed interdum nisl pretium non. Mauris sodales consequat risus vel
consectetur. Aliquam erat volutpat. Nunc sed sapien ligula. Proin
faucibus sapien luctus nisl feugiat convallis faucibus elit cursus. Nunc
vestibulum nunc ac massa pretium pharetra. Nulla facilisis turpis id
augue venenatis blandit. Cum sociis natoque penatibus et magnis dis
parturient montes, nascetur ridiculus mus.

Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus felis. Duis et
leo dui. Nam vulputate, velit et laoreet porttitor, quam arcu facilisis
dui, sed malesuada risus massa sit amet neque.

= Morbi eros magna
<morbi-eros-magna>
Morbi eros magna, vestibulum non posuere non, porta eu quam. Maecenas
vitae orci risus, eget imperdiet mauris. Donec massa mauris,
pellentesque vel lobortis eu, molestie ac turpis. Sed condimentum
convallis dolor, a dignissim est ultrices eu. Donec consectetur volutpat
eros, et ornare dui ultricies id. Vivamus eu augue eget dolor euismod
ultrices et sit amet nisi. Vivamus malesuada leo ac leo ullamcorper
tempor. Donec justo mi, tempor vitae aliquet non, faucibus eu lacus.
Donec dictum gravida neque, non porta turpis imperdiet eget. Curabitur
quis euismod ligula.

= Styles of lists, enumerations, and descriptions
<sec:itemStyles>
List of different predefined enumeration styles:

- `\begin{itemize}...\end{itemize}`

- …

- …

+ `\begin{enumerate}...\end{enumerate}`

+ …

+ …

`\begin{alphaenumerate}...\end{alphaenumerate}`

…

…

`\begin{romanenumerate}...\end{romanenumerate}`

…

…

`\begin{bracketenumerate}...\end{bracketenumerate}`

…

…

/ Description 1: #block[
`\begin{description} \item[Description 1]  ...\end{description}`
]

/ Description 2: #block[
Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus felis. Duis et
leo dui. Nam vulputate, velit et laoreet porttitor, quam arcu facilisis
dui, sed malesuada risus massa sit amet neque.
]

/ Description 3: #block[
…
]

#link(<testenv-proposition>)[\[testenv-proposition\]] and
#link(<testenv-proposition>)[\[testenv-proposition\]] ...

= Theorem-like environments
<sec:theorem-environments>
List of different predefined enumeration styles:

<testenv-theorem> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-lemma> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-corollary> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-proposition> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-conjecture> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-observation> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-exercise> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-definition> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-example> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-note> Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus
felis. Duis et leo dui. Nam vulputate, velit et laoreet porttitor, quam
arcu facilisis dui, sed malesuada risus massa sit amet neque.

Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus felis. Duis et
leo dui. Nam vulputate, velit et laoreet porttitor, quam arcu facilisis
dui, sed malesuada risus massa sit amet neque.

#pagebreak()

#h(1.5em) <testenv-remark> To ensure their long-term preservation, documents with the lipics-v2021 style are
generated in accordance with the PDF/A-3b standard8. A PDF/A file is completely self-
contained. It includes everything needed for accurate representation of the contents. For this
reason, the fonts in all used PDF files (e.g. figures) have to be embedded in them. Furthermore,
PDF/A doesn’t allow mixing color spaces. The default color space in lipics-v2021 is the
sRGB color space. So please don’t use other color spaces. The PDF/A support is disabled by
default to avoid problems with outdated LaTeX installation. To enable the support, add the
option pdfa as argument of \documentclass. This option will be set during the finalization pdfa
of the document.

Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus felis. Duis et
leo dui. Nam vulputate, velit et laoreet porttitor, quam arcu facilisis
dui, sed malesuada risus massa sit amet neque.

<testenv-claim> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

<testenv-claim2> Fusce eu leo nisi. Cras eget orci neque, eleifend
dapibus felis. Duis et leo dui. Nam vulputate, velit et laoreet
porttitor, quam arcu facilisis dui, sed malesuada risus massa sit amet
neque.

#emph[Proof.] Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus
felis. Duis et leo dui. Nam vulputate, velit et laoreet porttitor, quam
arcu facilisis dui, sed malesuada risus massa sit amet neque. ◻

Fusce eu leo nisi. Cras eget orci neque, eleifend dapibus felis. Duis et
leo dui. Nam vulputate, velit et laoreet porttitor, quam arcu facilisis
dui, sed malesuada risus massa sit amet neque.

#bibliography("bibliography.bib")
