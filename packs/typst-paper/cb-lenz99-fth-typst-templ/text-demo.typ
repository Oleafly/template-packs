
#set document(
    title: "Uebungstext von Eleni Kuhn",
    author: "Eleni Kuhn",
    date: datetime(year: 2026, month: 01, day: 01)
)

#set page(
    paper: "a4",
    margin:(
        left: 4cm,
        right: 2cm,
        top: 2cm,
        bottom: 1cm + 1em
    ) // rand
)

#set text(
    font: "Noto Serif",
    size: 12pt,
    lang: "de"
)

#set par(
    leading: 1em,
    spacing: 1.5em,
    first-line-indent: 1.5em
) // einheit em relativ zur schriftgröße, theoretisch auch 12pt oder so möglich

#set par(justify: true) // blocksatz, inkl. fußnoten

//
#set heading(numbering: "1.1")

#show heading: it => {
    v(1.5em)  // vor der überschrift
    set par(first-line-indent: 0em)
    it
    v(1em)  // nach der überschrift
}

#show quote: it => {
    set par(leading: 0.5em) // zeilenabstand
    pad(left: 0.5cm, it) // einrückung links
}

#show quote.where(block: true): it => {
    set par(first-line-indent: 0em)
    it
    v(0.5em)
} // zitat keine einrückung der ersten zeile

#set footnote(
    numbering: num => {
        counter(footnote).display("1")
    }
)

#show footnote.entry: it => {
    // if counter(footnote).at(it.note.location()).first() == 1 {v(1em)}
    // ^das wäre eine leerzeile unter dem strich
    let loc = it.note.location()
    let num = numbering(
        "1",
        ..counter(footnote).at(loc),
    )
    set par(leading: 0.5em)
    set text(size: 10pt)
    grid(
        columns: (auto, 1fr),
        column-gutter: 0.5em,
        num,
        it.note.body
    )
}

#set page(
    numbering: "1",
    number-align: top + right
)



= Inkulturation

// Es gibt ganz praktische Fragen, mit denen man sich beschäftigen sollte, beispielsweise wie man sich finanziert oder wie man mit Familie umgeht. Natürlich auch, wie konkret die Arbeit aussehen kann, was man dafür braucht, mit wem man vielleicht zusammenarbeitet. Und damit verknüpft ist auch die Frage, wie man Mission definiert, wie man Mission betrachtet. Es ist meiner Ansicht nach dringend notwendig, darüber nachzudenken, in welchen Rollen man sich sich selbst und vor allem auch die Menschen, mit denen man vor Ort zusammenarbeitet, betrachtet und welche Aufgaben einander zugeschrieben werden.

// Wie ist auch die Perspektive der Menschen vor Ort darauf? Welche Ansprüche und Erwartungen haben sie an dich als Missionar?
// Was bedeutet Inkulturation? Wie will Gott das gerne? Mit welchem Verständnis von Inkulturation geht man in diese Arbeit?

Inkulturation ist ein sehr wichtiges Thema, mit dem man sich unbedingt beschäftigen sollte, wenn man mit interkultureller Theologie, mit Mission, irgendwie zu tun hat.
Bosch zum Beispiel stellt die _missio Dei_ vor, die ein Grundverständnis von der Rolle, Definition und Aufgabe von Mission sein kann:

#quote(block: true)[
    "Die klassische Lehre von der _missio dei_, dass Gott der Vater den Sohn sendet und Gott der Vater und der Sohn den Geist senden, wurde durch eine weitere 'Bewegung' erweitert: Vater, Sohn und Heiliger Geist senden die Kirche in die Welt." @bosch_mission_2011[457f]
]

Ganz ähnlich äußert sich dazu auch die Evangelische Kirche in Deutschland:

#quote(block: true)[
    "Menschen nehmen an der Mission Gottes teil, wenn sie von ihrem Glauben an Gott erzählen und von der Hoffnung, die dieser Glaube ihnen schenkt (1 Petr 3,15)." @ekd_mission_nodate
]

In einem Lexikonartikel werden außerdem einige Punkte in Bezug auf die ökumenische Missionsbewegung im 20. Jahrhundert benannt:

#quote(block: true)[
    "Vier Problemkreise wurden wichtig: 1. Das Entstehen von zur Selbstständigkeit drängenden jungen Kirchen, 2. der weltweite Säkularismus, 3. das Verhältnis von Evangelium und nichtchristlichen Religionen, 4. die sozial-wirtschaftlichen Probleme der afro-asiatischen Völker." @beyerhaus_mission_1978[355]
]

Hinzu kommen geschichtliche Aspekte. Laut Stanley werden Fragen rund um Mission schon so lange diskutiert, wie es das Christentum selbst gibt.@stanley_changing_2022[19]

Ebenso lohnt es sich nachzudenken über zum Beispiel Wiedergutmachungsprozesse zwischen ehemaligen Kolonien und Kolonialmächten, denn viele Artefakte, die damals entwendet wurden, sind von großer Bedeutung gewesen und können zurückgegeben werden.@ben-naimah_towards_2025[175f]

// Siehe @ben-naimah_towards_2025.

// #set par(justify: false)

#pagebreak()


// #bibliography("test.bib")
#bibliography("biblio-demo.yaml", style: "fth.csl") //"fth_debug.csl")


/*

= Bibliografie

Beyerhaus, Peter, Mission, in: Evangelisches Gemeindelexikon, Wuppertal 1978, 354-362

Ben-Naimah, Bridget, Towards a Biblical Theology of Restitution. A Reflection on Restitution between Europe and Some African Countries in the 21st Century, in: Interkulturelle Theologie 51, 1/2025, 173-184
// hier am besten indirektes zitat, weil auf englisch

Bosch, David, Mission im Wandel. Paradigmenwechsel in der Missionstheologie, Gießen 2012
// 457-458

EKD, Mission - Basiswissen Glaube, https://www.ekd.de/Mission-Basiswissen-Glauben-11237.htm vom 01.01.2026

Stanley, Brian, The Changing Face of Mission Studies since the Nineteenth Century, in: The Oxford Handbook of Mission Studies, Hg. Kirsteen Kim / Alison Fitchett-Climenhaga, Oxford 2022, 19-36
// hier am besten indirektes zitat, weil auf englisch

*/
