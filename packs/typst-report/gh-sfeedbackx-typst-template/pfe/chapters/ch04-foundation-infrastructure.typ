// ======================================================
// CHAPTER 4 — Template Reference & Element Demo
// ------------------------------------------------------
// PURPOSE:
// This chapter demonstrates every content element
// available in this template. Use it as a reference
// when writing your own chapters.
//
// ELEMENTS SHOWN:
//   - Headings (levels 1–5)
//   - Dropcap paragraph
//   - Bullet & numbered lists (flat + nested)
//   - Definition blocks
//   - Note blocks
//   - Tables (simple, complex with merged cells, styled)
//   - Figures (images with captions)
//   - Cross-references (to figures, tables, sections)
//   - Code / inline code
//   - Multi-page layout with page breaks
// ======================================================

#import "../_templates/chapter.typ": *
#import "../constant.typ": *
#import "../_lib/utils.typ": definition, figureref, note, tableref, titleref

#let chapter_title = [Template Reference & Element Demo]

#let fakepar = context {
  box()
  v(-measure(block() + block()).height)
}

#show heading.where(level: 2): it => {
  text(size: 14pt, weight: "bold")[#it]
  fakepar
}
#show heading.where(level: 3): it => {
  text(size: 12pt, weight: "bold", style: "italic")[#it]
  fakepar
}
#show heading.where(level: 4): it => {
  text(size: 12pt, style: "italic")[#it]
  fakepar
}
#show heading.where(level: 5): it => {
  text(size: 11pt, style: "italic")[#it]
  fakepar
}

