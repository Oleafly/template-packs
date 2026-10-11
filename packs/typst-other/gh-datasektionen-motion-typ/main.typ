#import "template.typ": *
#import "utils.typ": *

// Ändra dessa parametrar:

// Sätt organ till "" i nästan alla fall.
#let organ = ""
#let author = "<författare>"
#let role = "<ämbete>"
// Medförfattare. Separera namn och ämbete med komma likt exemplet nedan.
#let coauthors = ()
//#let coauthors = ("Ture Teknolog, gammal och vis", "Tjomme Tjommolog, ung och dum")

#let type = "Motion"
#let title = "Bokstavligen 1984"
// Om dokumenttypen i sidhuvudet ska skilja sig från det i titeln. Bör typ
// endast användas för motionssvar, där sidhuvudet är "Motionssvar" medan titeln
// är "Svar på motion" likt exemplet nedan.
#let type_header = ""
//#let type_header = "Motionssvar"

#let sm = "Bar-SM"
// Mötets datum
#let date = datetime(year: 2069, month: 4, day: 20)
#let memebild = image("pictures/anka.png", width: 10cm)

// Om dokumentet är ett utkast.
#let draft = true

// Fippla med dessa parametrar om du är modig:
#show: project.with(
  organ: organ,
  author: author,
  role: role,
  coauthors: coauthors,
  type: type,
  type_header: type_header,
  title: title,
  date: date.display(),
  sm: sm,
  meme: align(center, memebild),
  draft: draft,
)

// `utils.typ` har en del hjälpfunktioner som kan vara bra att känna till!
// Annars, skriv här:
== Bakgrund

// Rim för Glögg-SM
//#align(center, text(style: "italic")[
//  Rim, rim, rim, \
//  jag älskar rim.
//
//  Jul, jul, jul, \
//  tomten är ful.
//])

#lorem(50)

== Förslag till beslut

Mot bakgrund av ovanstående yrkar #if organ.len() != 0 {organ} else if coauthors.len() != 0 [vi] else [jag] på

#att_avsätta(50000, "inköp av övervakningskameror")

#att_bud_anta("Övervakningsgruppen")

#att_styrdok_läggtillp(styrdok.sta, "§1.2 Ändamål", [
  - övervaka sektionens medlemmar till vardags.
])

#att_styrdok_läggtill(styrdok.reg, [
  == §7 Övervakning

  #lorem(50)
])

#att_styrdok_ändra(styrdok.reg, "§3.3.1 Ordförande", [
  Är ledamot i sektionsstyrelsen, D-rektoratet. Arbetsleder D-rektoratet och företräder organisationen utåt. Är firmatecknare tillsammans med kassören. Har det övergripande ansvaret för sektionens avtalshantering och serveringstillstånd. Ansvarar även för att det upprättas en verksamhetsberättelse varje år som talar #strike[om vad som hänt] under året. Denna verksamhetsberättelse ska, åtminstone, innehålla en verksamhetsberättelse från varje bokföringspliktig nämnd och organ.
], [
  Är ledamot i sektionsstyrelsen, D-rektoratet. Arbetsleder D-rektoratet och företräder organisationen utåt. Är firmatecknare tillsammans med kassören. Har det övergripande ansvaret för sektionens avtalshantering och serveringstillstånd. Ansvarar även för att det upprättas en verksamhetsberättelse varje år som talar *illa om alla medlemmar som inte betett sig* under året. Denna verksamhetsberättelse ska, åtminstone, innehålla en verksamhetsberättelse från varje bokföringspliktig nämnd och organ.
])

#att_konsnum()

#att[Storebror och/eller Storasyster ser dig.]
