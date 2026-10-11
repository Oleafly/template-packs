

= Eksempler

Der vil nu vises nogle eksempler af ting man kan lave i Typst.

== Referencer til bøger

For at referere til en bog skal bogens information ligge i `bibliography.bib`. Der kan derefter refereres med et `@` symbol:

Den her bog er sej! @rustbook

== Figur
For at lave en figur bruges `#figure()` funktionen. Figuren kan have et billede, en tabel, noget kode etc, og kan også have undertekster.

=== Billede

En figur med et billede kan laves som set nedenunder.
#figure(
  image("../figures/ferris.png", width: 50%),
  caption: [Et billede af Rust's maskot, Ferris.]
) <fig:ferris>

Der kan sættes et tag til sidst af figuren som man kan referere til. Dette gøres med `@{tag}`, f.eks. @fig:ferris.

=== Tabel
En figur med en tabel kan laves som følgende.

#figure(
  table(
    rows: 3, columns: 2, 
    [*Noget*],[*Noget andet*],
    [noget data],[noget andet data],
    [noget mere data],[noget mere andet data]
  ),
  caption: [Tabel over Noget og Noget andet.]
) <tab:nogetognogetandet>

Tabellen kan igen få en undertekst og et tag som kan refereres til: @tab:nogetognogetandet

=== Kode
Kode kan vises i Typst med tre backticks: #raw("```"). Sproget kan sættes i toppen af blokken, f.eks `cs` for C\# og `rs` for Rust. Et eksempel kan ses nedenunder.

```rs
fn main() {
  println!("Hello, World!");
}
```

Koden kan også sættes i en figur blok. Se nedenunder.

#figure(
  ```cs
static void Main() 
{
  Console.WriteLine("Hello, World!");
}
  ```,
  caption: ["Hello, World!" i `C#`.]
) <lis:helloworldcs>

Der kan nu igen refereres til koden @lis:helloworldcs.

=== Matematik
Matematik kan laves i typst med to dollartegn \$\$. Feks $2 + 2 = infinity$. Der kan også laves en hel blok af matematik med et dollar tegn i toppen af bunden, ligesom koden. Se nedenunder.

$
I = integral_0^infinity e^(-x)/(x^2+1) d x
$ <mat:integral>

Der kan nu refereres som følgende @mat:integral.
