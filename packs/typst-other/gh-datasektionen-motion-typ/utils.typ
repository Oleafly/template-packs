#let cerise = rgb("#e83d84")
#let datagray = rgb("#888888")

/***** Allmäna hjälpfunktioner *****/

/**
 * Formatterar nummer snyggt och läsligt. Exempelvis för motioner om att avsätta
 * pengar.
 */
#let num(n, boxed: true) = {
  let neg = n < 0
  let int = calc.abs(calc.trunc(n))
  // calc.fract har en tendens att trolla bort precision av någon anledning
  let fract = if calc.fract(n) != 0 {str(n).split(".").at(1)}
  let res = str(int).clusters().rev().chunks(3).map(c => c.join("")).join(math.space.narrow).rev()
  let out = if neg {$-$} + $res$ + if fract != none {$,fract$}
  return if boxed { box(out) } else { out }
}

/// Som num, fast lägger till kr efter.
#let numkr(n) = [#num(n)~kr]

/// Ritar lådor runt text. Främst för styrdokument.
#let styrdok_box(text) = {
  block(
    fill: luma(200), // gray
    inset: 5pt,
    radius: 3pt,
    text
  )
}


/***** Hjälpfunktioner för att-satser *****/
/*
 * Lite allmän info som gäller för nästan alla funktioner här:
 * - Argument som heter `body` bör vara av typen content (alltså skrivas
 *   innanför []) för att kunna inkludera formattering som rubriker.
 * - Argument som heter `paragraf` bör vara av formen "§X.Y.Z Rubrik"
 * - Argument som heter `post` bör vara av formen "Resultatställe > Sek. resultats. > Post"
 * - Argument som heter `dok` bör använda styrdokumentsförkortningarna i
 *   avsnittet om förkortningar nedan. Exempelvis
 *   #att_styrdok_läggtill(styrdok.reg, [hej])
 */

#let attCount = counter("att")
/// Allmän att-sats. Autonumrerar från noll.
#let att(it) = {
  grid(
    columns: (auto, 1fr),
    gutter: 1em,
    [#h(1em)*att*#sub(context{attCount.display()})],
    [#it]
  )
  attCount.step()
}

/***** Budgetfippel *****/

#let __bud_år(år) = if år != none [i budgeten för #år ] else []

/// Avsätta pengar för en engångskostnad
#let att_avsätta(kr, syfte) = {
  att[avsätta #numkr(kr) för #syfte.]
}

#let att_bud_anta(rs, år: none) = {
  let årtext = __bud_år(år)
  att[#årtext;anta den bifogade budgeten för _#rs;_.]
}

#let att_bud_ändra(post, från, till, år: none) = {
  let verb = if calc.abs(till) > calc.abs(från) [höja] else [sänka]
  let diff = till - från
  let year = __bud_år(år)
  att[#year#verb _#post;_ med #numkr(diff) från #numkr(från) till #numkr(till).]
}

#let att_bud_läggtill(post, kr, år: none) = {
  let årtext = __bud_år(år)
  att[#årtext;skapa budgetposten _#post;_ på #numkr(kr).]
}

#let att_bud_stryk(post, år: none) = {
  let årtext = __bud_år(år)
  att[#årtext;stryka budgetposten _#post;_.]
}

#let att_bud_bytnamn(post, till, år: none) = {
  let årtext = __bud_år(år)
  att[#årtext;byta namn på _#post;_ till _#till;_.]
}

/***** Styrdokumentsfippel *****/

/**
 * Lägger till något löst i ett styrdokument. `body` bör inkludera en eller
 * flera rubriker.
 */
#let att_styrdok_läggtill(dok, body) = {
  att[
    i #dok lägga till
    #styrdok_box(body)
  ]
}

/// Lägger till något under en given paragraf i ett styrdokument.
#let att_styrdok_läggtillp(dok, paragraf, body) = {
  att_styrdok_läggtill([#dok;s _#paragraf;_], body)
}

/// Byter ut innehållet i en paragraf i sin helhet med något annat.
#let att_styrdok_bytut(dok, paragraf, body) = {
  att[
    i #dok byta ut _#paragraf;_ i sin helhet med
    #styrdok_box(body)
  ]
}

