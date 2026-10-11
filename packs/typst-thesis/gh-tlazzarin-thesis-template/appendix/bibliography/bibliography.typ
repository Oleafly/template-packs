#pagebreak()
// #pagebreak(to: "odd")

/*
Typst supporta due tipi di file per la bibliografia: 
- Bibtex: il classico formato preso da Latex 
- Hayagriva: nuovo formato basato su yaml molto più versatile
Per convertire da Bibtex a Hayagriva puoi usare https://jonasloos.github.io/bibtex-to-hayagriva-webapp/

Typst bibliography: https://typst.app/docs/reference/model/bibliography
Hayagriva format:   https://github.com/typst/hayagriva/blob/main/docs/file-format.md

Ci sono vari stili per fare le citazioni, come riportato nella documentazione. 
Quello di default è IEEE ma alla fine è preferenza tua o del relatore
*/
#bibliography("bibliography.yml") <bibliography>
