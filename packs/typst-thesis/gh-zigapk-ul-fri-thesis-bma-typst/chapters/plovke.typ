#import "../template/lib.typ": LaTeX

= Plovke: slike in tabele <ch:plovke>

Slike in daljše tabele praviloma vključujemo v dokument kot plovke. Pozicija plovke v končnem izdelku ni pogojena s tekom besedila, temveč z izgledom strani. #LaTeX bo skušal plovko postaviti samostojno, praviloma na vrh strani, na kateri se na takšno plovko prvič sklicujemo. Pri tem pa bo na vsako stran končnega izdelka želel postaviti tudi sorazmerno velik del besedila. V skrajnem primeru, če imamo res preveč plovk, se bo odločil za stran popolnoma zapolnjeno s plovkami.

== Formati slik

Bitne slike, vektorske slike, kakršnekoli slike, z #LaTeX#[-om] lahko vključimo vse.
Slika @pic1 je v #raw(".pdf") formatu.

#figure(
  image("../figures/pic1.pdf", width: 10cm),
  caption: [Herschelov graf, vektorska grafika.],
) <pic1>

Pa res lahko vključimo slike katerihkoli formatov? Žal ne. Programski paket #LaTeX lahko uporabljamo v več dialektih. Ukaz #raw("latex") ne mara vključenih slik v formatu Portable Document Format #raw(".pdf"), ukaz #raw("pdflatex") pa ne prebavi slik v Encapsulated Postscript Formatu #raw(".eps").
Strnjeno v Tabeli @tbl:1.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    inset: (x: 8pt, y: 4pt),
    align: (left, center, center, center),
    table.header(
      table.hline(),
      [ukaz/format], [#raw(".pdf")], [#raw(".eps")], [ostali formati],
      table.hline(),
    ),
    [#raw("pdflatex")], [da], [ne], [da],
    [#raw("latex")], [ne], [da], [da],
    table.hline(),
  ),
  caption: [],
) <tbl:1>

Nasvet? Odločite se za uporabo ukaza #raw("pdflatex"). Vaš izdelek bo brez vmesnih stopenj na voljo v #raw(".pdf") formatu in ga lahko odnesete v vsako tiskarno. Če morate na vsak način vključiti sliko, ki jo imate v #raw(".eps") formatu, jo vnaprej pretvorite v alternativni format, denimo #raw(".pdf").

Včasih se da v okolju za uporabo programskega paketa #LaTeX nastaviti na kakšen način bomo prebavljali vhodne dokumente. Spustni meni na Sliki @pic2 odkriva uporabo #LaTeX#[-a] v njegovi pdf inkarnaciji --- #raw("pdflatex").

#figure(
  image("../figures/pic2.png", width: 10cm),
  caption: [Kateri dialekt uporabljati?],
) <pic2>

Vključena Slika @pic2 je seveda bitna.
