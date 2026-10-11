// Version 1
// 10. January 2026

#import "src/template.typ": thesis

/*
Typst currently doesn't support exporting documents to PDF/A when they contain embedded PDF images. To work around this, convert your PDF images to SVG (or a high-resolution bitmap) before using them. This can be done using the following tools:

Online tools:
https://svgconverter.com/
https://pdftosvg.com/
https://tools.pdf24.org/en/pdf-to-images

Offline tool:
https://github.com/shawkui/pdf2img

Always prioritize the highest standard when exporting:
PDF/A-4
PDF/A-3u
PDF/A-3b
PDF/A-2u
PDF/A-2b
PDF/A-1b

If direct conversion is not possible, export a regular PDF and use an online tool to convert it to PDF/A:
https://tools.pdf24.org/en/pdf-to-pdfa
https://www.pdfforge.org/online/en/pdf-to-pdfa

Incase you ever needed to edit PDF file here are good free online tools:
https://tools.pdf24.org/
https://www.pdfgear.com/online-tools/
https://www.pdfforge.org/online/en
*/

#thesis(
  // U need to place "../" before file name, because the file is read from subfoler.
  // If you do not want to use the acknowledgement, simply comment out the line.
  
  assignment: ( 
    "../frontmatter/assignment-1.svg",
    "../frontmatter/assignment-2.svg",
  ),
  
  abstracts_keywords: "../frontmatter/abstracts_keywords.typ",
  
  acknowledgment: "../frontmatter/acknowledgment.typ",

  acronyms_symbols: "../frontmatter/acronyms_symbols.typ",
  
  
  chapters: (
   "../chapters/introduction.typ",
   "../chapters/sample_chapter_1.typ",
   "../chapters/sample_chapter_2.typ",
   "../chapters/technical_details.typ",
   "../chapters/conclusion.typ",
   "../chapters/ch_1.typ",
   "../chapters/ch_2.typ",
   "../chapters/ch_3.typ",
  ),
  
  // Supported bibliography file formats are BibLaTeX (.bib) and Hayagriva (.yaml/.yml) 
  references: (
    "../bibliography/biblatex-examples.bib",
    "../bibliography/coffee.bib",
  ),
  
  appendices: (
    "../appendices/appendix_1.typ",
    "../appendices/appendix_2.typ",
    "../appendices/appendix_3.typ",
  ),

  show_figure_contents: true,
  show_table_contents: true,
  show_listing_contents: true,
)