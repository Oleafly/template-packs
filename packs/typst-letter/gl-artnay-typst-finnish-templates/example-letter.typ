#import "template/sfs-letter-template.typ": sfs_letter

#show: doc => sfs_letter(
  doc,
  logo: "logo.svg",
  document_type: "Tarjous",
  date: "1.6.2025",
  document_id: "T2025-042",
  confidentiality: "Luottamuksellinen",
  meta_1: "Voimassa: 30.6.2025 asti",
  meta_2: "",
  recipient_org: "Vastaanottaja Oy",
  recipient_name: "Ville Vastaanottaja",
  recipient_street: "Vastaanottajankatu 1",
  recipient_postalcode: "00000",
  recipient_city: "Kaupunki",
  subject: "Tarjous ohjelmistopalvelusta",
  title: "Tarjous projektin X toteutuksesta",
  signer_1_name: "Mikko Myyjä",
  signer_1_title: "myyntipäällikkö",
  signer_1_email: "mikko.myyja@yritys.fi",
  signer_2_name: "Tiina Tarjoaja",
  signer_2_title: "asiakkuusjohtaja",
  signer_2_email: "tiina.tarjoaja@yritys.fi",
  company_name: "Tarjoaja Oy",
  company_email: "info@tarjoaja.fi",
  company_website: "www.tarjoaja.fi",
  company_phone: "Puhelin: +358 9 123 456",
  company_office: "Pääkonttori",
  company_street: "Esimerkkikatu 9",
  company_postalcode: "00000",
  company_city: "Kaupunki",
  company_id: "Y-tunnus: 1234567-8",
)

= Tarjouksen sisältö

Kiitos mielenkiinnostanne nykyaikaisia dokumentinhallintaratkaisuja kohtaan. Tarjoamme teille kokonaisvaltaisen Typst-pohjaisen dokumenttipalvelun, joka tuottaa ammattitasoisia dokumentteja tehokkaasti ja turvallisesti yksityisessä, suomalaisessa pilviympäristössä.

Typst on uuden sukupolven merkintäkielipohjainen ladontajärjestelmä, joka yhdistää LaTeX-ladontajärjestelmän tehon ja Markdown-merkintäjärjestelmän helppokäyttöisyyden. Palvelumme mahdollistaa siirtymisen perinteisistä tekstinkäsittelyohjelmista nykyaikaiseen, versiohallittuun ja skaalautuvaan dokumentinhallintaan.

= Palvelun sisältö

== Typst-palvelualusta

Tarjoamme täysin hallinnoidun Typst-palvelun, joka sisältää:

- Tarpeisiinne räätälöidyn Typst-instanssin yksityisessä pilviympäristössä
- Selainpohjaisen käyttöliittymän dokumenttien luontiin ja samanaikaiseen muokkaukseen
- Integroidun versionhallinnan (Git-pohjainen)
- Reaaliaikaisen esikatselun ja yhteistyöominaisuudet
- REST-rajapinnan järjestelmäintegraatioita varten
- Automatisoidun varmuuskopioinnin ja katastrofipalautuksen
- Lisenssin Apache-2.0 toimittajalukon välttämiseksi.

== Mallipohjien kirjasto ja räätälöinti

Palveluun sisältyy kattava mallipohjakirjasto:

- SFS 2487:2024 -standardin mukaiset asiakirjamallit (kirje, muistio, pöytäkirja, raportti, esitys)
- Organisaationne visuaalisen ilmeen mukaiset mallipohjat
- Erikoistuneita malleja teknisille dokumenteille
- Lakiasiakirjoja ja sopimuksia varten optimoidut pohjat
- Räätälöityjen mallipohjien kehitys ja ylläpito.

#pagebreak()

== Käyttäjähallinta ja turvallisuus

Palvelu tarjoaa kattavat turvallisuus- ja hallinnointiominaisuudet:

- Keskitetty käyttäjähallinta (LDAP/Active Directory/Entra ID -integraatio)
- Roolipohjainen käyttöoikeuksien hallinta
- Dokumenttitason käyttöoikeudet ja salausmahdollisuudet
- Auditointiloki kaikista toiminnoista
- GDPR-yhteensopiva tietosuoja
- ISO 27001 -sertifioidut tietoturvakäytännöt
- Auditoitu kolmannen osapuolen toimesta.

== Koulutus ja tuki

Palvelun käyttöönoton tukemiseksi tarjoamme:

- Kattavan käyttöönottosuunnitelman ja projektijohtamisen
- Käyttäjäkoulutuksia (perus-, edistynyt ja admin-taso)
- Typst-syntaksin ja -mallipohjien työpajoja
- Ympärivuorokautisen teknisen tuen suomeksi ja englanniksi
- Dokumentoidut parhaat käytännöt ja oppaat
- Kuukausittaiset palvelukatsaukset ja kehitysehdotukset.

= Tekninen toteutus

== Infrastruktuuri

Hallinnoitu palvelu toteutetaan täysin Suomessa sijaitsevassa yksityisessä pilviympäristössä:

- Konesalien fyysinen sijainti: Helsinki ja Tampere
- Kubernetes-orkestrointi ja automaattinen skaalautuvuus
- PostgreSQL-tietokanta korkeakäytettävyydellä
- Object storage -ratkaisu dokumenttiarkistointiin
- 99,9 prosentin palvelutasosopimus (SLA).

= Aikataulu ja hinnoittelu

== Nopea käyttöönotto

Palvelumme suurin etu on nopea käyttöönotto. Typst-palvelualusta on valmis käyttöön välittömästi hallinnoidussa palvelussa. Tuotantokäytön vaiheittaiseen aloittamiseen varaamme kuusi viikkoa sopimuksen allekirjoittamisesta.

== Edulliset kustannukset

Palvelun hinnoittelu perustuu vuosittaiseen tilausmalliin ilman suuria alkuinvestointeja.

=== Vuosihinnoittelu käyttäjämäärän mukaan
- 1-10 käyttäjää: 3 600 €/vuosi (300 €/kk)
- 11-25 käyttäjää: 14 400 €/vuosi (1 200 €/kk)
- 26-150 käyttäjää: 30 000 €/vuosi (2 500 €/kk)
- Yli 150 käyttäjää: Räätälöity hinnoittelu.

=== Hallinnoidun palvelun käyttöönottomaksu
- Perusmääritys ja konfigurointi: 2 500 €
- Mallipohjien räätälöinti (10 kpl): 10 000 €
- Peruskoulutus: 2 500 €
- *Yhteensä käyttöönotto: 15 000 € (alv 0 %)*.
\
Vuosimaksu sisältää ylläpidon, tuen, varmuuskopioinnin, päivitykset ja ympärivuorokautisen valvonnan.

= Lisätiedot

Tarkemmat yksityiskohdat ja toimitussisältö on kuvattu liitteessä 1. Tarjouksemme on voimassa 30.6.2025 asti.
