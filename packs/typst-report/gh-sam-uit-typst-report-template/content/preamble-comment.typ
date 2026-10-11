#import "../template/lib.typ": *

= Nhận Xét Của Giảng Viên
<nhan-xet-cua-giang-vien>

#v(3em)

#for number in range(30) {
    [#line(length: 100%, stroke: (paint: black.lighten(90%), thickness: 0.5pt))]
}

#v(10em)

//#line(length: 100%, stroke: (paint: black.lighten(90%), thickness: 0.75pt,))

#grid(
    columns: (50%, 50%),
    gutter: 1em,
    align: (center + bottom, center + bottom),
    stroke: none,
    [#line(length: 100%, stroke: (paint: black.lighten(90%), thickness: 0.5pt))],[#line(length: 100%, stroke: (paint: black.lighten(90%), thickness: 0.5pt))],
    [#emph[Ngày/Tháng]],[#emph[Giảng Viên]]
)
