#let theme-color = rgb("#2b2273")

#let icon(path, fill: rgb("#000000")) = box(
  // baseline: 0.125em,
  height: 0.8em,
  width: 1.25em,
  align(
    center + horizon,
    image(
      bytes(read(path).replace("path d", "path fill=\"" + fill.to-hex() + "\" d"))
      , height: 1.1em),
  ),
)
#let icon-png(path) = box(
  height: 0.7em,
  width: 1.25em,
  align(
    center + horizon,
     image(
    path,
    height: 1.1em
  )
  )
 
)

#let icon = icon.with(fill: theme-color)
// Set fontawesome icons
#let fa_path = "/img/fa/fa-";

#let fa_home = icon(fa_path + "home.svg");
#let fa_email = icon(fa_path + "envelope.svg");
#let fa_github = icon(fa_path + "github.svg");
#let fa_linkedin = icon(fa_path + "linkedin.svg");
#let fa_phone = icon(fa_path + "phone-alt.svg");
#let fa_weixin = icon(fa_path + "weixin.svg");

#let fa-award = icon(fa_path + "award.svg");
#let fa-building-columns = icon(fa_path + "building-columns.svg")
#let fa-code = icon(fa_path + "code.svg")
#let fa-envelope = icon(fa_path + "envelope.svg")
#let fa-github = icon(fa_path + "github.svg")
#let fa-graduation-cap = icon(fa_path + "graduation-cap.svg")
#let fa-linux = icon(fa_path + "linux.svg")
#let fa-phone = icon(fa_path + "phone.svg")
#let fa-windows = icon(fa_path + "windows.svg")
#let fa-wrench = icon(fa_path + "wrench.svg")
#let fa-work = icon(fa_path + "work.svg")
#let fa-proj = icon(fa_path + "proj.svg")


#let fa-research = icon-png(fa_path + "microscope.png");
#let fa-trophy = icon-png(fa_path + "trophy.png");
#let fa-paper = icon-png(fa_path + "paper.png")


#let fa-angle-right = icon(fa_path +"angle-right.svg")