// Versicherung über redliches wissenschaftliches Arbeiten (§2.11).
//
// Die Richtlinie schreibt vor: "Es ist exakt folgender Wortlaut zu verwenden."
// Der Text ist wörtlich aus der Richtlinie vom Januar 2024 übernommen und darf nicht verändert werden.
// Beide Fassungen stehen dort auf je einer eigenen Seite auf den Richtlinienseiten 13 und 14.

#import "config.typ" as cfg
#import "abkuerzungen.typ": markiere-abkuerzungen-verwendet
#import "kapitel.typ": unnummeriertes-kapitel

// Die Unterschriftszeile zeigt Ort und Datum links sowie die Unterschrift rechts.
// §2.11 verlangt Ort, Datum und Unterschrift.
// Der Block bleibt zusammen, damit die Beschriftungen nicht von ihren Linien getrennt werden.
#let unterschrift(links, rechts) = {
  v(1.5cm)
  block(breakable: false, grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: left,
    ..(links, rechts).map(beschriftung => {
      line(length: 90%, stroke: 0.5pt)
      v(0.2em)
      beschriftung
    }),
  ))
}

#let versicherung(name) = {
  // Der vorgeschriebene Wortlaut verwendet diese Abkürzungen bereits selbst.
  markiere-abkuerzungen-verwendet("HFU", "SPO")

  unnummeriertes-kapitel("Versicherung über redliches wissenschaftliches Arbeiten", {
    [
      Hiermit versichere ich, #name, dass ich die vorliegende Arbeit selbstständig verfasst und erstellt habe.
      Ich versichere, dass ich nur zugelassene Hilfsmittel und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.
      Ferner versichere ich, dass ich alle wörtlich oder sinngemäß übernommenen Stellen in der Arbeit gemäß gängiger wissenschaftlicher Zitierregeln korrekt zitiert und als solche gekennzeichnet habe.
      Darüber hinaus versichere ich, dass alle verwendeten Hilfsmittel, wie KI-basierte Chatbots (bspw. ChatGPT), Übersetzungs- (bspw. Deepl), Paraphrasier- (bspw. Quillbot) oder Programmier-Applikationen (bspw. Github Copilot) vollumfänglich deklariert und ihre Verwendung an den entsprechenden Stellen angegeben und gekennzeichnet habe.

      Ich bin mir bewusst, dass die Nutzung maschinell generierter Texte keine Garantie für die Qualität von Inhalten und Text gewährleistet.
      Ich versichere, dass ich mich textgenerierender KI-Tools lediglich als Hilfsmittel bedient habe und in der vorliegenden Arbeit mein gestalterischer Einfluss überwiegt.
      Ich verantworte die Übernahme jeglicher von mir verwendeter maschinell generierter Textpassagen vollumfänglich selbst.

      Auch versichere ich, die „Satzung der Hochschule Furtwangen (HFU) zur Sicherung guter wissenschaftlicher Praxis“ vom 27. Oktober 2022 zur Kenntnis genommen zu haben und mich an den dortigen Ausführungen zu orientieren.

      Mir ist bewusst, dass meine Arbeit auf die Benutzung nicht zugelassener Hilfsmittel oder Plagiate überprüft werden kann.
      Auch habe ich zur Kenntnis genommen, dass ein Verstoß gegen § 10 bzw. § 11 Absatz 4 und 5 der Allgemeinen Teile der HFU-SPOen zu einer Bewertung der betroffenen Arbeit mit der Note 5 oder mit «nicht ausreichend» und/oder zum Ausschluss von der Erbringung aller weiteren Prüfungsleistungen führen kann.
    ]

    unterschrift[Ort, Datum][Unterschrift]
  })

  // Auf den Richtlinienseiten 13 und 14 folgt die englische Fassung direkt auf die deutsche.
  // Sie beginnt deshalb nicht erst auf der nächsten rechten Seite.
  unnummeriertes-kapitel("Declaration on honest academic work", rechte-seite: false, {
    set text(lang: "en")
    [
      With this document I, #name, declare that I have drafted and created the piece of work in hand myself.
      I declare that I have only used such aids as are permissible and used no other sources or aids than the ones declared.
      I furthermore assert that any passages used, be that verbatim or paraphrased, have been cited in accordance with current academic citation rules and such passages have been marked accordingly.
      Additionally, I declare that I have laid open and stated all and any use of any aids such as AI-based chatbots (e.g. ChatGPT), translation (e.g. Deepl), paraphrasing (e.g. Quillbot) or programming (e.g. Github Copilot) devices and have marked any relevant passages accordingly.

      I am aware that the use of machine-generated texts is not a guarantee in regard of the quality of their content or the text as a whole.
      I assert that I used text-generating AI-tools merely as an aid and that the piece of work in hand is, for the most part, the result of my creative input.
      I am entirely responsible for the use of any machine-generated passages of text I used.

      I also confirm that I have taken note of the document “Satzung der Hochschule Furtwangen (HFU) zur Sicherung guter wissenschaftlicher Praxis” dated October 27, 2022 and that I have followed the statements there.

      I am aware that my work may be examined to determine whether any non-permissible aids or plagiarism were used.
      I also acknowledge that a breach of § 10 or § 11 section 4 and 5 of HFU’s study and examination regulations’ general part may lead to a grade of 5 or «nicht ausreichend» (not sufficient) for the work in question and / or the exclusion from any further examinations.
    ]

    unterschrift[place, date][signature]
  })
}