/**
 * Ändrar någon given del i en paragraf till något annat. Delarna som tas bort i
 * `från` bör vara överstrukna och de delar i `till` som läggs till bör vara
 * fetstilta för att göra det mer lättläst. Ett exempel finns i mallens
 * `main.typ`.
 */
#let att_styrdok_ändra(dok, paragraf, från, till) = {
  att[
    ändra _#paragraf;_ i #dok från
    #styrdok_box(från)
    till\
    #styrdok_box(till)
  ]
}

/// Stryker någonting i en given paragraf.
#let att_styrdok_stryk(dok, paragraf, body) = {
  att[
    i #dok;s _#paragraf;_ stryka
    #styrdok_box(body)
  ]
}

/**
 * Stryker någonting i en given paragraf utan att rita en låda. Effektivt om
 * många små saker stryks.
 */
#let att_styrdok_strykkort(dok, paragraf, body) = {
  att[i #dok;s _#paragraf;_ stryka "#body".]
}

/// Stryker en paragraf i sin helhet.
#let att_styrdok_strykp(dok, paragraf) = {
  att[stryka _#paragraf;_ i #dok.]
}

/**
 * Flyttar en paragraf i relation till en annan. Argumentet `preposition` kan
 * användas för att specifiera om det är ovan eller under, eller lämnas tomt i
 * vilket fall det kan tolkas som en omdöpning från `paragraf1` till
 * `paragraf2`.
 */
#let att_styrdok_flytta(dok, paragraf1, preposition, paragraf2) = {
  if preposition == "" {
    att[i #dok flytta _#paragraf1;_ till _#paragraf2;_.]
  } else {
    att[i #dok flytta _#paragraf1;_ till #preposition _#paragraf2;_.]
  }
}

/***** Motionssvarsfippel *****/

/// Hjälpfunktioner för att avsluta motionssvar.
#let att_ms_bifall() = att[bifalla motionen i sin helhet.]
#let att_ms_ändring() = att[bifalla motionen med ovanstående ändringar.]
#let att_ms_avslag() = att[avslå motionen.]

/***** Övrigt fippel *****/

/// Att-sats för konsekvensnumrering.
#let att_konsnum() = att[konsekvensnumrera styrdokumenten.]


/***** Förkortningar för vanliga textsnuttar *****/

/**
 * Kortkommandon för varje styrdokument som kan användas i alla
 * att-satsfunktioner eller i löpande text.
 */
#let styrdok = (
  reg: "reglementet",
  sta: "stadgarna",
  ver: "Verksamhetsregistret",
  jml: "Jämlikhetspolicyn",
  kli: "Klimatpolicyn",
  rek: "Rekryteringspolicyn",
  upp: "Uppförandepolicyn",
  sam: "Samarbetspolicyn",
  pm: (
    alk: "PM för alkohol",
    dfu: "PM för dFunk",
    eko: "PM för ekonomi",
    inh: "PM för informationshantering",
    ins: "PM för informationsspridning",
    par: "PM för partitioner",
    sti: "PM för stipendier",
    tra: "PM för traditioner, vanor, och livsregler",
  ),
)

/// Kortkommandom för sektionens alla organ.
#let org = (
  när: "Näringslivsorganet",
  soc: "Studiesociala organet",
  för: "Förvaltningsorganet",
  påv: "Påverkansorganet",
  eve: "Eventorganet",
  inf: "Informationsorganet",
  mot: "Mottagningsorganet",
  valb: "Valberedningen",
  drek: "D-rektoratet",
)
/// Om man är lat
#let drek = org.drek
#let valb = org.valb

/**
 * Kortkommandon för mandatperioder. Är typ bara najs om en miljard saker
 * ändras samtidigt mha funktioner.
 */
#let kalår = "kalenderår"
#let läsår = "läsår"
#let sm = "SM"
#let vm = "VM"
