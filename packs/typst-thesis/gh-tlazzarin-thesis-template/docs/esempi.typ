#import "../config/thesis-config.typ": glpl, gl, linkfn
#import "../config/variables.typ": myTutor
#import "@preview/codly:1.3.0": *
#import "@preview/chronos:0.2.1"
#pagebreak(to:"odd")

= Esempi
#text(style: "italic", [
  Questo capitolo serve a mostrare le varie cose che si possono fare con le librerie e questo template.
])
#v(1em)

#align(center)[*#link("https://typst.app/docs")*]
#figure(
  caption: [Schema delle dipendenze.],
  image("schema-dipendenze.png", width: 80%)
)
== Bibliografia
Per la gestione della bibliografia leggi il file `appendix/bibliography/bibliography.typ`.
Le citazioni si fanno con \@ es. @models-and-fair-use.

== Blocchi di codice
È possibile inserire blocchi di codice usando la libreria #linkfn("https://typst.app/universe/package/codly/")[Codly] (dopo averla importata).
Il logo e i colori del testo sono gestiti dalla libreria Codly-languages.
I blocchi di codice vanno sempre dentro una figure così da inserirli nell'indice e poterli riferire nel testo, ad esempio: @fig:codice-esempio.
#figure(
  caption: [Breve descrizione],
  ```c
  #include <stdio.h>
  
  int main(void){
    printf("hello, world\n");
    return 0;
  }
  ```
)<fig:codice-esempio>
Se vuoi mostrare un semplice comando da inserire nella shell puoi disattivare temporaneamente Codly:
#v(1em)
#codly-disable()
  ```sh
  $ ping google.com
  ```
== Continuous Integration
È possibile aggiungere uno script che compila il codice ad ogni push (`build`) e pubblica il PDF su GitHub pages (`deploy`). Questo script va inserito in `.github/workflows/main.yaml`\
Nota bene: se scegli di usare dei font diversi da quelli inclusi in Typst o installati nel runner verrà usato un font di default.
#figure(
  caption: [GitHub CI],
  ```yaml
  name: Build and deploy
  on:
    push:
      branches:
        - main
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - name: Checkout
          uses: actions/checkout@v3
        - name: Typst compile
          run: typst c thesis.typ --pdf-standard a-3b
        - name: Upload artifact
          uses: actions/upload-artifact@v4
          with:
            name: PDF
            path: thesis.pdf
    deploy:
      needs: build
      runs-on: ubuntu-latest
      permissions:
        contents: write
        pages: write
        id-token: write
      environment:
        name: github-pages
        url: ${{ steps.deployment.outputs.page_url }}
      steps:
        - name: Download artifacts
          uses: actions/download-artifact@v4
          with:
            name: PDF
        - name: Upload artifact
          uses: actions/upload-pages-artifact@v3
          with:
            path: "."
        - name: Deploy to GitHub Pages
          id: deployment
          uses: actions/deploy-pages@v4
  ```
)
  
== Funzione `linkfn`
Questa funzione mi è tornata utile durante il capitolo di studio delle tecnologie. Mette il link sia sul testo che nella footnote in modo da rendere il testo "accessibile" anche per la stampa.\
Esempi:\
#v(1em)
#linkfn("https://typst.app")[Typst] è un linguaggio di typesetting...\
#v(1em)
#linkfn("https://nodejs.org", "Node.js") è ...\
#v(1em)
#linkfn("https://typescriptlang.org", [Typescript]) è ...\
#v(1em)
Nota: In Typst ci sono più modi di invocare una funzione che accetta del `content` (trailing content). #link("https://typst.app/docs/reference/foundations/function/")

== Grafici vari
Con le librerie del #linkfn("https://typst.app/universe")[Typst Universe] è possibile creare grafici avanzati. Ad esempio utilizzando #linkfn("https://typst.app/universe/package/chronos")[Chronos] ho creato il diagramma in @fig:diagramma-git.
#figure(
  chronos.diagram({
    import chronos: *
    _par("wd", display-name: "Working directory")
    _par("staging", display-name: "Staging area")
    _par("local", display-name: "Local repository")
    _par("remote", display-name: "Remote repository")
    
    _seq("wd", "staging", comment: [`git add <path>`], comment-align: "center")
    _seq("staging", "local", comment: [`git commit`], comment-align: "center")
    _seq("local", "remote", comment: [`git push`], comment-align: "center")
    _seq("remote", "local", comment: [`git fetch`], comment-align: "center")
    _seq("remote", "wd", comment: [`git pull`], comment-align: "center")
  }),
  caption: [Diagramma di sequenza con i principali comandi di Git.]
)<fig:diagramma-git>

== Glossario
Come scritto nel file `/config/thesis-config.typ` ho creato dei wrapper per poter personalizzare l'aspetto dell'output.\
La lista dei termini è in `/appendix/terms.typ`.\
I possibili attributi sono elencati in questo link:\
#link("https://github.com/typst-community/glossarium?tab=readme-ov-file#registering-the-glossary")\
Esempio: #gl("ci")

== Riferimenti<cap:riferimenti>
Ti consiglio di categorizzare i riferimenti con dei prefissi ad esempio `cap` per i capitoli `fig` per le figure ecc.\
Documentazione sui riferimenti: #link("https://typst.app/docs/reference/model/ref").

== User stories e tracciamento requisiti
Se devi lavorare con i diagrammi degli use case direttamente in Typst è fattibile ma un po' complicato.
Fai riferimento alla documentazione di questo progetto di SWE:
- #link("https://techminds-unipd.github.io/docs/PB/documenti_esterni/analisi_requisiti/analisi-dei-requisiti.pdf")
- #link("https://github.com/techminds-unipd/docs/blob/main/PB/documenti_esterni/analisi_requisiti/include/use_cases.typ")
#v(1em)
Il tracciamento dei requisiti viene fatto attraverso la tabella in `/chapters/data/requirements_list.typ`
Questo permette di:
- Conteggiare in maniera corretta i requisiti.
- Creare la @tab:riepilogo-requisiti e la @tab:requisiti-soddisfatti
#v(1em)
#align(center)[*Se non ti serve togli tutto.*]
