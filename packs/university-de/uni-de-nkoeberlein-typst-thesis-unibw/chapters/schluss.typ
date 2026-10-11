#import "../lib/styles.typ": tip

= Schlussbetrachtung
<chap-schluss>

Die Schlussbetrachtung fasst die wesentlichen Erkenntnisse zusammen, reflektiert
Einschränkungen der Vorlage und gibt einen Ausblick auf mögliche Erweiterungen.

== Zusammenfassung

Im Rahmen dieser Beispiel-Arbeit wurde eine vollständige Typst-Vorlage für wissenschaftliche
Arbeiten vorgestellt. Es konnte gezeigt werden, dass die Vorlage folgende Kernanforderungen
erfüllt:

- *Professionelles Layout:* Korrekte Seitenränder, Kopf- und Fußzeilen sowie automatische
  Kapitelnummerierung im Format „1.2.3".
- *Integrierte Verzeichnisse:* Inhaltsverzeichnis, Abbildungsverzeichnis,
  Tabellenverzeichnis, Codeverzeichnis und Literaturverzeichnis werden aus dem Inhalt
  generiert — ohne manuelle Pflege.
- *Flexible Struktur:* Neue Kapitel lassen sich einfach hinzufügen; die Reihenfolge ist
  zentral in `main.typ` steuerbar.
- *Glossar-Integration:* Abkürzungen wie @ki, @api oder @pdf werden beim ersten Auftreten
  ausgeschrieben und danach in Kurzform angezeigt. Das Glossar im Anhang enthält
  automatische Rückverweise.
- *Nummerierte Gleichungen:* Mathematische Formeln wie @eq-einstein können über
  `#figure()` nummeriert und im Text referenziert werden.
- *Code-Listings:* Eingebautes Syntax-Highlighting für über 100 Sprachen ohne externe
  Pakete.

== Limitationen

Trotz der umfassenden Funktionalität weist die Vorlage einige Einschränkungen auf:

- Die Vorlage ist auf deutsche Hochschulen (insbesondere UniBw / Universität Regensburg)
  zugeschnitten. Für andere Institutionen müssen ggf. Logo, Eidesstattliche Erklärung
  und Schreibkonventionen angepasst werden.
- Die Schriftart *Bookerly* ist optional — ohne `--font-path fonts` fällt Typst auf
  *Libertinus Serif* zurück. Das @pdf sieht dann leicht anders aus.
- Der Druck-Modus (`is-print = true` in `main.typ`) erzwingt Kapitel auf ungeraden Seiten
  und kann zu leeren Seiten führen. Für die reine Bildschirmansicht empfiehlt sich
  `is-print = false`.
- Einige fortgeschrittene LaTeX-Pakete (z. B. TikZ für komplexe Grafiken) haben keine
  direkte Typst-Entsprechung.

== Ausblick

Für zukünftige Weiterentwicklungen der Vorlage sind folgende Punkte denkbar:

1. *Zitationsstile konfigurierbar machen:* Derzeit ist IEEE voreingestellt. Eine
   Konfigurationsvariable für APA, Chicago oder MLA wäre hilfreich.
2. *SVG-Grafiken:* Typst unterstützt SVG nativ — eine Anleitung für vektorbasierte
   Diagramme (z. B. aus draw.io oder Inkscape) wäre wertvoll.
3. *Interaktive Elemente im @pdf:* Für den Online-Modus könnten Hyperlinks und
   Lesezeichen weiter optimiert werden.
4. *Fach-spezifische Erweiterungen:* Anpassungen für Naturwissenschaften
   (erweiterte Mathe-Features), Jura (Fußnoten-Zitationen) oder Medizin (spezielle
   Tabellenformate).

#tip[
  *Tipp für deine eigene Arbeit:* Starte früh mit der Struktur! Befülle `metadata.typ`,
  lege deine Kapitel in `main.typ` an und beginne Abschnitte zu schreiben — auch wenn der
  Inhalt noch lückenhaft ist. Die Vorlage wächst mit deinen Anforderungen.

  Nutze `make watch` für Live-Vorschau und einen PDF-Viewer mit Auto-Reload (z. B.
  Evince, Okular oder Zathura), um Änderungen sofort zu sehen.
]
