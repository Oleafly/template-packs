// 默认校标与徽章矢量图像
#let default-logo = image("../assets/vi/ucas-logo-H-standard.svg")
#let default-emblem = image("../assets/vi/ucas-emblem.svg")

// 校标与图像渲染函数
#let render-logo(logo, height: 32pt, fit: "contain") = {
  if logo == none {
    none
  } else if type(logo) == content {
    box(height: height, {
      set image(height: 100%, fit: fit)
      logo
    })
  } else if type(logo) == str {
    let path = if (
      logo.starts-with("/") or logo.starts-with("./") or logo.starts-with("../")
    ) {
      logo
    } else {
      "../" + logo
    }
    image(path, height: height, fit: fit)
  } else {
    logo
  }
}
