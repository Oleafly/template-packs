#import "../lib.typ": *



= About This Template <ch:intro>






#info[
This template is *unofficial*, and students should verify with their supervisor whether it can be used to typeset the thesis or not.
]

//#h(-1em)
#note(counter:none)[本マニュアルは英語で記述されていますが、テンプレート自体は日本語組版向けに設計されています。]


Welcome! This template is designed to help students produce beautifully typeset theses in Japanese with minimal effort. 論文の組版において LaTeX やWordと格闘しておられる方が多いと思いますが、LaTeXで和欧混植ファイルのビルドが遅すぎるので#note[本当に遅い]、このTypstテンプレートを作りました。
I originally built this thesis template in LuaLaTeX (you can see the legacy version #link("https://www.overleaf.com/read/gbhpjdvttrbs#005234")[here]), but the compile times were simply a productivity killer. So, I ported the entire philosophy to Typst. It is blazing fast. 

This template is designed to mimic the timeless aesthetic of #link("https://bitbucket.org/amiede/classicthesis/")[ClassicThesis]. Below is a quick guide on how this template works, the design choices I made, and how you can customize it.

#v(1em)

#tip(title: "Wait! Before you start")[  


Typst is great, but other versions might suit your specific needs better:

  // List: Left-aligned with automatic hanging indent
  - If you need vertical writing (縦書き), please use the legacy #link("https://www.overleaf.com/read/gbhpjdvttrbs#005234")[LuaLaTeX] version instead.
  - If your paper is mainly in English, you might prefer this 👉 #link("https://www.overleaf.com/read/wkwtcfsynngc#c45c5a")[PDFLaTeX version], or the orignal #link("https://bitbucket.org/amiede/classicthesis/")[ClassicThesis].]




== The Design Philosophy
The layout follows the asymmetric geometry of ClassicThesis. It features a spacious outer margin perfect for margin notes. If you need to tweak the geometry, you can find the settings in `main.typ`:




```typst
#show: marginalia.setup.with(
     inner: ( far: 5mm, width: 15mm, sep: 5mm ),
     outer: ( far: 5mm, width: 30mm, sep: 5mm ),
     top: 30mm,
     bottom: 40mm,
     book: true,
)
```
  


== Citations & Bibliography
Citation is handled by a customized version of the #link("https://github.com/tkrhsmt/enja-bib")[*enja-bib*] package. 
- English sources follow the #Gls("apa") 7th edition #link("https://apastyle.apa.org/style-grammar-guidelines/references/examples")[style].
- Japanese sources follow the #Gls("jpa") style #link("https://psych.or.jp/manual/")[(2022 edition)].

If you want to use other citation style, see @sec:citationstyle for more information.


== Contributing

This template is open source. The source code is available at #link("YOUR_REPO_URL_HERE")[GitHub]. 
If you have suggestions, find a bug#note[特に文献引用スタイル、まだ不備や見落としがあるかもしれません。], or want to improve anything#note[日本語訳欲しい], please feel free to open an Issue or submit a Pull Request. You can also reach out to me via social media. Happy writing!#note[パワー丼を食べてください。]


== Quick Start Guide

Steps to start a new thesis:

+ Edit `config.typ` to set your metadata
+ Edit files in `frontmatter/` for abstract, acknowledgments, etc.
+ Create new chapter files in `chapters/` (don't forget the header!)
+ Adjust chapter order in `main.typ`
+ Add references to `bib/`
+ Compile and check the output

#v(1em)

#block(
  fill: white,
  stroke: (left: 4pt + rgb("#3b82f6"), rest: 1pt + luma(230)), // Thick left border
  inset: 14pt,
  radius: 4pt,
  width: 100%,
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 1em,
    align: (left + horizon, right + horizon),
    
    // Left side: Title
    [
      #text(fill: rgb("#1e3a8a"), weight: "bold", size: 1.2em)[Version Info]
    ],
    
    // Right side: The Version Number
    [
      #box(fill: rgb("#eff6ff"), inset: 6pt, radius: 4pt)[
        #text(fill: rgb("#2563eb"), weight: "bold")[v0.1.0]
      ]
    ]
  )

  #v(0.5em)
  #line(length: 100%, stroke: 0.5pt + luma(200))
  #v(0.5em)

  #grid(
    columns: (auto, auto),
    column-gutter: 2em,
    row-gutter: 0.8em,
    [Release Date:], [2025-12-08],
    [Compatibility:], [Typst 0.14.1],
    [License:], [MIT],
    [Github:], []
  )
]


