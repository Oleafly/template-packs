// cv.typ — punkt wejścia. Ładuje dane i renderuje dokument.
// Kompilacja:  typst compile --font-path fonts cv.typ

#import "template.typ": cv

#cv(yaml("data.yaml"))
