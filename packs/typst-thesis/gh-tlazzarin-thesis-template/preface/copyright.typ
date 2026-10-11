#import "../config/variables.typ" : myName, myTitle, myDegree, myTime
#import "../config/constants.typ" : copyright

#set page(numbering: none)

#align(left + bottom, [
    #sym.copyright #myName, #myTime. #copyright. #text(myDegree): #text(style: "italic", myTitle).
])
