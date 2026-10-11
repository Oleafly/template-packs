# Typst SOČ Šablona

Tato šablona je určena pro psaní prací Středoškolské odborné činnosti (SOČ) v sázecím systému [Typst](https://typst.app).

## Hlavní vlastnosti
- **Jednoduchost:** Syntax podobná Markdownu.
- **Moderní vzhled:** Odpovídá standardům pro SOČ.
- **Rychlost:** Okamžitý náhled při psaní.
- **Podpora AI prohlášení:** Snadné nastavení čestného prohlášení o použití AI.
- **Předpřipravené příkazy:** Pro vkládání obrázků, tabulek a kódových bloků s popisky a štítky.

## Jak začít
1. Nainstalujte si [Typst](https://github.com/typst/typst) nebo použijte [webovou aplikaci](https://typst.app).
2. Otevřete soubor `Main.typ`.
3. Upravte metadata (název práce, autor, škola, atd.) v bloku `#show: project.with(...)`.
4. Pište svůj text v jednotlivých `.typ` souborech (např. `Intro.typ`, `Kapitola.typ`).
5. Přidávejte nové kapitoly pomocí `#include "nazev_souboru.typ"` v `Main.typ`.

## Struktura složek
- `Main.typ`: Hlavní soubor pro kompilaci.
- `Template/`: Jádro šablony (konfigurace a styly).
- `Assets/`: Složka pro obrázky.
- `Fonts/`: Použité fonty.
- `literatura.bib`: Soubor pro citace.

## Doporučení
Pro nejlepší zážitek doporučujeme používat **Visual Studio Code** s rozšířením **Tinymist Typst**.

## Kontribuce
Pokud je v šabloně nějaká chyba, je zastaralá nebo neobsahuje nějakou funkci, nebojte se a přispějte.
Vytvořte issue, nebo ještě lépe, vytvořte rovnou pull request s úpravou. Je možné, že šablona nebude 
aktivně udržována v době, kdy se k ní dostanete, tak mějte prosím trpělivost. Díky :D 

## Licence
Tato šablona je volně dostupná pod licencí GNU GPL v3. Tato licence se však **nevztahuje na žádnou práci SOČ**
vytvořenou pomocí této šablony, vztahuje se pouze na šíření šablony jako takové. Pokud vám pomohla, budeme rádi 
za hvězdičku na repozitáři!

