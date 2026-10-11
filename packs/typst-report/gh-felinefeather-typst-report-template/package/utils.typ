// 这是个人在用的工具箱。如果用的开心，祝你幸福。
#import "@preview/physica:0.9.5": *
#import "@preview/typsium:0.2.0": *
#let rot = grad + math.times 
// #let inte = math.integral
#let init(body) = {
  set text(lang: "zh",region: "cn",font: "Noto Serif CJK SC",weight: "medium")
  show math.equation.where(block: false): math.display
  show math.equation: it => {
    show regex("\p{script=Han}"): set text(lang: "zh",region: "cn",font: "Noto Serif CJK SC",weight: "medium", )
    it
  }

  show raw: it => {
    show regex("\p{script=Han}"): set text(lang: "zh",region: "cn", font: "Noto Sans SC",weight: "regular", )
    it
  }

  show regex("&(.*?)&"):  it => {
    ce(it.text.trim("&"))
  }
  
  body
}