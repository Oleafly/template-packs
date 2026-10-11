// Öffentliche Schnittstelle der Vorlage.
//
// In `thesis.typ` und in den Kapiteldateien wird ausschließlich diese Datei importiert.
//
//   #import "hfu/lib.typ": *        (in thesis.typ)
//   #import "../hfu/lib.typ": *     (in inhalt/… und anhang/…)
//
// Dadurch kann sich der Aufbau von `hfu/` ändern, ohne dass Kapitel angepasst werden müssen.

// Dokumentgerüst — wird in thesis.typ als Show-Rule angewendet.
#import "layout.typ": hfu-thesis

// `ac` folgt der bekannten Kurzform aus dem LaTeX-Paket `acronym`.
// Die übrigen Bausteine tragen bewusst selbsterklärende deutsche Namen.
#import "abkuerzungen.typ": ac
#import "elemente.typ": abbildung, monatsbericht, quellcode, quellcode-datei
#import "elemente.typ": querformat, tabelle
