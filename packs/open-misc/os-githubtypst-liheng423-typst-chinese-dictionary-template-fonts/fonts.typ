#let font-family = (
  SongTi: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "NSimSun",
  ),
  HeiTi: (
    (name: "Arial", covers: "latin-in-cjk"),
    "SimHei",
  ),
  KaiTi: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "KaiTi",
  ),
  FangSong: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "FangSong",
  ),
  Mono: (
    (name: "DejaVu Sans Mono", covers: "latin-in-cjk"),
    "SimHei",
  ),


  Math: (
    "New Computer Modern Math",
    "KaiTi",
  ),
)

#let ZhongSong = ((name: "Times New Roman", covers: "latin-in-cjk"), "STZhongSong",)


#let hyperlink(txt, url) = link(url, text(rgb(0, 0, 255))[#txt])


#let sup = (
  "0": "⁰", "1": "¹", "2": "²", "3": "³", "4": "⁴",
  "5": "⁵", "6": "⁶", "7": "⁷", "8": "⁸", "9": "⁹", 
  "-": "‾"
)

// #let leshan_tone = (
//   "1": "⁵⁵", "2": "²¹", "3": "⁵²", "4": "²⁴", "5": "⁴⁴", "-": "‾"
// )


#let circled = (
  "1": "①", "2": "②", "3": "③", "4": "④", "5": "⑤",
  "6": "⑥", "7": "⑦", "8": "⑧", 
  "9": "⑨", "10": "⑩"
)


#let sup-pinyin = string => string.replace(
  regex("[0-9-]"),
  c => sup.at(c.text)
  
)

#let font-size-map = text => {
  let len = text.clusters().len()
  if len <= 4 {
    22pt
  } else if len <= 6 {
    18pt
  } else if len <= 8 {
    16pt
  } else {
    14pt
  }
}





// ====================================================
