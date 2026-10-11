#import "../libs.typ": *

= Kompilacja dokumentu

Niniejszy szablon może być stosowany bezpośrednio w serwisie `typst.app`. Zaleca się jednak, z uwagi na ochronę własności intelektualnej i zapobieganie analizowaniu dokumentu przez obce podmioty, instalację kompilatora `Typst` na własnym komputerze. Kompilator ten dostępny jest w zasadzie dla każdej dystrybucji systemu operacyjnego z rodziny `GNU/Linux`, `MacOS` oraz `Windows`. Oprogramowanie dostarczane jest zwykle w postaci pojedynczego pliku, a importowane biblioteki są pobierane automatycznie.

Dysponując powłoką zgodną z `bash` istnieje możliwość uruchomienia skryptu `build.sh`, który dokona konwersji obrazów z formatu programu `LibreOffice` do formatu `PDF`, a następnie wygeneruje w folderze projektu plik `main.pdf` z gotowym dokumentem. Kompilator `Typst` uruchomić można również w trybie śledzenia zmian pliku, stosując opcję `watch` zamiast `compile`.

#figure(
  caption: [Budowa projektu],
)[
  #raw(read("../build.sh"), lang: "bash", block: true)
]
<lst:build>

Należy zauważyć, że kompilacja dokumentu jest znacznie szybsza, niż w przypadku stosowania kompilatorów `LaTeX`. Możliwy jest zatem podgląd dokumentu "na żywo", zarówno stosując aplikację webową `typst.app`, jak i klasyczny edytor tekstu oraz polecenie ```bash typst watch main.typ```.
