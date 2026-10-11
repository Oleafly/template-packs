//╭─────────────────────────────────────╮
//│       Import vortex template        │
//╰─────────────────────────────────────╯
#import "../vortex.typ": (
  vortex, vortex-bibliography, vortex-cite-text, vortex-dropcap, vortex-image, vortex-long-citation, vortex-table,
)

//╭─────────────────────────────────────╮
//│   Creation of new vortex article    │
//╰─────────────────────────────────────╯
#show: vortex.with(
  // Editor fields (do not CHANGE)
  vortex-number: 1,
  article-first-page-number: 1,
  article-last-page-number: 24,
  doi: "00.00000/vortex.0000.00.0000",
  received: "00/00/2026",
  accepted: "00/00/2026",
  available-online: "00/00/2026",
  editor: "Dr Fabio Guilherme Poletto. Dr Felipe de Almeida Ribeiro",
  // this do not render the authors
  blind-review: true,

  // Author fields (CHANGE)
  title: "Title in the Original Language (Maximum 90 Characters)",
  name: "Name",
  lastname: "Last Name",
  lang: "en",
  region: "us",

  // authors
  authors: (
    (
      name: "Author 1",
      affiliation: "University of World | Earth, Milky Way",
      orcid: "0000-0000-0000-0000",
    ),

    (
      name: "Author 2",
      affiliation: "University of World | Earth, Milky Way",
      orcid: "0000-0000-0000-0000",
    ),
  ),

  // resumo (portugues)
  resumo: [
    #lorem(200)
  ],

  palavras-chave: [
    Computer-Aided Composition,
    Pure Data,
    Bach Library.
  ],

  // abstract (english)
  abstract: [
    #lorem(200)
  ],

  keywords: [
    Computer-Aided Composition,
    Pure Data,
    Bach Library.
  ],
)

//╭─────────────────────────────────────╮
//│         Here start the text         │
//╰─────────────────────────────────────╯

// First paragraph of Vortex use dropcap
#vortex-dropcap[
  #lorem(250)
]

Citation using latex will be something like this, where I claim that something and use someone for reference @kramer_moment_1978. A second article would be cited as @cont2010[p. 20]. You need to check the `references.bib` clicking in the icon above the search on the sidebar. To Get this code you can use, for example, Zotero `Export Library...`. For citations on text, you can use `#cite(<cont2010>, form: "prose")` where `cont2010` is the key for the citation. For example, following #vortex-cite-text("Cont", <cont2010>) or #vortex-cite-text("Arshia Cont", <cont2010>).

// after first paragraph, just write, new lines start a new paraphrapg.
To make footnotes in `Typst` we use `#footnote`#footnote[See #vortex-cite-text("Cont", <cont2010>) for the original paper. #lorem(25)]. For long citations we use `#vortex-long-citation`.

// for long citation we use #vortex-long-citation
#vortex-long-citation[
  #lorem(100) @cont2010.
]

For chapter we use `= Chapter Title`.

// Chapter 1 (level 1 is =)
= Chapter Title

For level 2 we use `== Sub Chapter`. Note the use of two equal signals. For 3, tree equals signals, etc...

// Chapter 1.1 (level 2 is ==)
== Sub Chapter

#lorem(180)

== Images and Tables

For images we use the `#vortex-image` command. For it, first we set the `PATH` to the image, them the caption, and finally the source.

// for image we use #vortex-image
#vortex-image(
  "./examples/images/image1.png",
  caption: lorem(20),
  source: [Author (2015, p. 450)],
)

For tables we use the `#vortex-table` command.

// for table we use #vortex-table
#vortex-table(
  table(
    columns: 5,
    [], [Column 1], [Column 2], [Column 3], [Column 4],
    [_Linha 1_], [abc], [def], [abc], [def],
    [_Linha 2_], [bca], [efd], [bca], [efd],
    [_Linha 3_], [cba], [fed], [cba], [fed],
    [_Linha 4_], [abc], [def], [abc], [def],
    [_Linha 5_], [bca], [efd], [bca], [efd],
    [_Linha 6_], [cba], [fed], [cba], [fed],
  ),
  caption: lorem(20),
  source: [Author (2015, p. 450)],
  ref: <sample>,
)

To make a reference to a table you can use the @sample. The name must be passed as `ref` to the `vortex-table`.

//╭─────────────────────────────────────╮
//│             References              │
//╰─────────────────────────────────────╯
// finally for bibliografy use the vortex bib. This will render just articles/books cited on the text using @. For example, in this text we use @cont2010, check the references.bib file
#vortex-bibliography("./examples/references.bib")
