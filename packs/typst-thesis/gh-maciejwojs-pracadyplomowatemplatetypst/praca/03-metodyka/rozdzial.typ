#import "/szablon/template.typ": rysunek, tabela, rys, tab, wzor, cytat

= Metodyka i przykład formatowania
Poniższe elementy pokazują skład wymagany przez wytyczne wydziału. Przed oddaniem pracy zastąp je własną treścią. Rysunek, tabela i wzór pojawiają się dopiero po odesłaniu do nich w tekście.

Odwołanie do literatury zapisuje się stylem harwardzkim: #cite(<arnak2013>, form: "prose") opisuje zarządzanie produkcją, a szczegół można wskazać z numerem strony #cite(<arnak2013>, supplement: [s. 12]). Dwie prace tego samego autora w jednym nawiasie składa się rosnąco według roku #cite(<nowak2001>) #cite(<nowak2003>). Przy dwóch autorach podaje się oba nazwiska #cite(<michalek2002>), przy trzech za pierwszym razem wszystkie #cite(<nowak2010>), a przy kolejnym odwołaniu skrót #cite(<nowak2010>). Od czterech autorów od razu zostaje pierwsze nazwisko #cite(<nowak2011>). Cytuje się też artykuł #cite(<michalek2013>), rozdział #cite(<kowalski2002rozdz>), pracę pod redakcją #cite(<kowalski2002red>), normę #cite(<pniso690>) i źródło internetowe #cite(<kowalski1999>).

Krótki cytat wchodzi w zdanie i dostaje cudzysłów: „tekst przytoczony dosłownie” #cite(<nowak2001>, supplement: [s. 8]). Dłuższy cytat, od około 40 słów, wydziela się z tekstu głównego bez cudzysłowu.
#cytat(
  [Tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany tekst cytowany.],
  odsylacz: cite(<nowak2003>, supplement: [s. 12–14]),
)

Przypis dolny uzupełnia informację poboczną i nie zastępuje odwołania do literatury#footnote[Przypisy numeruje się kolejno w całej pracy i umieszcza na dole strony, której dotyczą.].

Układ dzielnika pokazano na #rys(<dzielnik>). Rezystory $R_1$ i $R_2$ wyznaczają napięcie wyjściowe. Zależność prądu, napięcia i impedancji zapisuje wzór (@dzielnik-prad).

#wzor(objasnienia: [
  gdzie: \
  $I$ -- natężenie prądu [A], \
  $U$ -- napięcie [V], \
  $Z$ -- impedancja [$Omega$].
])[$ I = U / Z $ <dzielnik-prad>]

#rysunek(
  {
    set text(size: 10pt)
    box(width: 6.8cm, height: 4.4cm)[
      #place(dx: 1.5cm, dy: 0.35cm, line(length: 3.4cm, stroke: 0.9pt))
      #place(dx: 1.5cm, dy: 3.85cm, line(length: 3.4cm, stroke: 0.9pt))
      #place(dx: 1.5cm, dy: 0.35cm, line(angle: 90deg, length: 3.5cm, stroke: 0.9pt))
      #place(dx: 4.9cm, dy: 0.35cm, line(angle: 90deg, length: 3.5cm, stroke: 0.9pt))
      #place(dx: 2.3cm, dy: 2.1cm, line(length: 2.35cm, stroke: 0.9pt))
      #place(dx: 4.65cm, dy: 0.95cm, rect(width: 0.5cm, height: 0.95cm, stroke: 0.9pt, fill: white))
      #place(dx: 4.65cm, dy: 2.35cm, rect(width: 0.5cm, height: 0.95cm, stroke: 0.9pt, fill: white))
      #place(dx: 5.3cm, dy: 1.15cm)[$R_1$]
      #place(dx: 5.3cm, dy: 2.55cm)[$R_2$]
      #place(dx: 0.15cm, dy: 1.85cm)[$U$]
      #place(dx: 2.55cm, dy: 2.25cm)[$U_"wy"$]
    ]
  },
  [Schemat dzielnika napięcia],
  zrodlo: [opracowanie własne],
) <dzielnik>

Zależności między książką, zamówieniem i użytkownikiem pokazano na #rys(<model-dziedziny>). Kategoria grupuje książki, a zamówienie składa się z pozycji powiązanych z konkretnym tytułem.

#rysunek(
  image("sources/example.png", width: 100%),
  [Diagram klas modelu dziedziny],
  zrodlo: [opracowanie własne],
) <model-dziedziny>

Wartości zebrane w toku pomiaru zestawiono w #tab(<jakosc>). Tej samej serii liczb nie powtarza się równolegle na wykresie.

#tabela(
  [Średnie wartości współczynnika jakości],
  table(
    columns: (1fr, 1fr, 1fr, 1.2fr),
    align: center,
    [Typ], [Podtyp], [Średnia], [Odchylenie],
    [A], [II], [1,25], [0,04],
    [B], [II], [3,28], [0,50],
  ),
  zrodlo: [opracowanie własne na podstawie danych z GUS za rok 2013],
) <jakosc>

Fragment programu składa się czcionką Courier New, 10 pkt, z pojedynczą interlinią.

```
def dzielnik(u_we, r1, r2):
    return u_we * r2 / (r1 + r2)
```

Wyliczenie w pracy prowadzi się jednym, ustalonym sposobem:
- pierwsza pozycja kończy się średnikiem;
- kolejna również;
- ostatnia kończy się kropką.
