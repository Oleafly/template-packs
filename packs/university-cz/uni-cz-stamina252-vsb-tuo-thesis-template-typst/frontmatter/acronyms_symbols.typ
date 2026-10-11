#import "../src/translations.typ": tran


= #tran.acronyms_symbols

#let symbols = (
  ($t$, "čas", $upright(s)$),
  ($l$, "délka", $upright(m)$),
  ($m$, "hmotnost", $upright(k g)$),
  ($I$, "elektrický proud", $upright(A)$),
  ($T$, "termodynamická teplota", $upright(K)$),
  ($n$, "látkové množství", $upright(m o l)$),
  ($J$, "svítivost", $upright(c d)$),
)

#let greek_symbols = (
  ($Phi_2$, "magnetický tok", $upright(W b)$),
  ($alpha$, "rovinný úhel", $upright(r a d)$),
  ($beta$, "dávkový ekvivalent", $upright(S v)$),
  ($gamma$, "aktivita (radioaktivní)", $upright(B q)$),
  ($delta$, "absorbovaná dávka", $upright(G y)$),
  ($eta$, "katalytická aktivita", $upright(k a t)$),
  ($theta$, "teplota v stupních Celsia", $upright(degree C)$),
  ($rho$, "hustota", $upright(k g dot m^(-3))$),
  ($omega$, "úhlová rychlost", $upright(r a d dot s^(-1))$),
  ($lambda$, "vlnová délka", $upright(m)$),
)

#let acronyms = (
  ("AES", "Pokročilý standard šifrování (Advanced Encryption Standard)"),
  ("2FA", "Dvoufázové ověření (Two-Factor Authentication)"),
  ("IDS", "Systém detekce průniku (Intrusion Detection System)"),
  ("SOC", "Centrum bezpečnostních operací (Security Operations Center)"),
  ("ML", "Strojové učení (Machine Learning)"),
  ("NLP", "Zpracování přirozeného jazyka (Natural Language Processing)"),
  ("OCR", "Optické rozpoznávání znaků (Optical Character Recognition)"),
  ("SaaS", "Software jako služba (Software as a Service)"),
  ("PaaS", "Platforma jako služba (Platform as a Service)"),
  ("MTBF", "Střední doba mezi poruchami (Mean Time Between Failures)"),
  ("MTTR", "Střední doba opravy (Mean Time To Repair)"),
  ("TDP", "Navržený tepelný výkon (Thermal Design Power)"),
  ("ESD", "Elektrostatický výboj (Electrostatic Discharge)"),
  ("IP67", "Stupeň krytí (ochrana proti prachu a vodě)"),
)

#let symbols = symbols + greek_symbols

#(if acronyms.len() > 0 or symbols.len() > 0 {
  grid(
    columns: (auto, 1fr, auto),
    align: (left + top),
    column-gutter: 1.5em,
    row-gutter: 0.5em,
    inset: 0pt,
    
    // Část pro akronymy
    ..if acronyms.len() > 0 {
      acronyms.map(row => (
        row.at(0),
        row.at(1),
        [],
      )).flatten()
    },
/*
    if acronyms.len() > 0 and symbols.len() > 0 {
      grid.cell(colspan: 3, v(1em))
    },
*/
    ..if symbols.len() > 0 {
      symbols.map(row => (
        row.at(0),
        row.at(1),
        [[#row.at(2)]],
      )).flatten()
    }
  )
})