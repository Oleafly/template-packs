#import "@preview/cetz:0.3.4"
#import "parameter.typ":*

//カラーとフォントの設定. 
#let default_color = eastern.lighten(30%)
#let emph_color = white
#let strong_color = rgb("3cb371")
#let textcolor = black

//フォントはarrayで設定すれば，英字は英字用の，日本語は日本語用のフォントで設定してくれる
#let body-font = ("M PLUS 2")
#let sans-font = ("M PLUS 2")

#let slide_counter = counter("slide_counter")
#let subslide = counter("subslide_counter")
#let subslide_c = counter("subslide_current")
#let pause_c = counter("pause_number")
#let pause_a = counter("pause_all")

//------スライド番号参照

#let showslidenumber(label:"") = {
  context[
    #if label == ""{
    counter("slide_counter").get().at(0)
  } else {
    counter("slide_counter").at(label).at(0)+1
      
    }
  ]
}

//---Slide Outline

#let slide-outline(n_columns:1, size:none) = { 
context{
let headings-name = ()

let headings = query(selector(heading.where(level: 1,outlined:true)))

let text_size = {
  if size == none {text.size} else {
     size
  }
}
let i = 0
while i< headings.len(){

    headings-name.push(text(font: sans-font,  weight:400, context[#link(headings.at(i).location())[#headings.at(i).body ]],size:text_size*1))
  i = i+1
}
columns(n_columns)[
#for i in range(headings.len()) {
  [#headings-name.at(i) #box(width: 1fr, repeat[.]) #{counter("slide_counter").at(headings.at(i).location()).at(0)+1} \ ]
}  
]
}
}


//--------Defaultのテーマ
//ヘッダーアウトラインの設定

#let heading-outline(color:default_color, current-headings:"") ={
let headings = query(selector(heading.where(level: 1,outlined:true)))
//let current-headings = counter(heading)
let i = 0
let headings-name = ()
let head-col = ()
let head-weight = ()
while i< headings.len(){
if i+1 == current-headings{
headings-name.push(text(font: sans-font, fill:color, weight:700, context[#link(headings.at(i).location())[#box(stroke:.5pt+color)[#headings.at(i).body ]]],size:8pt))}
else {
headings-name.push(text(font: sans-font, fill:color, weight:400, context[#link(headings.at(i).location())[#headings.at(i).body ]],size:8pt))}
i = i+1
}

pad(
    top: -1.0em,
    bottom: 0.0em,
    x: 0em,
    grid(
      columns: (1fr,) * (headings.len() +0),
      gutter: 0em,
      ..headings-name.map(name => align(center, 
       name
      ))))
}
)
}

//Headerスライドのデザイン

#let default-header_slide(title,now:0, end:0,color:default_color, tcolor:emph_color, current-headings: "", outline: false) = {
  
  set text(size: 23pt, weight:700)
  let a =  {if outline == true{1} else {0}}
  if outline == true {pad(top:15pt,bottom:-30pt)[ 
  #box(width:95%)[#heading-outline(color:color, current-headings: current-headings)]] 
      } else [#hide[#pad(top:15pt,bottom:-30pt)[ 
  #box(width:95%)[#heading-outline(color:color, current-headings: current-headings)]]]]
       
  pad(top:1.6em,left:-2cm)[#line(
      length: 30cm,
      stroke: 4pt + color.darken(10%),
    ) ] 
    text(size:0.7em,fill:color.darken(10%))[
      #pad(left:26.93cm,top:-2.65cm)[
       
        #circle(radius:1.0cm, stroke:4pt+color.darken(10%),fill:white)[#pad(left:-10pt,top:0pt)[#box(width: 2em)[#align(center)[#now]]] #pad(left:8pt,top:-18pt)[#box(width: 2em)[#align(center)[#end]]]
      ]
      ]
      ];
    pad(left:28.6cm,top:-2.7cm)[#line(length:2cm, stroke:4pt+color.darken(10%), angle:131deg)]

   pad(left: -20pt, top:-2.1cm)[
   #if title == [] {h(20pt); text(size:1.1em)[#hide[あg]]}else { h(20pt);text(size:1.1em,fill:color.darken(30%))[#title #hide[あg] ]; h(1fr)};
   
#v(a*2.5em+1.0em)

  ]
}

//タイトルスライドのデザイン


#let default-title_slide(now:"",end:"", color:"",tcolor:"", outline:"", title:"", title_notes:"", date:"", authors:"", notes:(),  institutions:"",  header-slide:default-header_slide) = {
  // default-header_slide(now:now,end:end, color:color, tcolor:tcolor,outline:outline)[]

  align(center+horizon)[
    #set text(weight: 700, 2em)
    #box(fill:color, outset: (x: 15pt, y: 15pt),radius: 10pt)[#text(fill:tcolor)[#title]]
    #if title_notes !=none {footnote[#title_notes]}
    #v(1em, weak: true)
    #set text(weight: 500, 0.5em)
  ]
  let author_note = authors.zip(notes)
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, 
       text(weight: 700, 1em, author)
      )),
      ..institutions.map(institutions => align(center, text(weight: 700, 1em, institutions)))
    ),
  ) 
    [#align(center)[#text(size:1.2em)[#date]]]

}

//フッターのデザイン

#let default-page-setter(footer:"",body) = {
  set page(footer: footer, fill:white)
  body
}

//スライドのデザイン，タイトルスライドのデザイン，フッターのデザインをまとめる．

#let default-theme = (slide_theme:default-header_slide, title_theme:default-title_slide, page_theme: default-page-setter, default-color: eastern.lighten(30%),emph-color:white)

//------


#let tbox(emph_color, frame_color, title,body) = {
   let ss_counter = counter("showstyle-counter")
   context{
     let ss = ss_counter.get().at(0)
 
  align(left)[#par(first-line-indent: 0em)[
      #let fcolor = {if ss == 1{ frame_color.mix(page.fill) }else {frame_color}}
      #let ecolor = {if ss == 1{ emph_color.mix(page.fill) }else {emph_color}}
      #box(width: 100%, stroke: 6pt+fcolor,outset: (x:0.4pt,y:9.6pt), inset: (x:10pt))[
      #v(-.3em)
      #box(width: 100%, fill: fcolor, stroke: 0pt+fcolor,outset:(x: 8.5pt, y: 8pt), inset: (y:-3pt))[#text(fill: ecolor,weight:700)[
      #title
      ]]
      #body]]]
  }
}
//theorem型の関数の定義.figureと数式とheadingしか参照できないのでfigureを使って定義する．
#let thm_counter = counter("thm_counter")

