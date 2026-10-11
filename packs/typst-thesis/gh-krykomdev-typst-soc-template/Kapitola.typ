#import "Template/Commands.typ": *

= Ukázky <ch-examples>

Tady najdeš ukázky různých věcí, které můžeš vkládat do své práce. Všechny tyto věci jsou samozřejmě jen 
ukázky, které ti mají pomoci s představou, jak věci vypadávají a jak je můžeš používat. Všechny tyto věci 
jsou navíc nastavené tak, aby odpovídaly stylu této šablony, takže se nemusíš bát, že by něco nevypadalo 
dobře.

== Vkládání kapitol a nadpisů

Kapitoly / nadpisy lze jednoduše vkládat pomocí `=`, `==`, atd. Jak to vypadá, můžeš vidět na ukázce @c-chapters.

#code(
  ```typst
  = Nadpis 1. úrovně
  == Nadpis 2. úrovně
  === Nadpis 3. úrovně
  ==== Nadpis 4. úrovně
  ```,
  caption: "Vkládání kapitol (nadpisů)",
  label: "c-chapters"
)

== Obrázky

Vkládání obrázků je jednoduché. Stačí použít příkaz `#img` a do něj vložit cestu k obrázku. Můžeš 
také přidat popisek a štítek pro odkazování. Ukázku toho, jak to vypadá, můžeš vidět na ukázce @c-image
a také na obrázku @i-obrazek.

#img("Assets/Image.png", caption: "Popisek obrázku", label: "i-obrazek")

#code(
  ```typst
  #img("Assets/Image.png", caption: "Popisek obrázku", label: "i-obrazek")
  ```,
  caption: "Vkládání obrázků",
  label: "c-image"
)

== Poznámky pod čarou

Poznámky pod čarou jsou užitečné pro doplňující informace, které by v hlavním textu působily
rušivě. Vkládají se pomocí příkazu `#footnote`.

Věta s jednoduchou poznámkou pod čarou. #footnote("Toto je text poznámky pod čarou.") 
Můžete mít i delší poznámky, které obsahují formátování, jako je *tučný text* 
nebo dokonce odkazy. #footnote[
  Tato poznámka pod čarou je definována pomocí hranatých závorek `[]`, což umožňuje
  vkládat komplexnější obsah včetně odkazů: https://typst.app
]

== Tabulky

Tabulky se vkládají pomocí příkazu `#tbl`. Do něj vložíš data, která se mají zobrazit v tabulce. 
Pokud chceš přidat hlavičku, můžeš ji vložit jako první řádek a označit ji jako hlavičku pomocí 
`header`. Ukázku toho, jak to vypadá, můžeš vidět na ukázce @c-table. Výslednou tabulku můžeš vidět zde:

#tbl(
  header: ([Sloupec 1], [Sloupec 2], [Sloupec 3]),
  caption: "Popisek tabulky",
  label: "t-tabulka",
  [Data 1], 
  [Data 2],
  [Data 3],
  [Data 4], 
  [Data 5],
  [Data 6],
)

#code(
  ```typst
  #tbl(
    header: ([Sloupec 1], [Sloupec 2], [Sloupec 3]),
    caption: "Popisek tabulky",
    label: "t-tabulka",
    [Data 1], [Data 2], [Data 3],
    [Data 4], [Data 5], [Data 6],
  )
  ```,
  caption: "Vkládání tabulek",
  label: "c-table"
)

== Kódové bloky

Kódové bloky se vkládají pomocí příkazu `#code`. Do něj vložíš kód, který se má zobrazit. Můžeš také 
přidat popisek a štítek pro odkazování. Ukázku toho, jak to vypadá, můžeš vidět na ukázce @c-code.

#code-input(
  "/Snippets/code-block.typ",
  lang: "typst",
  caption: "Ukázka vložení kódového bloku pomocí code-input",
  label: "c-code"
)

Třetím způsobem, jak vložit kódový blok, je pomocí příkazu `#code-input`.
Do něj vložíš cestu k souboru s kódem, jazyk, ve kterém je kód napsaný, a můžeš přidat popisek
a štítek pro odkazování. Ukázku toho, jak to vypadá, můžeš vidět na ukázce @c-code-input.

#code-input(
  "/Snippets/code-input.typ",
  lang: "typst",
  caption: "Ukázka vložení kódového bloku pomocí code-input",
  label: "c-code-input"
)

== Rovnice

Rovnice apod. lze vkládat například pomocí #raw((sym.dollar, sym.dollar).join()) pro matematické
bloky uvnitř textu a dolary posazené na různé řádky označují matematiký blok. Mezi dolary
pak jednoduše vložíš latexový matematický výraz. Pokud chceš přidat štítek pro odkaz,
za uzavírací dolar vlož do špičatých závorek (`<>`) název štítku. Matematický
blok v textu pak může vypadat takto $f(x) = x^2$ a blok mimo jako je ukázáno na příkladu
@eq-sum.

$
  sum_(i in NN) 1 + i
$ <eq-sum>

== Citace a bibliografie <zdroje>

Správné citování zdrojů je v práci SOČ klíčové. Šablona používá soubor `literatura.bib`
pro správu tvých zdrojů.

=== Jak citovat?
Citujeme pomocí funkce `#cite(<label>)`, kde `<label>` je klíč v `.bib` souboru.
- Citace článku: @sample2026
- Citace knihy: @kniha2024
- Citace webové stránky: @typst-docs

Můžeš také citovat více zdrojů najednou: @sample2026 @kniha2024. Pokud chceš, aby citace byla 
součástí věty (např. "Podle Nováka..."), můžeš použít volitelný parametr:
#cite(<kniha2024>, form: "prose") uvádí, že psaní SOČ je zábava.

=== Formátování bibliografie
Zdroje se vkládají do souboru `literatura.bib` ve formátu BibLaTeX. Zde je ukázka, jak 
vypadá záznam pro knihu:

#code(
  ```bibtex
  @book{kniha2024,
    author = {Novák, Jan},
    title = {Jak napsat skvělou SOČ},
    publisher = {Vydavatelství odborné literatury},
    year = {2024},
    address = {Praha},
    isbn = {978-80-123-4567-8}
  }
  ```,
  caption: "Ukázka záznamu v literatura.bib",
  label: "c-bib-example"
)

Samotný seznam literatury se vygeneruje automaticky na konci dokumentu pomocí příkazu
`#bibliography("literatura.bib")`, který je již umístěn v `Main.typ`.
