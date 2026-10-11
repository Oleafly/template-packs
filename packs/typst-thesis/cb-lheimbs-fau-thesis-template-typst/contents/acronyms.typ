#import "../config.typ": acronyms-name-plural, glossary-entry-list
#import "../lib.typ": chapter
#import "@preview/glossarium:0.5.10": print-glossary

#chapter(numbering: none, outlined: false)[#acronyms-name-plural]
<chapter:acronyms>

#print-glossary(glossary-entry-list, show-all: true, disable-back-references: true)
