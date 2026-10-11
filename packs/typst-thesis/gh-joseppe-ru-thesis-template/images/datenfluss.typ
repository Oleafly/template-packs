#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "../utils/helpers.typ": *
#import "../utils/diagrams.typ": *


#figure(
  [
    #show table: it => text(weight: "thin")[#it]
    #set text(weight: "regular", size: 10pt)
    #diagram(
      spacing: 1cm,

      node(
        (1.5, 0),
        enclose: ((-1, 0), (4, 0)),
        height: 2cm,
        // inset: (top: 25pt, bottom: 15pt, left: 15pt, right: 15pt),
        fill: hatch(rgb("84BF63")),
        layer: -1,
        stroke: (dash: "dashed"),
        align(top + right, text(weight: "bold")[Kontrollebene]),
      ),
      node(
        (1.5, 0),
        enclose: ((-1.5, 1), (4.5, 1)),
        height: 3.5cm,
        // inset: (top: 25pt, bottom: 15pt, left: 15pt, right: 15pt),
        fill: hatch(rgb("84BF63")),
        layer: -1,
        stroke: (dash: "dashed"),
        align(top + right, text(weight: "bold")[Datenebene]),
      ),

      node(
        (0, 0),
        enclose: ((0, 0), (1.2, 2)),
        height: 1.5cm,
        // inset: (top: 25pt, bottom: 15pt, left: 15pt, right: 15pt),
        fill: rgb("8BADDC"),
        layer: -2,
        stroke: (dash: "dashed"),
        align(top, text(weight: "bold")[Fabrik]),
      ),

      node(
        (0, 0),
        enclose: ((1.6, -1.6), (4.7, 2.85)),
        height: 1.5cm,
        // inset: (top: 25pt, bottom: 15pt, left: 15pt, right: 15pt),
        fill: rgb("8BADDC"),
        layer: -2,
        stroke: (dash: "dashed"),
        align(top, text(weight: "bold")[Equipmenthersteller]),
      ),

      // --- Nodes (Knotenpunkte mit Ihrem blob-Befehl) ---
      // Linke Seite (Datenanbieter)
      blob((0, 1), [Verwaltungsschale \ des Digitalen \ Zwillings], name: <aas>),
      blob((0, 2), [Simulation], name: <sim>),
      blob((1, 0), [Connector \ Kontrollebene], name: <cp_prov>),
      blob((1, 1), [Connector \ Datenebene], name: <dp_prov>),

      // Rechte Seite (Datennutzer)
      blob((2, 0), [Connector \ Kontrollebene], name: <cp_cons>),
      blob((2, 1), [Connector \ Datenebene], name: <dp_cons>),
      blob((3, 1), [Client für \ Verwaltungsschale], name: <client>),
      blob((3, 2), [Frontend/ERP-\ Anbindung], name: <front>),


      // --- Edges (Kanten / Datenfluss) ---

      edge(<sim>, <aas>, "->", label: text(weight: "bold")[1], label-side: left),


      // Schritt 2
      edge(<aas>, <cp_prov>, "->", label: text(weight: "bold")[2], label-pos: 0.4, label-side: auto),

      // Schritt 3
      edge(<client>, <cp_cons>, "->", label: text(weight: "bold")[3], label-pos: 0.6, label-side: left),
      edge(
        <cp_cons>,
        <cp_prov>,
        "<->",
        stroke: (dash: "dashed"),
        label: text(weight: "bold")[3],
        label-side: auto,
        label-pos: 0.2,
      ),

      // Schritt 4 (Datenanfrage - Pfeile laufen nach links)
      edge(<client>, <dp_cons>, "->", label: text(weight: "bold")[4], label-side: left, shift: 3pt),
      edge(
        <dp_cons>,
        <dp_prov>,
        "->",
        stroke: (dash: "dashed"),
        label: text(weight: "bold")[4],
        label-side: left,
        shift: 3pt,
        label-pos: 0.1,
      ),
      edge(
        <dp_prov>,
        <aas>,
        "->",
        label: text(weight: "bold")[4],
        label-side: left,
        stroke: (dash: "dashed"),
        shift: 3pt,
      ),

      // Schritt 5 (Antwort - Pfeile laufen nach rechts)
      edge(<aas>, <dp_prov>, "->", label: text(weight: "bold")[5], label-side: left, shift: 3pt),
      edge(
        <dp_prov>,
        <dp_cons>,
        "->",
        stroke: (dash: "dashed"),
        label: text(weight: "bold")[5],
        label-side: left,
        shift: 3pt,
        label-pos: 0.2,
      ),
      edge(
        <dp_cons>,
        <client>,
        "->",
        label: text(weight: "bold")[5],
        stroke: (dash: "dashed"),
        label-side: left,
        shift: 3pt,
      ),

      // Schritt 6
      edge(<client>, <front>, "->", label: text(weight: "bold")[6], label-side: right, label-pos: 0.7),
    ),
  ],
  caption: [Datenfluss über den EDC-Datenraum],
)

<fig:datenfluss>