#let theorem_base(title: none, kind: "Theorem", bodyface: text, frame_color:none, tlabel: none,body) ={
    let current_thm_counter = counter("thm_counter"+(tlabel))
    context[
    #if current_thm_counter.get().at(0)==0{
    let thm_base_counter = counter("thm"+str(kind)).get().at(0); counter("thm"+str(kind)+(tlabel)).update(thm_base_counter)
    counter("thm"+str(kind)+(tlabel)).update(n => n+1)
    } ]

    context[
    #let thmlabel = "thm"+str(kind)+(tlabel)
    #show figure.caption: it => {
      it.body
    }
    #let title_text = {
    if title == none{ str(kind) +str(" ") + str(counter("thm"+str(kind)+(tlabel)).get().at(0))+ "."} 
    else { str(kind) +str(" ") + str(counter("thm"+str(kind)+(tlabel)).get().at(0))+ " ("+title+")."}
    }
    #let sup = str(kind) +str(" ") + str(counter("thm"+str(kind)+(tlabel)).get().at(0))
    #if counter("thm_counter"+(tlabel)).get().at(0) == 0{
    [#figure(kind:"TheoremKinds", supplement: sup, caption:title_text, body)
    #label(tlabel)]}else {
    figure(kind:"TheoremKinds", supplement: sup, caption:title_text, body)}]
  
  
    context[    
    #if current_thm_counter.get().at(0)==0{
    counter("thm"+str(kind)).step()
    counter("thm_counter"+(tlabel)).step()
  }
  ]
}

//footer

