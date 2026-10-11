#let ZTSize = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)


#let ChineseZT = (
  FangSong: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong", "STFangSong"),
  SongTi: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun"),
  HeiTi: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimHei"),
  //标题黑体: ("SimHei"),
  BiaoTiSongTi: ((name: "Times New Roman", covers: "latin-in-cjk"), "STZhongsong", "SimSun"),
  KaiTi: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi"),
  code: ((name: "New Computer Modern Mono", covers: "latin-in-cjk"), "SimSun"),
  // 思源宋体: ((name: "Times New Roman", covers: "latin-in-cjk"), "Source Han Serif SC", "Source Han Serif"), // 暂未使用
  SiYuanHeiTi: ((name: "Times New Roman", covers: "latin-in-cjk"), "Source Han Sans SC", "Source Han Sans"),
  KaiTi2312: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi_GB2312"),
)

#let ziti = ChineseZT
#let zihao = ZTSize

#let chineseunderline(s, width: 300pt, bold: false, bottom: none, font: "KaiTi_GB2312",alignment:center) = {
  // 来自 pku-thesis
  let chars = if s == none or s == "" {(" ")} else {s.clusters()}
  let n = chars.len()
  context {
    let i = 0
    let now = ""
    let ret = ()
    let padding = par.spacing/3
    if bottom != none {
      padding = bottom
    }

    while i < n {
      let c = chars.at(i)
      let nxt = now + c

      if measure(nxt).width / 11 * 15 > width or c == "\n" {
        if bold {
          ret.push(text(font: font, size: ZTSize.小三,stroke: 0.34pt, now))
        } else {
          ret.push(text(font: font, size: ZTSize.小三, now))
        }
        ret.push(v(-par.spacing * 1.5))
        ret.push(line(start: (0em, padding), length: 100%, stroke: (thickness: 0.5pt)))
        if c == "\n" {
          now = ""
        } else {
          now = c
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      if bold {
        ret.push(text(font: font, size: ZTSize.小三, stroke: 0.34pt, now))
      } else {
        ret.push(text(font: font, size: ZTSize.小三, now))
      }
      ret.push(v(-par.spacing * 1.5))
      ret.push(line(start: (0em, padding),length: 100%, stroke: (thickness: 0.5pt)))
    }
    align(alignment,ret.join())
  }
}

#let englishunderline(s, width: 300pt, bold: false, bottom: none,alignment:center) = {
  // 来自 pku-thesis
  let em_height = context {
    set text(font: ChineseZT.KaiTi2312,size: ZTSize.小三)
    let h = measure("智")
    h.height
  }
  let tokens = s.split(regex("[\\,; ]"))
  let n = tokens.len()
  context {
    let i = 0
    let now = ""
    let ret = ()
    let padding = par.spacing/3
    if bottom != none {
      padding = bottom
    }

    while i < n {
      let c = tokens.at(i)
      let nxt = now + c + " "

      if measure(nxt).width / 11 * 15 > width or c == "\n" {
        if bold {
          ret.push(text(font: "Times New Roman", size: ZTSize.小三, weight: "bold", now))
        } else {
          ret.push(text(font: "Times New Roman", size: ZTSize.小三, now))
        }
        ret.push(v(-par.spacing * 1.35))
        ret.push(line(start: (0em, padding), length: 100%, stroke: (thickness: 0.5pt)))
        if c == "\n" {
          now = ""
        } else {
          now = c + " "
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      if bold {
        ret.push(text(font: "Times New Roman", size: ZTSize.小三, weight: "bold", now))
      } else {
        ret.push(text(font: "Times New Roman", size: ZTSize.小三, now))
      }
      ret.push(v(-par.spacing * 1.35))
      ret.push(line(start: (0em, padding),length: 100%, stroke: (thickness: 0.5pt)))
    }

    align(alignment,ret.join())
  }
}

#let mixunderline(s, width: 300pt, bold: false, bottom: none,alignment:center) = {
  let tokens = s.split(regex("[\\,; ]"))
  let n = tokens.len()
  context {
    let i = 0
    let now = ""
    let ret = ()
    let padding = par.spacing/3
    if bottom != none {
      padding = bottom
    }
    let line_stack = ()
    while i < n {
      let c = tokens.at(i)
      let nxt = now + c + " "
      if c.match(regex("\p{Han}")) != none{
        if bold{
          line_stack.push(text(font: ChineseZT.KaiTi2312,size: ZTSize.小三,stroke: 0.32pt,c))
        }
        else{
          line_stack.push(text(font: ChineseZT.KaiTi2312,size: ZTSize.小三,c))
        }
        
      }
      else{
        if bold{
          line_stack.push(text(font: "Times New Roman",size: ZTSize.小三,weight: "bold",c))
        }
        else{
          line_stack.push(text(font: "Times New Roman",size: ZTSize.小三,c))
        }
      }

      if measure(nxt).width / 11 * 15 > width or c == "\n" {
        ret.push(stack(dir: ltr, for item in line_stack{item}))
        line_stack = stack(dir:ltr)

        ret.push(v(-par.spacing * 1.25))
        ret.push(line(start: (0em, padding), length: 100%, stroke: (thickness: 0.5pt)))
        if c == "\n" {
          now = ""
        } else {
          now = c + " "
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      ret.push(stack(dir: ltr, for item in line_stack{item}))
      ret.push(v(-par.spacing * 1.25))
      ret.push(line(start: (0em, padding),length: 100%, stroke: (thickness: 0.5pt)))
    }

    align(alignment,ret.join())
  }
}

#let justify-words(s, width: auto) = {
  assert(type(s) == str and s.clusters().len() >= 2)
  context {
    let measure-width = measure(s).width
    let expected-width = if width == auto {
      0pt
    } else if type(width) in (str, content) {
      measure(width).width.to-absolute()
    } else if type(width) == length {
      width.to-absolute()
    }
    let spacing = if measure-width > expected-width {
      0pt
    } else {
      (expected-width - measure-width) / (s.clusters().len() - 1)
    }
    text(tracking: spacing, s)
  }
}