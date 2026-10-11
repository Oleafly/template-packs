#import "src/lib.typ": technion-thesis
#import "front/abstract.typ": abstract-english, abstract-hebrew
#import "front/abbreviations.typ": abbreviation-entries
#import "back/references.typ": thesis-bibliography-entries

#let input-bool(name, default) = {
  let fallback = if default { "true" } else { "false" }
  let raw = sys.inputs.at(name, default: fallback)
  raw == "true" or raw == "1" or raw == "yes"
}

#let thesis-metadata = (
  title: (
    english: "Thesis Title",
    hebrew: "כותרת החיבור",
  ),
  author: (
    english: "Name of Author",
    hebrew: "שם המחבר",
  ),
  discipline: (
    english: "Computer Science",
    hebrew: "מדעי המחשב",
  ),
  supervision: (
    english: [This research was carried out under the supervision of Prof. Big Shot, in the Faculty of Computer Science.],
    hebrew: [#text(lang: "he")[
      המחקר בוצע בהנחייתו של פרופסור אישחשוב עצמוני, בפקולטה למדעי המחשב.
    ]],
  ),
  publication-info: (
    english: [
      (The grad school guidelines now require that you mention the following
      regarding publications of your thesis work; but of course, remove this
      parenthesized note...; you will find the note in the `thesis.typ` file.
      The entries for the publication list are bibliography entries, separate
      from those in the main bibliography: keep them in a separate source such
      as `front/pubinfo.bib`, make sure their labels are distinct from entries
      in the main bibliography, and order them in the order in which you want
      them to appear.)

      Some results in this thesis have been published as articles by the author
      and research collaborators in conferences and journals during the course
      of the author's research. The most up-to-date versions of these
      publications are:

      - Zig Zog and Mish Talem. "Leaf connectivity graph walks." In _Greenleaf
        algorithms_, pages 96-102. Waddison-Esley, 2010.
      - Big Shot and Mish Talem. "Efficient solutions of foliage-related
        problems." In _Greenleaf algorithms_, pages 239-254. Waddison-Esley,
        2011.
      - Jane Smith and Mish Talem. "Dynamic lettuce programming." In
        _Proceedings of AGRIALGO 2010_, pages 123-154. Springer, 2012.
    ],
    hebrew: [#text(lang: "he")[
      (התייחסות לפרסומים, שמופיעה להלן, הינה הכרחית לפי תקנות ביה"ס ללימודי
      מוסמכים; כמובן שיש למחוק את ההערה הזו שבסוגריים... תוכן זה נמצא בקובץ
      `thesis.typ`. הרשומות לצורך רשימת הפרסומים יכולות להישמר במקור נפרד כגון
      `front/pubinfo.bib`; הקפיד/י שהתוויות שלהן יהיו שונות מתוויות הרשומות
      בביבליוגרפיה העיקרית.)

      חלק מן התוצאות בחיבור זה פורסמו כמאמרים מאת המחבר ושותפיו למחקר בכנסים
      ובכתבי-עת במהלך תקופת מחקרו של המחבר. הגרסאות העדכניות ביותר של פרסומים
      אלו הינן:

      #text(lang: "en")[
      - Zig Zog and Mish Talem. "Leaf connectivity graph walks." Greenleaf
        algorithms, 2010.
      - Big Shot and Mish Talem. "Efficient solutions of foliage-related
        problems." Greenleaf algorithms, 2011.
      - Jane Smith and Mish Talem. "Dynamic lettuce programming." AGRIALGO
        2010, 2012.
      ]
    ]],
  ),
  ethics-statement: (
    english: [
      The research underlying this thesis was conducted honestly, in accordance
      with the ethical standards customary in academia. This applies, in
      particular, to the collection, processing and presentation of data, the
      description of and comparison with previous research work, etc. Also, the
      report on research activities and findings in this work is thorough and
      honest in accordance with the aforementioned standards.
    ],
    hebrew: [#text(lang: "he")[
      המחקר שבבסיס חיבור זה נערך כולו ביושר, ולפי אמות המידה האתיות המקובלות
      באקדמיה. בפרט אמורים הדברים בפעילויות איסוף הנתונים, עיבודם והצגתם,
      התייחסות והשוואה למחקרים קודמים וכו', ככל שהיוו חלק מן המחקר. כמו כן,
      הדיווח על המחקר ותוצאותיו בחיבור זה הוא מלא וישר, לפי אותן אמות מידה.
    ]],
  ),
  acknowledgements: (
    english: [
      I would like to thank my advisor, my parents, my friends, etc. etc.

      Add any thank-yous, acknowledgements, personal comments you wish to make
      here. Note that this acknowledgements section only gets printed in the
      post-exam version of the thesis.
    ],
    hebrew: [#text(lang: "he")[
      אני רוצה להודות למנחה שלי, להוריי, לחבריי, וכו' וכו'.

      אפשר להוסיף עוד תודות והערות אישיות כאן. שים/י לב: קטע זה של תודות
      מודפס בפועל רק בגרסת החיבור שלאחר-הבחינה.
    ]],
  ),
  financial-acknowledgement: (
    english: [The generous financial help of the Technion is gratefully acknowledged.],
    hebrew: [#text(lang: "he")[
    אני מודה לטכניון על התמיכה הכספית הנדיבה בהשתלמותי.
    ]],
  ),
  dates: (
    gregorian-english: "January 2012",
    gregorian-hebrew: "ינואר 2012",
    jewish-english: "Tevet 5772",
    jewish-hebrew: "טבת התשע\"ב",
  ),
)

// The upstream LaTeX template keeps abstract and abbreviation material in
// separate front-matter files. In Typst these files export values so the
// template receives structured data rather than pre-rendered include output.
// #include "front/abstract.typ"
// #include "front/abbreviations.typ"
#let thesis-abstracts = (
  english: abstract-english,
  hebrew: abstract-hebrew,
)

#show: technion-thesis.with(
  degree: sys.inputs.at("degree", default: "phd"),
  defense: sys.inputs.at("defense", default: "after"),
  draft: input-bool("draft", false),
  ethics: input-bool("ethics", true),
  abbreviations: input-bool("abbreviations", true),
  include-unused-abbreviations: input-bool("include-unused-abbreviations", false),
  metadata: thesis-metadata,
  abstracts: thesis-abstracts,
  abbreviations-list: abbreviation-entries,
  bibliography-sources: ("/back/references.bib",),
  bibliography-style: "alphanumeric",
  bibliography-entries: thesis-bibliography-entries,
  segment: sys.inputs.at("segment", default: "all"),
)

#include "main/intro.typ"
#include "main/prelims.typ"
#include "main/mainchap1.typ"
#include "main/conclusion.typ"

#pagebreak(to: "odd", weak: true)
#counter(heading).update(0)
#counter(figure.where(kind: image)).update(0)
#set heading(numbering: "A.1")
#set figure(numbering: n => numbering("A.1", 1, n))
#include "main/appendix1.typ"
