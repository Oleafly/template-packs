#import "firstpage.typ" : generateFrontPage

#let init(document, accent : blue, title : "[TITLE]", authors : ("AUTHOR 1", "AUTHOR 2")) =  {
  generateFrontPage(accent,title, authors)
  pagebreak(weak : true) 
  document
}
