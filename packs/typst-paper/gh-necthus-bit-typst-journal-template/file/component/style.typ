#let SetDocStyle(doc) = {
  set text(font: "SimSun", size: 10.5pt)
  set par(justify: true,first-line-indent: 2em) // 两端对齐，段前缩进2字符
  set par(leading: 1em)
  set heading(numbering:"1.")
  show heading: it => {
    let nums = counter(heading).get()
    let level = nums.len() - 1
    if it.level == 1{

      set align(center)
      set text(size: 14pt, font: "SimHei", weight: "regular")
      numbering("一、", nums.at(level))
      it.body
      

    } else if it.level == 2 {
      set align(left)
      set text(size: 10.5pt, font: "SimHei", weight: "regular")
      numbering("（一）", nums.at(level)) 
      it.body

    } else{
      set align(left)
      set text(size: 10.5pt, font: "SimSun", weight:"black")
      let remain_nums = nums.slice(2)
      numbering("1.", ..remain_nums) 
      it.body

    }

  }
  doc
}








#let showIntroduction(intro) ={
  
  {
    set align(center)
    set text(size: 14pt, font: "SimHei", weight: "regular")
    [引言]
  }

  intro
  par()[#text(size:0.5em)[#h(0.0em)]]

}


// #set heading(numbering:"1.")
// #show heading: it => {
//   let nums = counter(heading).get()
//   let level = nums.len() - 1
//   if it.level == 1{

//     set align(center)
//     set text(size: 14pt, font: "SimHei", weight: "regular")
//     numbering("一、", nums.at(level))
//     it.body
    

//   } else if it.level == 2 {
//     set align(left)
//     set text(size: 10.5pt, font: "SimHei", weight: "regular")
//     numbering("（一）", nums.at(level)) 
//     it.body

//   } else{
//     set align(left)
//     set text(size: 10.5pt, font: "SimSun", weight:"black")
//     let remain_nums = nums.slice(2)
//     numbering("1.", ..remain_nums) 
//     it.body

//   }

// }