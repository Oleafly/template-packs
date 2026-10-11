// chapters/13-wasm-meta.typ — WASM-Plugins und Metaprogrammierung

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [WASM-Plugins und Metaprogrammierung],
  lead: [
    Typst kompiliert WebAssembly (WASM) Plugins nativ — ohne externe Tools oder zusätzliche Build-Schritte. Dieses Kapitel demonstriert drei Pakete, die diese Fähigkeit nutzen, um Layout-Engines, Skript-Runtimes und Dokumentations-Generatoren direkt in den Kompiliervorgang einzubetten.
  ],
)

// ════════════════════════════════════════════════════════════════
== Graphviz direkt in Typst mit Diagraph

#import "@preview/diagraph:0.3.7": *

#figure(
  raw-render(
    ```dot
    digraph G {
      node [shape=box, style=filled, fillcolor="#e0f2fe", fontname="Libertinus Serif"];
      Symptom -> Differential;
      Differential -> Test;
      Test -> Diagnose [color="#0284c7", penwidth=2];
      Test -> Ausschluss;
    }
    ```
  ),
  caption: [Diagnostischer Entscheidungsbaum — direkt aus DOT-Syntax via WASM-Plugin gerendert.],
  alt: "Flussdiagramm: Symptom führt zu Differenzialdiagnose, dann zu Test, der zu Diagnose oder Ausschluss verzweigt.",
)

#key-concept(term: [WASM-Purity])[
  Das WASM-Sicherheitsmodell in Typst (WASM-Purity) erfordert deterministische Funktionen: Gleiche Eingaben erzeugen immer die gleiche Ausgabe. Dies erlaubt es dem Compiler, Ergebnisse aggressiv zu cachen und parallel auszuführen.
]

#callout(tone: "info")[
  Im Gegensatz zu Fletcher (siehe Kapitel 8) delegiert Diagraph das Layout vollständig an die Graphviz-Algorithmen. Dies ist ideal für automatische Knotenpositionierung, während Fletcher mehr manuelle Kontrolle bietet.
]

// ════════════════════════════════════════════════════════════════
== API-Dokumentation aus Docstrings mit Tidy

#import "@preview/tidy:0.4.3"

// PDF/UA-konformer tidy-Style: Funktionen aus dem minimal-Style, aber die
// Parameter-Signatur mit eingebettetem Mono-Font statt „Cascadia Mono". Der
// minimal-Style rendert die „Parameters"-Zeile als fetten Text statt als
// Überschrift mit context-Ausdruck — Letzteres bricht das PDF/UA-Tagging.
#let _ua-param-list(fn, style-args) = {
  block(fill: rgb("#d8dbed"), width: 100%, inset: (x: 0.5em, y: 0.7em), {
    set text(font: fonts.mono, size: 0.85em)
    text(fn.name, fill: rgb("#1f2a63"))
    "("
    let items = ()
    for (name, info) in fn.args {
      let types = ""
      if "types" in info { types = ": " + info.types.map(x => (style-args.style.show-type)(x)).join(" ") }
      items.push(box(name + types))
    }
    items.join(", ")
    ")"
    if fn.return-types != none {
      box[~-> #fn.return-types.map(x => (style-args.style.show-type)(x)).join(" ")]
    }
  })
}

#let _ua-tidy-style = (
  show-outline: tidy.styles.minimal.show-outline,
  show-type: tidy.styles.minimal.show-type,
  show-function: tidy.styles.minimal.show-function,
  show-parameter-list: _ua-param-list,
  show-parameter-block: tidy.styles.minimal.show-parameter-block,
  show-variable: tidy.styles.minimal.show-variable,
  show-reference: tidy.styles.minimal.show-reference,
  show-example: tidy.styles.minimal.show-example,
)

#figure(
  card(
    tidy.show-module(
      tidy.parse-module(```typ
/// Formatiert den Namen eines Patienten gemäß den Datenschutzrichtlinien.
///
/// - name (string): Der volle Name des Patienten.
/// - anonymize (boolean): Ob der Name abgekürzt werden soll.
/// -> string
#let format-patient(name, anonymize: false) = {
  // Implementation
}
```.text),
      style: _ua-tidy-style,
      show-module-name: false,
    )
  ),
  caption: [Automatisch generierte API-Referenz — Tidy analysiert Docstrings direkt zur Kompilierzeit.],
  alt: "Automatisch generierte API-Referenz der Funktion format-patient mit den Parametern name und anonymize und Rückgabetyp string.",
)

#side-note(title: [Introspection])[
  Tidy demonstriert "Code analysiert Code" — eine der fortschrittlichsten Anwendungen von Typsts Introspection- und String-Parsing-Fähigkeiten kombiniert in einem Paket.
]

// ════════════════════════════════════════════════════════════════
== JavaScript-Auswertung via WASM mit CtxJS

#import "@preview/ctxjs:0.5.0"

Manchmal reicht die native Typst-Skriptsprache nicht aus oder es existieren bereits komplexe Berechnungen in JavaScript. CtxJS#index[CtxJS] bettet eine vollständige QuickJS-Runtime über WASM#index[WebAssembly] ein.

#let js-code = "Math.round(Math.pow(1.05, 10) * 100) / 100"
#let js-ctx = ctxjs.new-context()
// ctxjs 0.5.0: ctx.eval gibt nun ein (context, value)-Tupel zurück → destrukturieren.
#let (_, js-result) = ctxjs.ctx.eval(js-ctx, js-code)

#figure(
  card()[
    *JS-Ausdruck:* `Math.round(Math.pow(1.05, 10) * 100) / 100`
    *Ergebnis via CtxJS:* #js-result
  ],
  caption: [Auswertung mathematischer Formeln über die eingebettete JS-Runtime.],
  alt: "Karte mit einem JavaScript-Ausdruck und seinem über die eingebettete CtxJS-Runtime berechneten Ergebnis.",
)

#callout(tone: "warning")[
  Sicherheits- und Performance-Implikationen: CtxJS bettet eine vollständige JS-Runtime ein, was die Kompilierzeit erhöhen kann. Es sollte sparsam und gezielt eingesetzt werden.
]

// ════════════════════════════════════════════════════════════════
#callout(tone: "info", title: [Das WASM-Plugin-Protokoll])[
  Das `wasm-minimal-protocol` definiert, wie Plugins Speicher allozieren, Byte-Buffer übergeben und Erfolg oder Fehler signalisieren. Ein fortschrittliches Beispiel ist `@preview/mephistypsteles`, welches Teile von Typsts eigenem Parser in WASM kompiliert, um ASTs zu erzeugen. Solche Pakete sind rechenintensiv und primär für Tooling-Entwickler interessant.
]