#let chapter_body = [

  // ─────────────────────────────────────────────────────
  // INTRODUCTION
  // ─────────────────────────────────────────────────────
  #text(size: 14pt, weight: "bold")[Introduction]
  #lvl_4_ab_lvl_2_dwn
  #fakepar

  This chapter serves as a comprehensive reference for all content elements available
  in this Typst template. Each section demonstrates a different type of element with
  generic placeholder content, so you can see exactly how it renders and copy the pattern
  for your own use.

  // ─────────────────────────────────────────────────────
  // 1. HEADINGS
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Headings] <sec:headings>
  #lvl_4_ab_lvl_2_dwn

  This template supports five levels of headings. Below is an example of each level.

  #heading(depth: 3)[Level 3 Heading]
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. This is a level 3 heading,
  used for sub-sections within a chapter.

  #heading(depth: 4)[Level 4 Heading]
  This is a level 4 heading, used for sub-sub-sections. Notice the italic style.

  #heading(depth: 5)[Level 5 Heading]
  This is a level 5 heading, the deepest level. It uses a smaller italic style.

  // ─────────────────────────────────────────────────────
  // 2. LISTS
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Lists] <sec:lists>
  #lvl_4_ab_lvl_2_dwn

  Lists are essential for presenting structured information. The template supports
  bullet lists, numbered lists, and nested lists.

  #heading(depth: 3)[Bullet List]
  A simple bullet list:

  #list(
    [First item in the list],
    [Second item with additional detail],
    [Third item demonstrating spacing],
  )

  #heading(depth: 3)[Nested List]
  Lists can be nested to multiple levels:

  #list(
    [Category A
      #list(
        [Sub-item A1],
        [Sub-item A2
          #list(
            [Sub-sub-item A2a],
            [Sub-sub-item A2b],
          )
        ],
      )
    ],
    [Category B
      #list(
        [Sub-item B1],
        [Sub-item B2],
      )
    ],
  )


  // ─────────────────────────────────────────────────────
  // 3. DEFINITIONS & NOTES
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Definitions and Notes] <sec:defs>
  #lvl_4_ab_lvl_2_dwn

  The template provides styled blocks for definitions and notes.

  #heading(depth: 3)[Definition Block]
  Use the `#definition()` function to highlight key terms:

  #definition()[
    *A definition* is a statement that explains the meaning of a term or concept.
    It provides clarity and ensures that readers share a common understanding
    of the terminology used throughout the document.
  ]

  #definition()[
    *Another definition example* demonstrating how multiple definitions
    can be placed sequentially. Each one gets its own styled block with a
    green left border and green label.
  ]

  #heading(depth: 3)[Note Block]
  Use the `#note()` function for side notes, tips, or warnings:

  #note()[
    This is a note block. It is styled with a blue left border and a light
    blue background. Use it to highlight important information, tips, or
    caveats that the reader should be aware of.
  ]

  #note()[
    Notes can contain multiple paragraphs and even inline formatting like
    *bold* or _italic_ text.
  ]

  // ─────────────────────────────────────────────────────
  // 4. TABLES
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Tables] <sec:tables>
  #lvl_4_ab_lvl_2_dwn

  Tables are useful for presenting structured data. The template provides
  several table styles.

  #heading(depth: 3)[Simple Table with Caption]
  A basic three-column table with a caption:

  #figure(
    table(
      columns: (auto, 1fr, 1fr),
      table.header([*Column A*], [*Column B*], [*Column C*]),
      [Row 1], [Data 1], [Value 1],
      [Row 2], [Data 2], [Value 2],
      [Row 3], [Data 3], [Value 3],
      [Row 4], [Data 4], [Value 4],
    ),
    caption: [Simple Table — Three Columns with Sample Data],
  )<tab:simple>

  #heading(depth: 3)[Complex Table with Merged Cells]
  A table demonstrating rowspan and colspan:

  #figure(
    table(
      columns: (auto, auto, 1fr),
      table.header([*Category*], [*Property*], [*Description*]),
      table.cell(rowspan: 2, align: center + horizon)[Group A],
      [Attribute 1],
      [Description of attribute 1 that spans multiple lines of text],
      [Attribute 2],
      [Description of attribute 2],
      table.cell(rowspan: 2, align: center + horizon)[Group B],
      [Attribute 3],
      [Description of attribute 3],
      [Attribute 4],
      [Description of attribute 4],
    ),
    caption: [Complex Table — Merged Cells Demonstration],
  )<tab:complex>

  #heading(depth: 3)[Table without Figure Wrapper]
  A raw table without the figure wrapper (no caption numbering):

  #table(
    columns: (auto, auto, auto),
    [*Item*], [*Quantity*], [*Price*],
    [Widget A], [5], [\$10.00],
    [Widget B], [3], [\$15.00],
    [Widget C], [8], [\$7.50],
  )
  #vs-m
  #align(
    center,
    block({
      show table.cell.where(y: 0): set text(weight: "regular", fill: black)
      set table(
        align: left,
        fill: (col, row) => if calc.odd(row) { luma(245) } // zebra striping
        else { white },
      )

      figure(
        table(
          columns: (6em, 1fr),
          //          inset: 7pt,
          align: horizon,
          [Controller],
          [responsible for handling incoming HTTP requests, extracting input data, and
            returning HTTP responses. They should remain thin and delegate business logic to
            services.],

          [Service],
          [contain the business logic of the application. They orchestrate operations, enforce
            rules, and interact with repositories. Services are where the core functionality of
            MedLink lives.],

          [Repository],
          [responsible for data access. They abstract the database interactions, providing a
            clean interface for services to query and persist data without knowing the underlying
            database details.],
        ),
        caption: [Three-Tier Architecture Overview],
      )
    }),
  )
  // ─────────────────────────────────────────────────────
  // 5. FIGURES (IMAGES)
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Figures and Images] <sec:figures>
  #lvl_4_ab_lvl_2_dwn

  Images and figures can be included with captions and cross-referenced.

  #heading(depth: 3)[Image with Caption]
  Below is an example of an image with a centered caption:

  #figure(
    image(
      "../assets/xp_scrum.jpg",
      width: 80%,
      fit: "contain",
    ),
    caption: [Sample Image — Placeholder for Your Own Diagrams],
    gap: 1em,
  )<fig:sample>


  // ─────────────────────────────────────────────────────
  // 6. CROSS-REFERENCES
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Cross-References] <sec:refs>
  #lvl_4_ab_lvl_2_dwn

  The template provides helper functions for cross-referencing figures,
  tables, and sections.

  #heading(depth: 3)[Referencing a Figure]
  Use `#figureref(label)` to reference a figure:

  #figureref(<fig:sample>) shows a sample image. The reference
  automatically includes the figure number and creates a clickable link.

  #heading(depth: 3)[Referencing a Table]
  Use `#tableref(label, prefix)` to reference a table:

  #tableref(<tab:simple>, [Table]) shows a simple table, while
  #tableref(<tab:complex>, [Table]) shows a complex table.

  #heading(depth: 3)[Referencing a Section]
  Use `#titleref(label)` to reference a section:

  See #titleref(<sec:headings>) for heading examples,
  #titleref(<sec:lists>) for list examples, and
  #titleref(<sec:defs>) for definition and note examples.


  // ─────────────────────────────────────────────────────
  // 8. PARAGRAPH STYLES
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Paragraph Styles] <sec:par>
  #lvl_4_ab_lvl_2_dwn

  Paragraphs are justified with first-line indentation. Below are additional
  style examples.

  *Bold text* and _italic text_ can be mixed freely. You can also have
  `inline code`, #text(fill: blue)[colored text], and #text(size: 16pt)[sized text].

  #heading(depth: 3)[Multiple Paragraphs]
  This is the first paragraph after a heading. It demonstrates the first-line
  indent and justified alignment.

  This is a second paragraph with a blank line between. The template automatically
  handles paragraph spacing. Notice the consistent leading and spacing.

  And this is a third paragraph to further demonstrate the paragraph spacing
  and justification settings applied by the chapter template.

  // ─────────────────────────────────────────────────────
  // CONCLUSION
  // ─────────────────────────────────────────────────────
  #lvl_2_ab
  #heading(depth: 2)[Summary] <sec:summary>
  #lvl_4_ab_lvl_2_dwn
  #fakepar

  This chapter demonstrated all the content elements available in this template.
  You can use these examples as a reference when writing your own chapters.
  Simply replace the placeholder text with your own content, and adjust the
  element types as needed.

  For further customization, refer to the template files:
  #list(
    [`_templates/chapter.typ` — the chapter layout function],
    [`_lib/utils.typ` — helper functions (definitions, notes, references)],
    [`constant.typ` — spacing constants],
    [`front/cover_page.typ` — cover page customization],
  )
]

#pagebreak()

#set document(title: chapter_title)

#chapter_page("4", chapter_title)[
  #chapter_body
]
