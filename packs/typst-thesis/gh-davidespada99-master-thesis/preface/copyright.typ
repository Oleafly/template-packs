#import "../config/variables.typ" : myName, myTitle, myTitle2, myDegree, myAA, myUni

#set par(first-line-indent: 0em)
#align(left + bottom, [
    #text(myName), #text(style: "italic", myTitle) #text(style: "italic", myTitle2) \
    #text(myDegree) ,  #text(myUni),  #sym.copyright #text(myAA)
 \ \
    _This document was prepared using Typst.   In addition, LLM (Gemini 3 Pro and Claude Sonnet 4.5) were used to perform syntactic and semantic error checking and to provide suggestions for improving overall readability._
])
