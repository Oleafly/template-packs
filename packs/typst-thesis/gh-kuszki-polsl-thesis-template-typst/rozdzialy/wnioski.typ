#import "../libs.typ": *

= Uwagi końcowe

Stosowanie zaproponowanego szablonu pozwala autorowi pracy skupić się wyłącznie na jej treści, pozostawiając kwestie formatowania pracy po stronie szablonu. Oznacza to, że "pracy nie da się sformatować niepoprawnie", dokument "nie rozjeżdża się", a wszystkie jego elementy są spójnie i jednolicie sformatowane.

Niestety, próg wejścia w pracę z systemem składu `Typst` jest dość wysoki, natomiast wciąż znacznie niższy, niż w przypadku `LaTeX`. Odnosi się to jednak przede wszystkim do tworzenia i edycji tego typu szablonów, a nie do stosowania ich. Początkowo pisanie równań, wstawianie obrazków, czy edycja tabel mogą przysparzać kłopotów. Należy jednak zauważyć, że większość czynności może być początkowo wykonywana metodą "kopiuj-wklej" oraz edycją instrukcji załączonej do szablonu. Po nabyciu pewnej wprawy czynności te (w szczególności edycja równań) stają się dużo szybsze i bardziej intuicyjne, niż stosowanie graficznych narzędzi.

Wygenerowanie pliku `PDF` w standardzie `PDF/A-3u` w obecnej wersji `Typst` jest możliwe tylko w przypadku, gdy do dokumentu nie dołącza się innych plików `PDF`. Standard ten służy do długoterminowego przechowywania dokumentów, stąd między innymi wszystkie czcionki oraz schematy kolorów są osadzone w dokumencie. Jest to standardowy format wymagany podczas składania prac dyplomowych, czy dokumentów urzędowych, natomiast nie jest wymagany przez system `APD`.

W porównaniu do systemu składu `LaTeX`, największe ograniczenia `Typst` podczas tworzenia rysunków i wykresów to brak obsługi grafiki w formacie `tikz`. Bardzo dużo narzędzi umożliwia stosowanie tego formatu, a ten z kolei idealnie integruje się z dokumentami `LaTeX`. Biblioteka `cetz` ma na celu zachowanie funkcjonalności biblioteki `pgfplots`, natomiast wciąż znajduje się w fazie rozwoju. Co więcej, biblioteki te nie są kompatybilne. Zaletą `Typst` jest natomiast natywna i pełna obsługa formatu `SVG`.
