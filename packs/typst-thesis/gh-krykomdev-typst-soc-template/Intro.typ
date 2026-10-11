#import "Template/Commands.typ": code
#import "Kapitola.typ": *

= Úvod

Ahoj a vítej v této šabloně pro práce SOČ vytvořené v sázecím systému *Typst*. Tato kapitola
ti pomůže se zorientovat jak v samotném Typstu, tak v této šabloně, aby tvé psaní bylo
co nejplynulejší.

== Co je to Typst?

Typst je moderní sázecí systém, který je navržen jako rychlejší a uživatelsky přívětivější
alternativa k LaTeXu. Jeho hlavními výhodami jsou:
- *Rychlost:* Dokument se překládá okamžitě při každém uložení.
- *Jednoduchost:* Syntax je inspirovaná Markdownem, takže je velmi snadno čitelná.
- *Skriptování:* Typst má vlastní programovací jazyk, který umožňuje snadnou tvorbu komplexních prvků.

== Struktura projektu

Aby ses v šabloně neztratil(a), zde je krátký popis toho, co kde najdeš:
- `Main.typ`: Hlavní soubor. Zde se nastavují informace o práci a vkládají se jednotlivé kapitoly.
- `Intro.typ`, `Kapitola.typ`: Soubory s textem tvé práce. Můžeš si vytvořit libovolné množství dalších `.typ` souborů.
- `Template/`: Obsahuje "jádro" šablony (vzhled, příkazy, konfiguraci). Většinou sem nebudeš muset zasahovat.
- `Assets/`: Složka pro tvé obrázky.
- `Fonts/`: Zde jsou uložené fonty použité v šabloně (např. Consolas pro kód).
- `literatura.bib`: Soubor pro tvoje zdroje v bibliografickém formátu BibLaTeX.

== Jak psát v Typstu?

Psaní textu je velmi podobné psaní v Markdownu:
- *Tučný text* napíšeš jako `*tučný text*`.
- _Kurzívu_ napíšeš jako `_kurzíva_`.
- `Monospace` (kód v textu) napíšeš pomocí zpětných apostrofů: \`kód\`.
- Odkazy na sekce, obrázky či tabulky děláme pomocí `@` a názvu štítku (např. `@ch-examples`).

=== Seznamy
Jednoduchý seznam vytvoříš pomocí pomlček nebo plusů:
- První položka
- Druhá položka
  - Podpoložka

Číslovaný seznam vytvoříš pomocí číslice s tečkou:
1. První bod
2. Druhý bod

== Práce s Main.typ

Jak už bylo zmíněno, `Main.typ` je mozkem celé práce. Nejdůležitější částí je blok `#show: project.with(...)`,
který vidíš na ukázce @c-config.

#code(
  ```typst
  #show: project.with(
    title:      "Název tvé práce",
    author:     "Tvé Jméno",
    school:     "Tvoje Škola",
    // ... další nastavení
    ai: use-ai(
      model: "ChatGPT-4", 
      usage: "úpravy stylistiky"
    ),
  )
  ```,
  caption: "Ukázka nastavení v Main.typ",
  label: "c-config"
)

=== Prohlášení o AI
Důležitou součástí moderních prací je přiznání použití AI. V šabloně jsou pro to připraveny dvě funkce:
1. `ai: no-ai()`: Pokud jsi AI vůbec nepoužil(a).
2. `ai: use-ai(model: "...", usage: "...")`: Pokud jsi AI použil(a) (např. pro kontrolu gramatiky nebo generování částí kódu).

== Tipy pro psaní

1. *VS Code:* Doporučujeme používat editor Visual Studio Code s rozšířením *Tinymist Typst*, které nabízí skvělý náhled a napovídání kódu.
2. *Webová aplikace:* Pokud nechceš nic instalovat, můžeš použít oficiální [Typst web app](https://typst.app).
3. *Dokumentace:* Pokud budeš hledat, jak udělat něco specifického, oficiální [dokumentace Typstu](https://typst.app/docs/) je velmi přehledná a plná příkladů.

Další praktické ukázky vkládání obrázků, tabulek a kódu najdeš v kapitole @ch-examples. Pokud se ti šablona líbí, budu rád za hvězdičku na GitHubu!