#let slide-footline(footlines, ocol, ecol, otxcol, etxcol) = {
  let n = footlines.len()
  set text(size:0.5em)
  table(stroke:none, fill:(x, _) =>
    if calc.odd(x) { ocol }
    else { ecol },columns: (1fr,)*n, 
    ..{footlines},
  )
  
}




// theorem 関数の定義。 ここを変えれば変わる.
#let theorem(title: none, label:none, kind:"Theorem", frame_color:default_color, body) = {
theorem_base(title: title, kind: kind, tlabel:label,frame_color:frame_color, body)
}

#let prop(title: none, label:none, frame_color:default_color, body) = {
theorem_base(title: title, kind: "Proposition", tlabel:label,frame_color:frame_color, body)
}

#let lemma(title: none, label:none,frame_color:default_color, body) = {
theorem_base(title: title, kind: "Lemma", tlabel:label, frame_color:frame_color,body)
}

#let cor(title: none, label:none,frame_color:default_color, body) = {
theorem_base(title: title, kind: "Corollary", tlabel:label,frame_color:frame_color, body)
}

#let claim(title: none, label:none,frame_color:default_color, body) = {
theorem_base(title: title, kind: "Claim", frame_color:frame_color,tlabel:label, body)
}

#let definition(title: none, label:none,frame_color:default_color, bodyface: text,body) = {
theorem_base(title: title, kind: "Definition",frame_color:frame_color, tlabel:label, body)
}


#let assumption(title: none, label:none,frame_color:default_color, bodyface: text,body) = {
theorem_base(title: title, kind: "Assumption", frame_color:default_color, tlabel:label, body)
}

#let proof(title: none, body) ={
   let title_text = {
    if title == none {"Proof"} 
    else {
      "Proof of "+title+"."  }
    }
  
  [#par(first-line-indent: 0em)[ #strong[#title_text] #h(1em)
  #body
  #box(width: 1fr, repeat[]);
  $qed$ ]]
}










//Dynamic slideの設定


#let showstyles(mode:none,body) ={
  if mode == "t" {
    let ss_counter = counter("showstyle-counter")
    ss_counter.update(1)
    context{
    let txcol = text.fill
    set text(fill:txcol.opacify(-trans))
      body
    }
    ss_counter.update(0)
  }
  // {
  //   let ss_counter = counter("showstyle-counter")
  //   ss_counter.step()
  //   let num = str(ss_counter.get().at(0))
  //   let metalab(body,slabel) = {
  //   show metadata: it => {
  //   }
  //   [#metadata(body)
  //     #label(str(slabel)) ]//
  
  //   } //
  //   //

  //   body
  //   metalab(body,num)
    
    
  //   context{
  //   let z= here().position()
  //   let size = measure((body))
  //   let txcol = page.fill
  //   let target = locate(label(num)).position()
  //   let targeta = locate(label(num+"a")).position()
  //   place(clearance:0pt, dx: 1*(target.at("x")-targeta.at("x")), dy: target.at("y")-targeta.at("y"),box(fill:white.transparentize(10%),hide[#body], ))
  //   }
  //    metalab(body,num+"a")
 

      
  
  
 // }
  if mode == "h" {
    hide[#body]
  }
  if mode == none{
    
  }
  
}

#let slide(title:"",body,slabel:"", level:1,color:default_color,tcolor:emph_color, subslides:0) ={
//slide_numberの更新
  let subslide = counter("subslide_counter")
  let subslide_c = counter("subslide_current")
  subslide.update(subslides)
  subslide_c.update(0)
  pause_c.update(0)

 if slabel == "" {heading(level:level)[#title]}
 else [#heading(level:level)[#title]; #label(slabel)]
  body
  
  context[
  #let current_subslide = 0
  #let ss = subslide.get().at(0)
  #let slabels = ()
  #let i = 0
  #let current_heading = counter(heading).get().at(0) 
  #while i < ss {slabels.push("")
    i = i + 1
    } 
  #while current_subslide < ss {
    //ヘッダーの作成
    counter("slide_counter").update(n => n - 1)
    if level == 1 or level == auto {
    counter(heading).update(n => n - 1)}
    heading(outlined: false, level:level)[#title]
    
    subslide_c.step()
    
    pause_c.step()
    pause_a.update(0)
    body
    
    current_subslide = current_subslide + 1
  }
]

}

#let Labelling(slabel) = {
  if slabel == "" []
  else [
  #show heading: it => {}
  #let sslabel = slabel
  #heading(outlined: false)[]
  #label(sslabel)]
}








//Pause
#let fpause(body, mode:none) = {
        let css = subslide_c.get().at(0)
        let pss = pause_a.get().at(0)
        pause_a.step()
        if css == 0 {subslide.step()}  
        if pss < css {return  body} else {return }
    }


