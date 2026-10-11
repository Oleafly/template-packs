#import "style.typ": *
#import "utils.typ": *
#import "figurex.typ": *
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "layouts/mainmatter.typ": mainmatter
#import "pages/cover.typ": cover-page
#import "pages/introduction.typ": introduction-page
#import "pages/profile.typ": profile-page
#import "pages/declare.typ": declare-page
#import "@preview/lovelace:0.3.0": *

#let documentclass(
  doctype: "midterm",
  date: datetime.today(),
  font-set: none,
  fonts: preset-ziti,
  info: (:),
) = {
  date = date
  info = (
    (
      student-id: "012345678910",
      name: "张三",
      degree: "专业型硕士生 Professional Master Student",
      study-mode: "全日制 Full-time",
      supervisor: "李四",
      title: "一个很长很长的题目",
      school: "上海交通大学",
      major: "电子信息",
      midterm-date: datetime.today(),
      proposal-date: datetime(year: 2025, month: 1, day: 2),
      project-source: 1,
      venue: "线上",
    )
      + info
  )
  fonts = {
    if font-set == "webapp" {
      (
        en-serif: "TeX Gyre Termes",
        en-sans: "TeX Gyre Heros",
        songti: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Serif CJK SC"),
        heiti: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Noto Sans CJK SC"),
        dengkuan: ("Fira Mono", (name: "Noto Sans CJK SC", covers: regex("\p{script=Han}"))),
        math: ("New Computer Modern Math", (name: "Noto Serif CJK SC", covers: regex("\p{script=Han}"))),
      )
    } else if font-set == "mac" {
      (
        en-serif: "Times New Roman",
        en-sans: "Arial",
        songti: ((name: "Times New Roman", covers: "latin-in-cjk"), "Songti SC"),
        heiti: ((name: "Times New Roman", covers: "latin-in-cjk"), "Heiti SC"),
        kaiti: ((name: "Times New Roman", covers: "latin-in-cjk"), "Kaiti SC"),
        fangsong: ((name: "Times New Roman", covers: "latin-in-cjk"), "STFangSong"),
        dengkuan: ("Menlo", (name: "Heiti SC", covers: regex("\p{script=Han}"))),
        math: ("STIX Two Math", (name: "Songti SC", covers: regex("\p{script=Han}"))),
      )
    } else if font-set == "windows" {
      (
        en-serif: "Times New Roman",
        en-sans: "Arial",
        songti: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun"),
        heiti: ((name: "Times New Roman", covers: "latin-in-cjk"), "SimHei"),
        kaiti: ((name: "Times New Roman", covers: "latin-in-cjk"), "KaiTi"),
        fangsong: ((name: "Times New Roman", covers: "latin-in-cjk"), "FangSong"),
        dengkuan: ("Consolas", (name: "SimHei", covers: regex("\p{script=Han}"))),
        math: ("Cambria Math", (name: "SimSun", covers: regex("\p{script=Han}"))),
      )
    } else if font-set == "webapp-upload" {
      (
        en-serif: "TeX Gyre Termes",
        en-sans: "TeX Gyre Heros",
        songti: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "SimSun"),
        heiti: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "SimHei"),
        kaiti: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Kaiti"),
        fangsong: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "FangSong"),
        dengkuan: ("Fira Mono", (name: "SimHei", covers: regex("\p{script=Han}"))),
        math: ("New Computer Modern Math", (name: "SimSun", covers: regex("\p{script=Han}"))),
      )
    } else if font-set == "linux" {
      (
        en-serif: "Liberation Serif",
        en-sans: "Liberation Sans",
        songti: ((name: "Liberation Serif", covers: "latin-in-cjk"), "Noto Serif CJK SC"),
        heiti: ((name: "Liberation Serif", covers: "latin-in-cjk"), "Noto Sans CJK SC"),
        dengkuan: ("Liberation Mono", (name: "Noto Sans CJK SC", covers: regex("\p{script=Han}"))),
        math: ("Latin Modern Math", (name: "Noto Serif CJK SC", covers: regex("\p{script=Han}"))),
      )
    } else {
      fonts
    }
  }

  (
    doctype: doctype,
    date: date,
    info: info,
    ziti: fonts,
    doc: (..args) => {
      doc(
        ..args,
        doctype: doctype,
        info: info + args.named().at("info", default: (:)),
        ziti: fonts,
      )
    },
    preface: (..args) => {
      preface(
        ..args,
        doctype: doctype,
        ziti: fonts,
      )
    },
    mainmatter: (..args) => {
      mainmatter(
        ..args,
        doctype: doctype,
        ziti: fonts,
      )
    },
    cover: (..args) => {
      cover-page(
        ..args,
        info: info + args.named().at("info", default: (:)),
        doctype: doctype,
        ziti: fonts,
      )
    },
    introduction: (..args) => {
      introduction-page(
        ..args,
        doctype: doctype,
        ziti: fonts,
      )
    },
    profile: (..args) => {
      profile-page(
        ..args,
        info: info + args.named().at("info", default: (:)),
        doctype: doctype,
        ziti: fonts,
      )
    },
    declare: (..args) => {
      declare-page(
        ..args,
        info: info + args.named().at("info", default: (:)),
        doctype: doctype,
        ziti: fonts,
      )
    },
  )
}
