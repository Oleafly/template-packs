#import "cambridge.typ": *
//#show: chapter

= In-text references
Use ```typst @<citation-key>``` to include references. For example, ```typst @ref1``` will insert an in-text reference to the reference with the citation-key  ```typst ref1```, like so: \
#lorem(10)@ref1 \ 
This reference will then be included in the bibliography (the next chapter) 

Multiple references can also be included @ref1 @ref2 @ref3 @ref4.


= Converting from other formats 

== Use Pandoc
To convert Word documents (or other formats, i.e. markdown, quarto, LaTeX, etc.) into Typst ```.typ``` documents, install Pandoc (#link("https://pandoc.org/installing.html")) and use it to convert ```.docx``` files into ```.typ``` files. 

Then, edit as necessary. This might involve:
- Formatting tables by replacing ```typst #table()``` with ```typst #table-format()```
- Placing figures and their long descriptions into a ```typst #block``` by replacing ```typst #figure()``` with ```typst #figure-with-description()```
- Inserting ```typst #pagebreak()``` where necessary

== References
If converting references inserted by Zotero from Microsoft Word, follow this guide: #link("https://retorque.re/zotero-better-bibtex/citing/migrating/index.html")

=== Brief guide to converting Zotero references in Word to Typst 
In brief:
+ Use Zotero as a reference manager and use the Zotero plugin for citing references in Word
+ Install the Better BibTeX plugin for Zotero
+ Install the citation style ```typst better-bibtex-citekeys_typst.csl``` into Zotero (found in `Referencing` folder)
+ Change the citation style to 'Better Bibtex Citekeys for Typst'
+ Convert the ```.docx``` files into ```.typ``` files using Pandoc
+ Replace all ```\@``` with ```@``` to get references recognised by Typst
+ Export your Zotero library in the Better BibLaTeX format as a ```.bib``` file and your desired citation style in a ```.csl``` file, then specify their locations in ``` thesis.typ```