#let pause(body,slabel:"", mode:none) ={
  Labelling(slabel)
  context({
  let css = subslide_c.get().at(0)
  let pss = pause_a.get().at(0)
  if pss < css {body} else {showstyles(mode:mode,body)}
  pause_a.step()
  if css == 0 {subslide.step()}
})
}


//subslide

#let only(number, body, mode:none) = {
    context({
    let current_subslide = subslide_c.get().at(0)
    let subslide_n = subslide.get().at(0)
    if type(number) == int { 
    if current_subslide == number {
      body
    } else {showstyles(mode:mode,body)}
    if current_subslide == 0 {
    if subslide_n < number {
      subslide.update(number)
    }}} 
    if type(number) == array {
    let serch_num(nm) = {
      if nm == current_subslide {
        return true
      } else{return false}
    }
     if type(number.find(serch_num))== int {
      body
    } else {[#showstyles(mode:mode,body)]}
    let mnumber = {number.last()}
    if current_subslide == 0{
    if subslide_n < mnumber {
      subslide.update(mnumber)
    }}
    }
}
)  
}




#let up_cur_slide(mnumber,n) = {
 let subslide_n = subslide.get().at(0)
 if subslide_n < mnumber {
    subslide.update(mnumber)
  }

}

// subslide.update(n=>max(n,calc.max(n,mnumber)))  


#let conly(number, body, mode:none,bounds:true) = {
    if type(number) == int { cetz.draw.content((0,0),context{up_cur_slide(number,subslide.get().at(0))  })
    }
    if type(number) == array {
    let mnumber = number.last()
    cetz.draw.content((0,0),[#context{up_cur_slide(mnumber,subslide.get().at(0)) }  ])
    }
    let visible(current_subslide) =  {
    if type(number) == int {
    if current_subslide == number {
       1
    } else {0}
    } 
    if type(number) == "array" {
    let mnumber = {number.last()}
    let serch_num(nm) = {
      if nm == current_subslide {
        return true
      } else{return false}
    }
     if type(number.find(serch_num))== "integer" {
       1
    } else {0}
    }
  }
  let w = cetz
   if visible(subslide_c.get().at(0)) == 1 {
      cetz.draw.content((1,0),[]) //for debug
    
       body
    } else {cetz.draw.hide(body, bounds:bounds)}
     
    }
  
    
   



#let onlya(number, body, mode:none) = {
    context[#{
    let current_subslide = subslide_c.get().at(0)
    let subslide_n = subslide.get().at(0)
    if current_subslide >= number {
      body
    } else {[#showstyles(mode:mode,body)]}
    if current_subslide == 0{
    if subslide_n < number {
      subslide.update(number)
    }}
}]
}



//空のボックス

#let bbox(title: none, bodyface: text, tlabel: none,body, boxcolor: "", title_color: "") ={
if boxcolor != "" or title_color != "" {tbox(title_color, boxcolor, title  ,body)}
else{return figure(kind:"TheoremKinds", supplement: none, caption:title, body) }
}

//ボタン

#let button(label,body, width:auto, height:auto, stroke:gradient.conic(..color.map.rainbow), fill:eastern) = {
  show ref: it => {
    box(stroke:1.5pt+stroke, radius: 10pt, fill:fill, width:width, height: height, inset:0.3em, baseline:5pt)[#align(center)[#text(size:0.8em, fill:white, weight: 700)[#link(it.target)[#body]]]]
  }
  ref(label)
}