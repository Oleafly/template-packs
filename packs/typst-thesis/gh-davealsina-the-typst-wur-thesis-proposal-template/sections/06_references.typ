#import "../template.typ": guide, guide-inline

= References

#guide[
  *ABE Guideline:* List of references that you have consulted. You can also include literature you have found but not yet read or processed.

  *Tip:* Use a consistent citation style (APA 7th is standard at WUR). If you manage your references in Zotero or Mendeley, you can export a `.bib` file and integrate it with Typst's bibliography support. For this proposal stage, a manually formatted list is fine — just be consistent.

  *Typst note:* Typst supports `.bib` files natively. You can add `\#bibliography("refs.bib", style: "apa")` here once you have a BibTeX file ready. For now, list your references manually below.
]

#guide[
  _Replace this block with your reference list. Example format (APA 7th):_

  _Author, A. A., & Author, B. B. (Year). Title of article. *Journal Name*, *volume*(issue), pages. https:\/\/doi.org/xxxxx_
]


#bibliography(("../refs.bib", "../images/images.bib"), style: "ieee")