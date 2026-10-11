#import "../libs.typ": *

= Wstęp

Niniejszy szablon zawiera propozycje formatowania pracy dyplomowej, zgodne z wytycznymi z #link("https://lex.polsl.pl/423-lista/d/20505/5/")[Zarządzenia nr 54/2022]. Szablon dostępny jest na licencji `GNU LGPL v2.1`. Stosowanie, modyfikowanie i rozpowszechnianie niniejszego szablonu jest dozwolone w dowolnym celu, przy czym sam szablon traktowany jest jak zewnętrzna biblioteka. Plik loga `polsl_logo.png`, który znajduje się w folderze `obrazki`, jest własnością Politechniki Śląskiej i jego stosowanie regulowane jest przepisami zawartymi w #link("https://www.polsl.pl/siwps/logo-2/")[Księdze Znaku]. Uwagi proszę zgłaszać na adres autora: #link("mailto:lukasz.drozdz@polsl.pl")[lukasz.drozdz\@polsl.pl].

Szablon złożony jest z następujących katalogów:
- `rozdzialy` -- tutaj zaleca się umieszczać kolejne pliki rozdziałów,
- `obrazki`   -- tutaj zaleca się umieszczanie obrazków i rysunków,
- `dodatki`   -- tutaj znajdują się streszczenia i bibliografia.

W katalogu głównym natomiast znaleźć można pliki:
- `build.sh`       -- skrypt stosowany do wygenerowania pliku `PDF`,
- `thesis.typ`      -- klasa szablonu dokumentu (nie należy edytować),
- `main.typ`     -- główny plik dokumentu (należy uzupełnić).

W pliku `main.typ` należy uzupełnić dane dotyczące pracy, zgodnie z komentarzami w pliku, a następnie dodać kolejne rozdziały pracy. Pliku `style.typ` nie zaleca się edytować, natomiast można to robić, jeśli konieczna jest edycja stylu dokumentu. System składu `Typst` jest w dalszym ciągu na etapie rozwoju, stąd wiele funkcji może nie działać, albo ich działanie może zmienić się w przyszłości. Dotyczy się to głównie ustawiania wcięć akapitów, automatycznego formatowania części odnośników i generowania dokumentu w formacie `PDF/A3u`. Jeżeli istotne jest osiągnięcie dobrej jakości składu oraz wymagana jest stabilność stosowanego szablonu zaleca się stosowanie szablonu w wersji `LaTeX`.
