#import "translation.typ": *

#let cap_body(it) = {if it != none {return it.body}
else {return it}
}

#let inactive_versions(name_varsion) = {
    let name_version(title: none, label:none, body) = {
        }
}


//autonumbering equations

#let tjk_numb_style(tag,tlabel,name,numbering:"(1)") = {
 if tag == true or name != none {
   if name == none{
   return  it => "("+str(tlabel)+")"}
   else {return it => "("+str(name)+")"}
 }
 else {
   return  numbering
 } 
}

#let tell_labels(it) ={
  if type(it) == "label"{return it}
  else {return label(str(it))} 
}

#let auto-numbering-equation(tlabel, name:none, tag:false,numbering:"(1)", body) ={
        locate(loc =>{
        let  eql = counter("tjk_auto-numbering-eq" + str(tlabel))
        if eql.final(loc).at(0) == 1{
          [#math.equation(numbering: tjk_numb_style(tag,tlabel,name,numbering:numbering),block: true)[#body]#tell_labels(tlabel)]
         if tag == true{counter(math.equation).update(i => i - 1)}
          }
        
        else {
         [#math.equation(numbering:none,block: true)[#body] ]
        }
      })
}

//shorthand
#let aeq = auto-numbering-equation

#let heading_supplement(it, supplement,thenumber,lang:"en") ={
   if lang == "jp" and supplement in trans.at("jp").keys() {
     return thenumber + trans.at("jp").at(supplement) 
   }
   else {return it}
 }

#let eq_refstyle(it,lang:"en") = {
  return  {
  let lbl = it.target
  let eq = math.equation
  let el = it.element
  let eql = counter("tjk_auto-numbering-eq"+str(lbl))
  eql.update(1)
  if el != none and el.func() == eq {
 
      link(lbl)[
      #numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      ) ]
  } else if el != none and el.has("counter") {
      let c_eq = el.counter
     if el.supplement.text in trans.at(lang).keys(){
    link(lbl)[
     #trans.at(lang).at(el.supplement.text) #numbering(
      el.numbering,
      ..c_eq.at(el.location())
    )]
  } else {it}
  } else if el != none and el.func() == heading {
    let thenumber = numbering(
        el.numbering,
        ..counter(heading).at(el.location())
      )
    link(lbl)[#heading_supplement(it, it.element.supplement.text, thenumber,lang:lang)
    ]
  }
    else {it}
  }
}


  


#let plurals(single,dict) ={
  if single in dict.keys() {
    return dict.at(single)
  }else {return single}
}



