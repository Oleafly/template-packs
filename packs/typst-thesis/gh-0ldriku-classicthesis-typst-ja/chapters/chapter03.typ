#import "../lib.typ": *


= Template Structure <ch:structure>

This chapter explains the file structure of this Typst thesis template. Understanding the role of each file and folder is essential for using this template effectively.

== File Tree

#block(
  fill: rgb("#1e293b"),
  stroke: none,
  inset: 1.5em,
  radius: 8pt,
  width: 100%,
)[
  #set text(font: "Noto Sans Mono CJK JP", size: 10pt, fill: rgb("#e2e8f0"))
  
  #no-codly[
  ```
  thesis-template/
  │
  ├── 📁 bib/                    ← Bibliography files
  │   ├── Bibliography_en.bib
  │   ├── Bibliography_ja.bib
  │   └── bibtest.bib
  │
  ├── 📁 chapters/               ← Main content chapters
  │   ├── chapter01.typ
  │   ├── chapter02.typ
  │   ├── chapter03.typ
  │   ├── chapter04.typ
  │   ├── chapter05.typ
  │   ├── appendix01.typ
  │   └── appendix02.typ
  │
  ├── 📁 frontmatter/            ← Front matter pages
  │   ├── abbreviations.typ
  │   ├── abstract.typ
  │   ├── acknowledgments.typ
  │   ├── changelog_data.typ
  │   ├── changelog_page.typ
  │   ├── committee.typ
  │   ├── dedication.typ
  │   ├── publications.typ
  │   ├── title_back.typ
  │   ├── title_page.typ
  │   ├── toc_abb.typ
  │   └── todo_page.typ
  │
  ├── 📁 gfx/                    ← Images & figures
  │   └── (your figures here)
  │
  ├── 📁 src/                    ← Citation functions
  │   ├── biblib.typ
  │   ├── bib-style.typ
  │   ├── bib-tex.typ
  │   ├── bib-setting-fucntion.typ
  │   └── bib-setting-custom/
  │       └── bib-setting-apa.typ
  │
  ├── ⚙️ config.typ              ← Personal info settings
  ├── ⚙️ lib.typ                 ← Style settings
  └── 📄 main.typ                ← Main file
  ```]
]

#v(1em)

== Folder & File Descriptions

=== bib/ — Bibliography Folder

  Place your BibTeX `.bib` files in this folder.
  
  - `Bibliography_en.bib` — English references
  - `Bibliography_ja.bib` — Japanese references (requires `yomi` field)
  - `bibtest.bib` — Sample entries for all entry types

  *Note:* The files listed above are for testing purposes only. You should create your own `.bib` files (e.g., `chapter01.bib`) and update the `main.typ` configuration to load them:

  ```typst
  #bibliography-list(
    title: "引用文献",
    bib-sort: true,
    bib-full: false,
    // Load your specific files here:
    ..bib-file(read("bib/chapter01.bib")),
    ..bib-file(read("bib/chapter02.bib")),
    ..bib-file(read("bib/chapter03.bib")),
    ```



=== chapters/ — Content Folder

Place each chapter of your thesis in this folder. When creating a new chapter file, you *must* include the following header:


#warning(title:"Important: Required Header for New Chapters")[
  
  ```typst
  #import "../lib.typ": *
  ```
  
  Without this import, all functions will not work correctly.
  
]

Start chapter headings with `=`. Add labels for cross-referencing:

```typst
= Introduction <ch:intro>

In this chapter...

== Background

=== Related Work
```

=== frontmatter/ — Front Matter Folder

Pages that appear before the main content (after title page, before chapters):



#block(
  fill: rgb("#1e293b"),
  stroke: none,
  inset: 1.5em,
  radius: 8pt,
  width: 100%,
)[
  #set text(font: "Noto Sans Mono CJK JP", size: 10pt, fill: rgb("#e2e8f0"))
  #no-codly[
  ```

  📁 frontmatter/                    
  ├── abbreviations.typ              ←   Abbreviation Definitions
  ├── abstract.typ                   ←   Abstract / Summary
  ├── acknowledgments.typ            ←   Acknowledgments
  ├── changelog_data.typ             ←   Changelog Data
  ├── changelog_page.typ             ←   Changelog Page Layout
  ├── committee.typ                  ←   Examination Committee
  ├── dedication.typ                 ←   Dedication
  ├── publications.typ               ←   Publication List
  ├── title_back.typ                 ←   Back of Title Page
  ├── title_page.typ                 ←   Title Page
  ├── toc_abb.typ                    ←   List of Abbreviations Page
  └── todo_page.typ                  ←   Todo & Notes Page
  ```
]
]



=== gfx/ — Graphics Folder

Place all images and figures used in your thesis here. 



=== src/ — Citation Functions Folder


Based on the `enja-bib` package, providing citation functionality compatible with APA 7th Edition (English) and Japanese Psychological Association (JPA) format (Japanese). Do not modify these files unless you are familiar with advanced Typst scripting.

== Configuration Files

=== config.typ — Personal Information


#task(title:"Edit This File")[Set your thesis metadata (title, author name, affiliation, etc.) here.]

```typst
#let myTitle = "Thesis Title"
#let myName = "Author Name"
#let myTime = "March 2024"
#let myUni = "Tokyo Institute of Technology"
#let myFaculty = "School of Engineering"
#let myDepartment = "Department of Mechanical Engineering"
```



=== lib.typ — Style Settings




#danger(title:"Advanced Users Only")[This is the core of the template, containing page layout, font settings, ToC styles, heading styles, and more. Only edit if you understand Typst's internals.]


=== main.typ — Main File


#task(title:"Edit Thesis Structure")[This file defines the overall structure of your thesis. Add, remove, or reorder chapters here.

  *Note:* The `#cleardoublepage()` function is used to create a professional book-style layout. It forces the following content to start on an *odd* page (the right-hand side).]

Structure example:

```typst
// --- Frontmatter ---
#set page(numbering: "i")
#include "frontmatter/abstract.typ"
#include "frontmatter/acknowledgments.typ"
#outline(depth: 3, indent: auto)

// --- Mainmatter ---
#set page(numbering: "1")
#cleardoublepage()
#part("Part I")
#cleardoublepage()
#include "chapters/chapter01.typ"
#cleardoublepage()
#include "chapters/chapter02.typ"

// --- Appendix ---
#show: appendix_init
#include "chapters/appendix01.typ"

// --- Bibliography ---
#bibliography-list(...)
```



