#let trans = (
 en: (Proposition: "Proposition",
      Theorem: "Theorem",
      Table: "Table",
      Figure: "Figure",
      Assumption: "Assumption",
      Definition: "Definition",
      Corollary: "Corollary",
      Lemma: "Lemma",
      Remark: "Remark",
      Example: "Example",
      Claim: "Claim",
      Fact: "Fact",
      Proof: "Proof",
      Appendix: "Appendix"
    ),
jp: (Proposition: "命題",
      Theorem: "定理",
      Table: "表",
      Figure: "図",
     　Assumption: "仮定",
      Definition: "定義",
      Corollary: "系",
      Lemma: "補題",
      Remark: "注意",
      Example: "例",
      Claim: "主張",
      Fact: "事実",
      Proof:"証明",
      Section:"節",
      Chapter: "章",
      Appendix: "付録"
  )
)

#let plurals_dic = ("Proposition": "Propositions", "Theorem":"Theorems", "Lemma":"Lemmata", "Definition":"Definitions", "Table":"Tables", "Assumption":"Assumptions", "Figure":"Figures", "Example": "Examples", "Fact":"Facts")

#let proofname(name,lang) ={
  if lang == "en" {return "Proof of "+ name + "."}
  if lang == "jp" {return name + "の証明."}
}

#let QERmark(lang) ={
  if lang == "en" {return $qed$}
  if lang == "jp" {return [(証了)]}
}

#let tjk_month_name = ("en": 
("1": "January",
"2": "February",
"3": "March",
"4": "April",
"5": "May",
 "6": "June",
 "7": "July",
 "8": "August",
 "9": "September",
 "10": "October",
 "11": "November",
 "12": "December"
),

"en-abr": 
("1": "Jan.",
"2": "Feb.",
"3": "Mar.",
"4": "Apr.",
"5": "May",
 "6": "Jun.",
 "7": "Jul.",
 "8": "Aug.",
 "9": "Sep.",
 "10": "Oct.",
 "11": "Nov.",
 "12": "Dec."
),

"jp": ("1": "睦月",
"2": "如月",
"3": "弥生",
"4": "卯月",
"5": "皐月",
 "6": "水無月",
 "7": "文月",
 "8": "葉月",
 "9": "長月",
 "10": "神無月",
 "11": "霜月",
 "12": "師走"
)
)


#let tjk_wareki(year) = {
  if year >= 2019 {
  return "令和 " + str(year - 2018) 
  }
  
}