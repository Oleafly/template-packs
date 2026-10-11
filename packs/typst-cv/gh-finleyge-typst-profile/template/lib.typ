#let container(
  title: "Title",
  body
) = {
  [
    #set align(left)
    #grid(
      rows: 2,
      gutter: 0cm,
      row-gutter: 0cm,
      rect(
        outset: 0pt,
        width: 100%,
        fill: blue,
        radius: (
          top: 0.1cm,
        ),
        text(size: 16pt, fill: white, title),
      ),
      rect(
        inset: 20pt,
        width: 100%,
        fill: aqua,
        text(size: 14pt, 
          grid(
            columns: 1,
            gutter: 0.5cm,
            body,
          )
      ),
      )
    )
  ]
}

#let pair(
  key,
  value
) = {
  [
    #grid(
      columns: 2,
      gutter: 0.5cm,
      text(
        key + ":",
        size: 14pt,
      ),
      text(
        value,
        size: 14pt,
      )
    )
  ]
}

#let triple(
  key,
  value,
  unit
) = {
  [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.5cm,
      text(
        key,
        size: 14pt,
      ),
      text(
        value,
        size: 14pt,
      ),
      text(
        unit,
        size: 14pt,
      )
    )
  ]
}

#let conf(
  pic: str,
  name: str,
  sex: str,
  birthday: str,
  phone: str,
  email: str,
  address: str,
  doc) = {
  set page(
    paper: "a4",
  )

  [
    #set align(center)
    #set text(size: 20pt)
    个人简历
  ]
  
  container(
    title: "基本信息",
  [
    #grid(
      columns: (3cm, 1fr),
      gutter: 0.5cm,
      image(
        pic,
        width: 2.5cm,
        height: 3.5cm,
      ),
      grid(
        gutter: 0.5cm,
        grid(
          columns: (1fr, 1fr),
          gutter: 0.5cm,
          pair(
            "姓名",
            name,
          ),
          pair(
            "性别",
            sex
          ),
          pair(
            "生日",
            birthday,
          ),
          pair(
            "电话",
            phone,
          ),
        ),
        pair(
          "邮箱",
          email,
        ),
        pair(
          "住址",
          address,
        ),
      )
    )
  ]
  )
  doc
}


