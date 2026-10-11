#let inst(n) = super(str(n))

#let authors = (
  (name: "Luciana P. Nedel", affil: (1,)),
  (name: "Rafael H. Bordini", affil: (2,)),
  (name: "Flavio Rech Wagner", affil: (1,)),
  (name: "Jomi F. Hubner", affil: (3,)),
)

#let affiliations = (
  [
    Instituto de Informatica -- Universidade Federal do Rio Grande do Sul (UFRGS)\
    Caixa Postal 15.064 -- 91.501-970 -- Porto Alegre -- RS -- Brazil
  ],
  [
    Department of Computer Science -- University of Durham\
    Durham, U.K.
  ],
  [
    Departamento de Sistemas e Computacao\
    Universidade Regional de Blumenal (FURB) -- Blumenau, SC -- Brazil
  ],
)

#set document(
  title: "Instructions for Authors of SBC Conferences Papers and Abstracts",
  author: authors.map(a => a.name),
)

#set text(font: "Times New Roman", size: 12pt)
#set par(first-line-indent: 1.27cm, spacing: 6pt, justify: true)
#set heading(numbering: "1.")
#show heading.where(level: 1): set text(size: 13pt, weight: "bold")
#show heading.where(level: 2): set text(size: 12pt, weight: "bold")
#set page(
  paper: "a4",
  margin: (
    top: 3.5cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 3cm,
  ),
  numbering: none,
)

#align(center)[
  #text(16pt, weight: "bold")[Instructions for Authors of SBC Conferences]
  \
  #text(16pt, weight: "bold")[Papers and Abstracts]
]

#v(12pt)

#align(center)[
  #text(weight: "bold")[
    #for (i, author) in authors.enumerate() [
      #if i > 0 [, ]
      #author.name#author.affil.map(n => inst(n)).join()
    ]
  ]
]

#v(12pt)

#align(center)[
  #for (i, aff) in affiliations.enumerate() [
    #inst(i + 1) #aff
    #if i < affiliations.len() - 1 [\ \ ]
  ]
  \
  #text(
    font: "Courier New",
    size: 10pt,
    "{nedel,flavio}@inf.ufrgs.br, R.Bordini@durham.ac.uk, jomi@inf.furb.br",
  )
]

#v(12pt)

// First page: abstract / resumo — 12pt Times, 0.8cm indent left & right; labels bold+italic, body italic.
#block(inset: (left: 0.8cm, right: 0.8cm))[
  #set par(justify: true, first-line-indent: 0pt, spacing: 6pt)
  #text(weight: "bold", style: "italic")[Abstract.]
  #emph[ This meta-paper describes the style to be used in articles and short papers for SBC conferences. For papers in English, you should add just an abstract while for the papers in Portuguese, we also ask for an abstract in Portuguese ("resumo"). In both cases, abstracts should not have more than 10 lines and must be in the first page of the paper.]
]

#v(12pt)

#block(inset: (left: 0.8cm, right: 0.8cm))[
  #set par(justify: true, first-line-indent: 0pt, spacing: 6pt)
  #text(weight: "bold", style: "italic")[Resumo.]
  #emph[ Este meta-artigo descreve o estilo a ser usado na confeccao de artigos e resumos de artigos para publicacao nos anais das conferencias organizadas pela SBC. E solicitada a escrita de resumo e abstract apenas para os artigos escritos em portugues. Artigos em ingles deverao apresentar apenas abstract. Nos dois casos, o autor deve tomar cuidado para que o resumo (e o abstract) nao ultrapassem 10 linhas cada, sendo que ambos devem estar na primeira pagina do artigo.]
]

= General Information

All full papers and posters (short papers) submitted to some SBC conference, including any supporting documents, should be written in English or in Portuguese. The format paper should be A4 with single column, 3.5 cm for upper margin, 2.5 cm for bottom margin and 3.0 cm for lateral margins, without headers or footers. The main font must be Times, 12 point nominal size, with 6 points of space before each paragraph. Page numbers must be suppressed.

Full papers must respect the page limits defined by the conference. Conferences that publish just abstracts ask for *one*-page texts.

= First Page

The first page must display the paper title, the name and address of the authors, the abstract in English and "resumo" in Portuguese ("resumos" are required only for papers written in Portuguese). The title must be centered over the whole page, in 16 point boldface font and with 12 points of space before itself. Author names must be centered in 12 point font, bold, all of them disposed in the same line, separated by commas and with 12 points of space after the title. Addresses must be centered in 12 point font, also with 12 points of space after the authors' names. E-mail addresses should be written using font Courier New, 10 point nominal size, with 6 points of space before and 6 points of space after.

The abstract and "resumo" (if is the case) must be in 12 point Times font, indented 0.8cm on both sides. The word *Abstract* and *Resumo* should be written in boldface and must precede the text.

= CD-ROMs and Printed Proceedings

In some conferences, the papers are published on CD-ROM while only the abstract is published in the printed Proceedings. In this case, authors are invited to prepare two final versions of the paper. One, complete, to be published on the CD and the other, containing only the first page, with abstract and "resumo" (for papers in Portuguese).

= Sections and Paragraphs

Section titles must be in boldface, 13pt, flush left. There should be an extra 12 pt of space before each title. Section numbering is optional. The first paragraph of each section should not be indented, while the first lines of subsequent paragraphs should be indented by 1.27 cm.

== Subsections

The subsection titles must be in boldface, 12pt, flush left.

= Figures and Captions

Figure and table captions should be centered if less than one line, otherwise justified and indented by 0.8cm on both margins. The caption font must be Helvetica, 10 point, boldface, with 6 points of space before and after each caption.

#figure(
  image("assets/figures/fig1.jpg", width: 50%),
  caption: [A typical figure],
)

#figure(
  image("assets/figures/fig2.jpg", width: 30%),
  caption: [This figure is an example of a figure caption taking more than one line and justified considering margins mentioned in this section.],
)

In tables, try to avoid the use of colored or shaded backgrounds, and avoid thick, doubled, or unnecessary framing lines. When reporting empirical data, do not use more decimal digits than warranted by their precision and reproducibility. Table caption must be placed before the table and the font used must also be Helvetica, 10 point, boldface, with 6 points of space before and after each caption.

#figure(
  image("assets/tables/table.jpg", width: 70%),
  caption: [Variables to be considered on the evaluation of interaction techniques],
)

= Images

All images and illustrations should be in black-and-white, or gray tones, excepting for the papers that will be electronically available (on CD-ROMs, internet, etc.). The image resolution on paper should be about 600 dpi for black-and-white images, and 150-300 dpi for grayscale images. Do not include images with excessive resolution, as they may take hours to print, without any visible difference in the result.

= References

Bibliographic references must be unambiguous and uniform. We recommend giving the author names references in brackets, e.g. @knuth:84, @boulic:91, and @smith:99.

#bibliography("assets/references/sbc-template.bib", title: [Referências])