#let refs(..sink,dict:plurals_dic,add:" and ",comma:", ") = {
  let args = sink.pos()
  let numargs = args.len()
  let current_titles = ()
  let titles_dic = (:)
  if numargs == 1 {link(ref(args.at(0)).target)[#ref(args.at(0))]}
  else {
  show ref: it => plurals(it.element.supplement.text,dict)
  ref(args.at(0)) + " "
  show ref: it => {
     let c_eq = it.element.counter
      numbering(it.element.numbering,
      ..c_eq.at(it.element.location()))
  }
  if numargs == 2{link(ref(args.at(0)).target)[#ref(args.at(0))] + ""+ add +"" + link(ref(args.at(1)).target)[#ref(args.at(1))]}
  else{
  for i in range(numargs){
   if i< numargs - 1 {link(ref(args.at(i)).target)[#ref(args.at(i))] + comma+"" }
   else {add+"" + link(ref(args.at(i)).target)[#ref(args.at(i))]}
  }}
  }
}




#let counter_body(num) = {if num != none {return num.counter}
else {return num}}

//定理環境の基本設定：より高度な設定はLemmifyを用いる
  

#let my_thm_style(
  thm-type, name, number, body
) = block(width: 100%, breakable: true)[#{
  strong(thm-type) + " "
  if number != none {
    strong(number) 
  }
  if name  == none {"."}
  if name != none {
    " "+ [(#name).] + " "
  }
  " " + emph(body)
}]

#let my_defi_style(
  thm-type, name, number, body
) = block(width: 100%, breakable: true)[#{
  strong(thm-type) + " "
  if number != none {
    strong(number) 
  }
  if name  == none {"."}
  if name != none {
    " "+ [(#name).] + " "
  }
  " " + body
}]



#let my_proof_style(
  thm-type, name, number, body, lang
) =  block(width: 100%, breakable: true)[#{
  if name  == none {strong(trans.at(lang).at("Proof")) +"."}
  if name != none {
  [#strong[#proofname(name,lang)]] + " "
  }
  " " + body + [#h(1fr) #QERmark(lang)]}]


#let theorem_base(thm_style, kind, supplement) ={
  return{ (name:none, numbering:numbering,content) =>  figure(
    content,
    caption: name,
    kind: kind,
    supplement: supplement
  ) }
}


#let trans_thm(str,lang) = {
  if lang == "jp"  {
    return theorem_jp.at(str)
  }
  else {return str}
}

#let theorem_create(tlabel) = {
    return{theorem_base(my_thm_style, tlabel, tlabel)
    }
  }

#let theorem = theorem_create("Theorem")
#let prop = theorem_create("Proposition")
#let lemma = theorem_create("Lemma")
#let rem = theorem_create("Remark")
#let cor = theorem_create("Corollary")
#let claim = theorem_create("Claim")
#let fact = theorem_create("Fact")
#let defi = theorem_create("Definition")
#let assump = theorem_create("Assumption")
#let ex = theorem_create("Example")
#let proof = theorem_create("Proof")



#let theo_list = ("Theorem","Proposition","Lemma","Remark","Corollary","Claim","Fact")
#let defi_list = ("Definition","Assumption","Example")
#let others_list = ("Table","Figure")




#let content_remove_br(cont) = {
  if cont.has("body"){
    let valuecon = cont.body.at("children")
    let val_num = valuecon.len()
    let value = ""
    for i in range(1,val_num - 1 ) {
      value = value + valuecon.at(i)
      }
    return value
    }
    else {
      return cont
    }
  }

//conditional probability; different from phisyca Pr 
#let Pro(..sink) = {
  let args = sink.pos()
  let event = content_remove_br(args.at(0)) 
  if args.len() <= 1 {
    $op("Pr")(event)$ 
  }
  else {
  let condition = content_remove_br(args.at(1))
  $op("Pr")(event mid(|) condition)$ 
  }
}

#let argmax = $op("arg max", limits: #true)$
#let argmin = $op("arg min", limits: #true)$
#let cdot = $dot.c$
#let cdots = $dots.c$




//2player Normal form game
#let Ngame(players,strategies,payoffs,caption:none) = {
  
  let glist = ()   

  let g_list = strategies.at(1)
    g_list.insert(0,"")
    glist.push(g_list)

  for i in range(strategies.at(0).len()){
    let g_list = payoffs.at(i)
    g_list.insert(0,strategies.at(0).at(i))
    glist.push(g_list)  
  }
　return {
  table(columns: strategies.at(1).len()+2,
      align: center + horizon,
      stroke: (x,y) => (
        top: if y ==2 {1pt} else {0pt},
        left: if x==2 {1pt} else {0pt}
      ),
      [], table.cell(colspan: strategies.at(1).len()+1, players.at(1)),
          table.cell(rowspan: (strategies.at(0).len()+1), players.at(0)),
      ..glist.flatten()
    )  }
}

//Date functions




#let Today(style:"mdy-en") = {
  let y = datetime.today().year() 
  let m = datetime.today().month()
  let d = datetime.today().day()
  if style == "ymd-en" {
    return str(y)+" "+tjk_month_name.en.at(str(m))+" "+str(d)}
  if style == "mdy-en" {
    return tjk_month_name.en.at(str(m))+" "+str(d)+", "+str(y)}
  if style == "mdy-en-abr" {
    return tjk_month_name.en-abr.at(str(m))+" "+str(d)+", "+str(y)}
  if style == "ymd-jp" {
    return str(y)+"年"+ str(m)+"月"+str(d)+"日"}
  if style == "ymd-jp-nengou" {
    return tjk_wareki(y)+"年"+str(m)+"月"+str(d)+"日"}
  if style == "ymd-jp-wareki" {
    return tjk_wareki(y)+"年 "+tjk_month_name.jp.at(str(m))+str(d)+"日"}
  }
    
#let abstract_name = ("en": [#smallcaps[Abstract]], "jp":"概要")

#let Appendix(lang:"en",body) = {
  pagebreak()
  counter(heading).update(0)
  set heading(numbering: "A.1.")
  align(center)[#text(size: 2.0em)[#trans.at(lang).at("Appendix")]]
  body
}

//引用文献の機能の設定
//author, year という形にするもの
#let citealp(it) = {cite(it,form:"author")+", "+cite(it,form:"year")}
//同一著者のときに author(s) (year1, year2, and year3)のようにするもの
#let cites(..it) = {cite(it.pos().at(0), form:"author") + " ("
let n = it.pos().len()
let cyears = ()
for i in range(n) {
  cyears.push(cite(it.pos().at(i),form:"year"))
}
cyears.join(", ") + ")"
}