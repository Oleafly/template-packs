// =============================================================
// colors.typ – Farbpalette
// =============================================================

// --- Hauptpalette ---
// Kein Blau: professionelles Dunkelgrau / Charcoal als Primärfarbe
#let primary = rgb(28, 28, 28)
#let secondary = rgb(101, 97, 101)   // #656165
#let accent = rgb(244, 103, 23)      // #f46717

// --- Grautöne ---
#let darkgray = rgb(64, 64, 64)
#let lightgray = rgb(192, 192, 192)
#let verylightgray = rgb(240, 240, 240)

// --- Semantische Farben ---
#let success = rgb(38, 130, 60)      // gedämpftes Grün
#let warning = rgb(170, 110, 0)      // dunkles Amber
#let danger = rgb(165, 35, 45)       // tiefes Rot
#let info = rgb(75, 95, 115)         // Schiefergrau (kein Cyan)

// --- Code-Farben ---
#let codebackground = rgb(248, 248, 248)
#let codeborder = rgb(220, 220, 220)

// --- Kompatibilitäts-Aliase (ehemals unibwone) ---
#let unibwone = primary             // kein Blau mehr
#let unibwtwo = secondary

// --- Semantische Aliase ---
#let headingcolor = primary
#let linkcolor = accent
#let textcolor = black
